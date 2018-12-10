

package com.drakelee.demo.pm.service.user;

import com.base.components.cache.Cache;
import com.base.components.cache.CacheManager;
import com.base.components.common.constants.Valid;
import com.base.components.common.exception.business.BusinessException;
import com.base.components.common.exception.business.PasswordErrorException;
import com.base.components.common.exception.business.PasswordErrorLimitException;
import com.base.components.common.exception.business.SmsException;
import com.base.components.common.service.message.ChannelMessageSender;
import com.base.components.common.token.TokenManager;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.IpLocationUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.ObjectSetPropsUtil;
import com.base.components.common.util.PasswordUtil;
import com.base.components.common.util.RandomCodeHelper;
import com.base.components.common.util.UUIDUtils;
import com.base.components.common.util.ValidatorUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.base.components.database.service.AbstractJpaService;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.UserType;
import com.drakelee.demo.common.constants.msgqueue.channels.MessageChannel;
import com.drakelee.demo.common.constants.product.DataSource;
import com.drakelee.demo.common.constants.product.PayStatus;
import com.drakelee.demo.common.constants.sys.Gender;
import com.drakelee.demo.common.constants.transaction.TransactionChannel;
import com.drakelee.demo.common.constants.user.WorkStatus;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.common.token.user.UserToken;
import com.drakelee.demo.database.dao.user.BaseUserTypeDao;
import com.drakelee.demo.database.dao.user.UserBaseInfoDao;
import com.drakelee.demo.pm.service.oss.QiniuOssService;
import com.drakelee.demo.pm.service.region.RegionService;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Lists;
import me.chanjar.weixin.mp.api.WxMpService;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.lang.invoke.MethodHandles;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * UserBaseInfoService
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-16 11:26
 */
@Service
@RefreshScope
public class UserBaseInfoService extends AbstractJpaService<UserBaseInfo, String, UserBaseInfoDao> {
  private static final Logger logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
  @Autowired
  private CacheManager cacheManager;
  @Autowired
  private TokenManager tokenManager;
  @Autowired
  private UserCountOfTimeService userCountOfTimeService;

  @Value("${base.userPwdError.limit.countOfHour:3}")
  private int userPwdErrorCountOfHour;
  @Autowired
  private BaseUserTypeDao baseUserTypeDao;
  @Autowired
  private QiniuOssService qiniuOssService;
  @Autowired
  private ChannelMessageSender redisChannelMessageSender;
//  @Autowired
//  private PayService payService;
//  @Autowired
//  private AlipayService alipayService;
  @Autowired
  private WeChatService weChatService;
  @Autowired
  private RegionService regionService;
  @Autowired
  private ChannelMessageSender channelMessageSender;
  @Autowired
  private WxMpService mpService;
//  @Autowired
//  private UserWorkStatusChangeRecordDao userWorkStatusChangeRecordDao;
//  @Autowired
//  private CallMeReferrerDao callMeReferrerDao;
//  @Autowired
//  private ProductOrderService productOrderService;


  @Transactional(rollbackFor = Exception.class)
  public ObjectNode userLogin(UserBaseInfo user, Map<String, String> param, boolean checkLimit) {
    String loginIp = param.get("loginIp");
    if (user == null) {
      // 通过手机号登录
      user = loginByPhone(param, checkLimit);
    } else {
      Assert.notNull(loginIp, "登陆IP不能为空");
    }
    // 传入此参数时，该参数代表限定的用户类型，即该类型的用户才能登陆
    if (StringUtils.isNotEmpty(param.get("restrictType")) && !param.get("restrictType")
                                                                   .equals(String.valueOf(user.getUserType()))) {
      throw new IllegalArgumentException("该账号不存在!");
    }
    // 设置登录信息（登录IP、登录时间、选择地区等等）
    setLoginInfo(user, param, loginIp);
    // 登录时携带微信登录信息，则处理信息
    loginByWeChatHandle(user, param);
    getDao().save(user);
    UserType type = UserType.parse(user.getUserType());
    Assert.notNull(type, "用户登录类型匹配错误！");
    // 返回对象
    ObjectNode res = JsonUtils.createObjectNode();
    // 缓存usertoken并将用户信息添加至返回信息对象
    cacheTokenAndPutRes(user, type, res);
    // 发送登录事件
    sendLoginEvent(user);

    List<Map<String, Object>> rewards = Lists.newArrayList();
    // 首次登录自动抽奖活动
    if (isLoginFirstOfDayIncrease(user.getId()) && type.getCode() == UserType.USER.getCode()) {
      ObjectNode jsonNode = JsonUtils.createObjectNode();
      jsonNode.put("userId", user.getId());
      rewards = redisChannelMessageSender.sendSyncMessage(MessageChannel.AUTO_PROMOTION_FIRST_LOGIN, jsonNode);
    }
    // 分享登录活动
    String referrerId = param.get("referrerId");
    if (StringUtils.isNotEmpty(referrerId)) {
      ObjectNode jsonNode = JsonUtils.createObjectNode();
      jsonNode.put("userId", user.getId());
      jsonNode.put("referrerId", user.getReferrerUserId());
      rewards.addAll(redisChannelMessageSender.sendSyncMessage(MessageChannel.AUTO_PROMOTION_LOGIN, jsonNode));
      res.putPOJO("rewards", rewards);
    }
    return res;
  }

  /**
   * 发送登录事件
   *
   * @param user
   */
  private void sendLoginEvent(UserBaseInfo user) {
    ObjectNode objectNode = JsonUtils.createObjectNode();
    /*{{first.DATA}}
    帐号登录时间：{{keyword1.DATA}}
    帐号登录IP：{{keyword2.DATA}}
    {{remark.DATA}}*/
    objectNode.put("userName", user.getUserNickName());
    objectNode.put("targetId", user.getId());
    objectNode.put("localId", user.getId());
    objectNode.put("first", "您好，您账号已经登录");
    SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
    objectNode.put("keyword1", format.format(user.getLastLoginTime()));
    objectNode.put("keyword2", user.getLastLoginIp());
    objectNode.put("remark", "如果本次登录不是您本人所为，说明您的帐号已经被盗！为减少您的损失，请立即联系客服");
    redisChannelMessageSender.sendMessage(MessageChannel.USER_LOGIN, objectNode);
  }

  /**
   * 设置登录信息（登录IP、登录时间、选择地区等等）
   *
   * @param user
   * @param param
   * @param loginIp
   */
  private void setLoginInfo(UserBaseInfo user, Map<String, String> param, String loginIp) {
    user.setLastLoginTime(new Date());
    user.setLastLoginIp(loginIp);
    String selectRegionId = param.get("selectRegionId");
    if (StringUtils.isNotBlank(selectRegionId)) {
      Region region = regionService.findById(selectRegionId);
      if (region != null) {
        user.setSelectRegion(region.getName());
        user.setSelectRegionId(selectRegionId);
      }
    }
  }

  /**
   * 缓存usertoken并将用户信息添加至返回信息对象
   *
   * @param user
   * @param type
   * @param res
   */
  private void cacheTokenAndPutRes(UserBaseInfo user, UserType type, ObjectNode res) {
    UserToken userToken;
    try {
      userToken = (UserToken) type.getTokenType().getTypeClass().newInstance();
    } catch (Exception e) {
      throw new BusinessException("用户登录类型匹配错误！", e);
    }
    userToken.setUserId(user.getId());
    userToken.setLoginTime(user.getLastLoginTime());
    userToken.setUserNickName(user.getUserNickName());
    userToken.setPhone(user.getPhone());
    userToken.setToken(UUIDUtils.generateKey());
    userToken.setType(type.getCode());
    userToken.setTypeName(baseUserTypeDao.findNameByUserType(type.getCode()));

    userToken.setWxImg(user.getWxImg());
    userToken.setWxName(user.getWxName());
    userToken.setAvatar(user.getAvatar());
    tokenManager.cacheToken(userToken);
    ObjectNode returnNode = JsonUtils.convert(userToken, ObjectNode.class);
    returnNode.put("selectRegionId", user.getSelectRegionId());
    returnNode.put("selectRegion", user.getSelectRegion());
    returnNode.put("isFirstLoginOfDay", isLoginFirstOfDay(user.getId()));

    res.set("userToken", returnNode);
  }

  /**
   * 携带微信账号登录信息
   *
   * @param user
   * @param param
   */
  private void loginByWeChatHandle(UserBaseInfo user, Map<String, String> param) {
    officialAccountsHandle(user, param);
    miniProgramHandle(user, param);
  }

  /**
   * 携带小程序登录信息，处理信息
   *
   * @param user
   * @param param
   */
  private void miniProgramHandle(UserBaseInfo user, Map<String, String> param) {
    String miniOpenId = param.get("miniOpenId");
    logger.info("miniOpenId:" + miniOpenId + ",user_miniOpenId:" + StringUtils.isBlank(user.getMiniOpenId()));
    //为空时才设置openid
    if (StringUtils.isNotBlank(miniOpenId) && StringUtils.isBlank(user.getMiniOpenId())) {
      user.setMiniOpenId(miniOpenId);
      clearOtherMiniBind(miniOpenId, user.getPhone());
    }
  }

  /**
   * 携带公众号登录信息，处理信息
   *
   * @param user
   * @param param
   */
  private void officialAccountsHandle(UserBaseInfo user, Map<String, String> param) {
    String openId = param.get("openId");
    logger.info("openId:" + openId + ",user_openId:" + StringUtils.isBlank(user.getOpenId()));
    //为空时才设置openid
    if (StringUtils.isNotBlank(openId) && StringUtils.isBlank(user.getOpenId())) {
      String wxName = param.get("wxName");
      String wxImg = param.get("wxImg");
      user.setWxImg(wxImg);
      user.setWxName(wxName);
      user.setOpenId(openId);
      clearOtherBind(openId, user.getPhone());
    }
  }

  /**
   * 通过电话号码登录
   *
   * @param param
   * @param checkLimit
   *
   * @return
   */
  private UserBaseInfo loginByPhone(Map<String, String> param, boolean checkLimit) {
    UserBaseInfo user;
    String phone = param.get("phone");
    String pwd = param.get("pwd");
    String verifyCode = param.get("verifyCode");
    String errorLimitCode = param.get("errorLimitCode");
    Assert.isTrue(StringUtils.isNotBlank(pwd) || StringUtils.isNotBlank(verifyCode), "请输入密码");
    user = getDao().findByPhoneOrPhone2(phone,phone);
    Assert.notNull(user, "未找到用户（"+phone+"）");
    Assert.isTrue(user.getStatus() == Valid.TRUE.getVal(), "账户已禁用");
    Assert.isTrue(user.getUserType() != UserType.UNKNOWN.getCode(), "账户未分配角色");
    String account = user.getPhone();
    //密码登录
    if (StringUtils.isNotBlank(pwd) && StringUtils.isEmpty(errorLimitCode)) {
      if (checkLimit) {
        if (userCountOfTimeService.checkIsUserPwdErrorLimit(CacheName.PASSWORD_ERROR, account)) {
          throw new PasswordErrorLimitException(
            SmsException.ErrorCode.password_error_limit.getInfo().replace("{count}", userPwdErrorCountOfHour + ""),
            SmsException.ErrorCode.password_error_limit.getCode()
          );
        }
      }
      boolean pwdChecked = pwd.equals(PasswordUtil.decryptPassword(account, user.getPwd()));
      if (!pwdChecked) {
        throw new PasswordErrorException("密码错误");
      } else {
        userCountOfTimeService.removeUserPwdErrorLimit(CacheName.PASSWORD_ERROR, account);
      }
    }
    //密码+验证码登录
    if (StringUtils.isNotBlank(pwd) && StringUtils.isNotEmpty(errorLimitCode)) {
      Cache cache = cacheManager.getCache(CacheName.PRE_SMS_ERROR_PASSWORD_CODE_LG);
      String cachedErrorCode = cache.get(errorLimitCode, String.class);
      RandomCodeHelper.checkCacheCode(errorLimitCode, cachedErrorCode, "验证码错误");
      boolean pwdChecked = pwd.equals(PasswordUtil.decryptPassword(account, user.getPwd()));
      if (pwdChecked) {
        cache.evict(errorLimitCode);
        userCountOfTimeService.removeUserPwdErrorLimit(CacheName.PASSWORD_ERROR, account);
      } else {
        throw new PasswordErrorException("密码错误");
      }
    }
    //短信登录
    else if (StringUtils.isNotBlank(verifyCode) && StringUtils.isEmpty(pwd)) {
      Cache cache = cacheManager.getCache(CacheName.VERIFY_CODE_LG);
      String cachedVerifyCode = cache.get(phone, String.class);
      RandomCodeHelper.checkCacheCode(verifyCode, cachedVerifyCode, "短信验证码错误");
      cache.evict(phone);
    }
    return user;
  }

  /**
   * 用户登录
   *
   * @param param -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> passwd       - Nullable  - Str - 登录密码，与verifycode不能都为空
   * <p> verifyCode   - Nullable  - Str - 短信验证码，与passwd不能都为空，见 /edges/sms/code
   * <p> loginIp      - Nullable - Str - 登录IP
   *
   * @return UserToken
   */
  @Transactional(rollbackFor = Exception.class)
  public ObjectNode userLogin(Map<String, String> param) {
    return userLogin(null, param, true);
  }


  /**
   * 输入错误密码，累加次数
   *
   * @param param -
   * <p> phone        - Notnull  - Str - 手机号
   */
  @Transactional(rollbackFor = Exception.class)
  public void userLoginPasswordError(Map<String, String> param) {
    String phone = param.get("phone");
    UserBaseInfo user = getDao().findByPhone(phone);
    if (user != null) {
      user.setPasswordErrors(user.getPasswordErrors() == null ? 1 : user.getPasswordErrors() + 1);
      getDao().saveAndFlush(user);
      userCountOfTimeService.userPwdErrorCount(CacheName.PASSWORD_ERROR, phone);
    }
  }


  /**
   * 用户注册, 并登录
   *
   * @param param -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> passwd       - Notnull  - Str - 登录密码
   * <p> registIp     - Nullable - Str - 注册IP
   * <p> referrerId   - Nullable - Str - 推荐人id
   *
   * @return UserInfo
   */
  @Transactional(rollbackFor = Exception.class)
  public ObjectNode userRegister(Map<String, String> param) {
    String phone = ConvertUtil.checkNotNull(param, "phone", "手机号不能为空", String.class);
    Assert.isTrue(ValidatorUtil.isPhoneNum(phone), "手机格式不正确");
    ConvertUtil.checkNotNull(param, "pwd", "密码不能为空", String.class);
    String verifyCode = ConvertUtil.checkNotNull(param, "verifyCode", "短信验证码不能为空", String.class);
    Cache cache = cacheManager.getCache(CacheName.VERIFY_CODE_RG);
    String cachedVerifyCode = cache.get(phone, String.class);
    RandomCodeHelper.checkCacheCode(verifyCode, cachedVerifyCode, "短信验证码错误");
    cache.evict(phone);
    Assert.isTrue(!checkExists(phone), "该手机用户已注册");
    String pwd = param.get("pwd");
    String registIp = param.get("registIp");
    String wxName = param.get("wxName");
    String wxImg = param.get("wxImg");
    String openId = param.get("openId");
    String referrerId = param.get("referrerId");

    String[] address = IpLocationUtil.find(registIp);

    Date now = new Date();
    String userNickName = "和" + phone.substring(phone.length() - 4);
    //用户主表
    UserBaseInfo userBase = new UserBaseInfo();
    userBase.setPhone(phone);
    userBase.setUserNickName(userNickName);
    userBase.setPwd(PasswordUtil.encryptPassword(phone, pwd));
    userBase.setGender(Gender.unknown.getCode());
    userBase.setUserType(UserType.USER.getCode());
    userBase.setUserTypeId(baseUserTypeDao.findIdByUserType(UserType.USER.getCode()));
    userBase.setRegistTime(now);
    userBase.setRegistIp(registIp);
    userBase.setRegistRegion(StringUtils.join(address, "-"));
    String regionId = regionService.getRegionId(address);
    userBase.setRegionId(regionId == null ? "" : regionId);
    userBase.setPasswordErrors(0);
    userBase.setStatus(Valid.TRUE.getVal());
    userBase.setLastLoginIp("");
    userBase.setWorkStatus(WorkStatus.working.getVal());
    userBase.setBalance(new BigDecimal(0));
    userBase.setRemark("");
    userBase.setWxName(wxName);
    userBase.setWxImg(wxImg);
    userBase.setOpenId(openId);
    String isMobile = param.get("isMobile");
    userBase.setDataSource(StringUtils.isBlank(isMobile) ? DataSource.PC.getVal() : Integer.valueOf(isMobile));
    String selectRegionId = param.get("selectRegionId");
    if (StringUtils.isNotBlank(selectRegionId)) {
      Region region = regionService.findById(selectRegionId);
      if (region != null) {
        userBase.setSelectRegion(region.getName());
        userBase.setSelectRegionId(selectRegionId);
      }
    }
    if (StringUtils.isNotBlank(openId)) {
      clearOtherBind(openId, phone);
    }

    getDao().saveAndFlush(userBase);

    // 分享注册活动
    if (StringUtils.isNotEmpty(referrerId)) {
      ObjectNode jsonNode = JsonUtils.createObjectNode();
      jsonNode.put("userId", userBase.getId());
      jsonNode.put("referrerId", userBase.getReferrerUserId());
      channelMessageSender.sendMessage(MessageChannel.AUTO_PROMOTION_REGISTER, jsonNode);
    }

    return userLogin(param);
  }


  @Transactional(rollbackFor = Exception.class)
  public ObjectNode selectRegion(String userId, String regionId) {
    Assert.hasText(userId, "用户未找到");
    Assert.hasText(regionId, "请设置区域");
    UserBaseInfo user = findById(userId);
    Assert.notNull(user, "用户未找到");
    Region region = regionService.findById(regionId);
    Assert.notNull(region, "区域未找到");
    Assert.isTrue(region.getLeaf() != null && Valid.TRUE.getVal() == region.getLeaf(), "请选择末级区域");
    user.setSelectRegionId(regionId);
    user.setSelectRegion(region.getName());
    getDao().saveAndFlush(user);
    return JsonUtils.createObjectNode().put("selectRegionId", regionId).put("selectRegion", region.getName());
  }


  /**
   * 用户修改密码
   *
   * @param param -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> pwd          - Notnull  - Str - 新登录密码
   * <p> oldPwd       - Nullable  - Str - 旧密码，非空时会验证
   */
  @Transactional(rollbackFor = Exception.class)
  public void changePassword(Map<String, String> param) {
    String phone = ConvertUtil.checkNotNull(param, "phone", "手机号不能为空", String.class);
    Assert.isTrue(ValidatorUtil.isPhoneNum(phone), "手机格式不正确");
    UserBaseInfo user = getDao().findByPhoneOrPhone2(phone,phone);
    Assert.notNull(user, "未找到用户（"+phone+"）");
    String pwd = ConvertUtil.checkNotNull(param, "pwd", "新密码不能为空", String.class);
    if (!param.containsKey("oldPwd")) {
      String verifyCode = ConvertUtil.checkNotNull(param, "verifyCode", "短信验证码不能为空", String.class);
      Cache cache = cacheManager.getCache(CacheName.VERIFY_CODE_CP);
      String cachedVerifyCode = cache.get(phone, String.class);
      RandomCodeHelper.checkCacheCode(verifyCode, cachedVerifyCode, "短信验证码错误");
      cache.evict(phone);
    } else {
      String oldPwd = param.get("oldPwd");
      Assert.hasText(oldPwd, "旧密码不能为空");
      if(user.getUserType().equals(UserType.DISTRIBUTION_ADMIN.getCode())){
        phone = user.getPhone();
      }
      Assert.isTrue(PasswordUtil.decryptPassword(phone, user.getPwd()).equals(oldPwd), "旧密码不正确");
      Assert.isTrue(!oldPwd.equals(pwd), "新旧密码不能一样");
    }
    user.setPwd(PasswordUtil.encryptPassword(phone, pwd));
    getDao().saveAndFlush(user);
  }

  /**
   * 修改手机号
   *
   * @param param -
   * <p> userId        - Notnull  - Str - userId
   * <p> phone         - Notnull  - Str - 新手机
   * <p> verifyCode    - Notnull  - Str - 新手机接收验证码
   */
  @Transactional(rollbackFor = Exception.class)
  public UserBaseInfo updateUserPhone(Map<String, String> param) {
    String phone = param.get("phone");
    Assert.isTrue(!checkExists(phone), "该手机用户已注册");
    String verifyCode = param.get("verifyCode");
    Cache cache = cacheManager.getCache(CacheName.VERIFY_CODE_PHONE);
    String cachedVerifyCode = cache.get(phone, String.class);
    RandomCodeHelper.checkCacheCode(verifyCode, cachedVerifyCode, "短信验证码错误");
    cache.evict(phone);
    UserBaseInfo user = findById(param.get("userId"));
    Assert.notNull(user, "未找到用户（"+phone+"）");
    String oldPhone = user.getPhone();
    String pwd = PasswordUtil.decryptPassword(oldPhone, user.getPwd());
    if(!ValidatorUtil.isPhoneNum(user.getPhone())){
      user.setPwd(PasswordUtil.encryptPassword(user.getPhone(), pwd));
      user.setPhone2(phone);
    }else {
      user.setPwd(PasswordUtil.encryptPassword(phone, pwd));
      user.setPhone(phone);
    }
    getDao().saveAndFlush(user);
    return user;
  }


  /**
   * 检查手机号是否存在
   *
   * @param phone
   *
   * @return true=存在, false=不存在
   */
  public boolean checkExists(String phone) {
    Assert.hasText(phone, "手机号为空");
    ConditionGroup<UserBaseInfo> build = ConditionGroup.build(ConditionEnum.Link.LINK_OR);
    build.addCondition("phone", ConditionEnum.OPERATE_EQUAL, phone);
    build.addCondition("phone2", ConditionEnum.OPERATE_EQUAL, phone);
    long count = getDao().count(build);
    return count > 0;
  }

  public UserBaseInfo findUserByPhone(String phone) {
    return getDao().findByPhone(phone);
  }


  /**
   * 完善用户信息
   *
   * @param userId
   * @param params -
   * <p>  userNickName             - Nullable  - Str - 姓名
   * <p>  gender                   - Nullable  - Int - 性别
   * <p>  birth                    - Nullable  - Str - 生日
   * <p>  userEmail                - Nullable  - Str - 邮箱
   * <p>  avatar                   - Nullable  - Str - 头像
   * <p>  selectRegionId           - Nullable  - Str - 用户选择的地区Id
   * <p>  selectRegion             - Nullable  - Str - 用户选择的地区
   */
  @Transactional(rollbackFor = Exception.class)
  public void completeInfo(String userId, Map<String, String> params) {
    Assert.notNull(userId, "无用户信息");
    Optional<UserBaseInfo> optional = getDao().findById(userId);
    Assert.isTrue(optional.isPresent(), "未查到用户信息");
    UserBaseInfo userBaseInfo = optional.get();
    Assert.notEmpty(params, "未传任何信息");
    String userNickName = params.get("userNickName");
    if (StringUtils.isNotEmpty(userNickName)) {
      userBaseInfo.setUserNickName(userNickName);
    }
    String gender = params.get("gender");
    if (StringUtils.isNotEmpty(gender)) {
      userBaseInfo.setGender(Integer.valueOf(gender));
    }
    String birth = params.get("birth");
    if (StringUtils.isNotEmpty(birth)) {
      userBaseInfo.setBirth(birth);
    }
    String profile = params.get("profile");
    if (StringUtils.isNotEmpty(profile)) {
      userBaseInfo.setProfile(profile);
    }
    String userEmail = params.get("userEmail");
    if (StringUtils.isNotEmpty(userEmail) && StringUtils.isEmpty(userBaseInfo.getUserEmail())) {
      Assert.isTrue(checkEmail(userEmail), "邮箱格式错误");
      userBaseInfo.setUserEmail(userEmail);
    }
    String selectRegionId = params.get("selectRegionId");
    if (StringUtils.isNotEmpty(selectRegionId)) {
      userBaseInfo.setSelectRegionId(selectRegionId);
    }
    String selectRegion = params.get("selectRegion");
    if (StringUtils.isNotEmpty(selectRegion)) {
      userBaseInfo.setSelectRegion(selectRegion);
    }
    String avatar = params.get("avatar");
    if (StringUtils.isNotEmpty(avatar) && avatar.indexOf("/temp/") == 0) {
      //头像持久化
      ArrayNode arrayNode = JsonUtils.mapper.createArrayNode();
      ObjectNode objectNode = JsonUtils.mapper.createObjectNode();
      objectNode.put("name", userBaseInfo.getUserNickName());
      objectNode.put("url", avatar);
      arrayNode.add(objectNode);
      ArrayNode re = qiniuOssService.persistent("", "", arrayNode);
      if (re != null && re.size() != 0) {
        avatar = re.get(0).get("url").asText();
      }
      userBaseInfo.setAvatar(avatar);
    }
    getDao().saveAndFlush(userBaseInfo);
  }


  /**
   * 获取用户资料(去除敏感信息)
   *
   * @param userId
   *
   * @return
   */
  public UserBaseInfo findUserInfoWithoutPwdById(String userId) {
    Optional<UserBaseInfo> optional = getDao().findById(userId);
    if (optional.isPresent()) {
      UserBaseInfo userBaseInfo = optional.get();
      userBaseInfo = ObjectSetPropsUtil
        .setPropsNull(userBaseInfo, true, "pwd", "passwordErrors", "lastLoginIp", "registIp", "registTime", "payPwd");
      return userBaseInfo;
    }
    return null;
  }

  /**
   * 查询用户信息-返回简单信息
   *
   * @param userId
   *
   * @return
   */
  public Map userInfoSimple(String userId) {
    Assert.notNull(userId, "用户Id不能为空");
    return getDao().userInfoSimple(userId);
  }


  /**
   * 根据电话和用户类型查询客户经理或者服务人员或者资深顾问（一天限三次）
   *
   * <p>  userId              - NotNull   - Str - 发起查询的用户id
   * <p>  phone               - NotNull   - Str - 待查询的用户电话
   * <p>  userType            - NotNull   - Int - 待查询的用户类型
   *
   * @return
   */
  public UserBaseInfo findManagerServicerExpert(String userId, String phone, Integer userType, CacheName cacheName) {
    Boolean isLimit = userCountOfTimeService.checkIsUserSearchLimit(cacheName, userId);
    Assert.isTrue(!isLimit, "当天超过可查询限制");
    Optional<UserBaseInfo> optional = getDao().findOne(
      ConditionGroup.build().addCondition("phone", ConditionEnum.OPERATE_EQUAL, phone)
                    .addCondition("userType", ConditionEnum.OPERATE_EQUAL, userType)
                    .addCondition("status", ConditionEnum.OPERATE_EQUAL, Valid.TRUE.getVal())
                    .addCondition("workStatus", ConditionEnum.OPERATE_EQUAL, WorkStatus.working.getVal()));
    if (optional.isPresent()) {
      UserBaseInfo userBaseInfo = optional.get();
      userBaseInfo = ObjectSetPropsUtil
        .setPropsNull(userBaseInfo, true, "balance", "pwd", "passwordErrors", "lastLoginIp", "registIp", "registTime",
                      "lastLoginTime", "birth", "openId", "payPwd"
        );
      return userBaseInfo;
    } else {
      return null;
    }
  }


  /**
   * 修改用户邮箱
   *
   * @param userId
   * @param email
   * @param verifyCode
   */
  @Transactional(rollbackFor = Exception.class)
  public void updateUserEmail(String userId, String email, String verifyCode, String oldEmail) {
    Assert.isTrue(checkEmail(email), "邮箱格式错误");
    UserBaseInfo user = findById(userId);
    Assert.notNull(user, "未查到用户");
    if (StringUtils.isNotEmpty(oldEmail)) {
      Assert.isTrue(oldEmail.equals(user.getUserEmail()), "原邮箱不正确");
    }
    String phone = user.getPhone();
    Assert.notNull(phone, "用户接受短信的电话不正确");
    Cache cache = cacheManager.getCache(CacheName.VERIFY_CODE_EMAIL);
    String cachedVerifyCode = cache.get(phone, String.class);
    RandomCodeHelper.checkCacheCode(verifyCode, cachedVerifyCode, "短信验证码错误");
    cache.evict(phone);
    user.setUserEmail(email);
    getDao().saveAndFlush(user);
  }


  /**
   * 第一次设置用户邮箱
   *
   * @param userId
   * @param email
   */
  @Transactional(rollbackFor = Exception.class)
  public void setUserEmail(String userId, String email) {
    Assert.isTrue(checkEmail(email), "邮箱格式错误");
    UserBaseInfo user = findById(userId);
    Assert.notNull(user, "未查到用户");
    Assert.isTrue(StringUtils.isEmpty(user.getUserEmail()), "已存在邮箱，请走修改流程");
    user.setUserEmail(email);
    getDao().saveAndFlush(user);
  }

  private static final Pattern emailPattern = Pattern
    .compile("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$");

  public boolean checkEmail(String email) {
    Matcher m = emailPattern.matcher(email);
    return m.matches();
  }


  public String findPhoneById(String targetId) {
    return getDao().findPhoneById(targetId);
  }

  @Transactional
  public ObjectNode getPayStatusWithPromotion(String type, String queryNo, TransactionChannel transactionChannel)
    throws Exception {
    int payStatus = getPayStatus(type, queryNo, transactionChannel);
    ObjectNode res = JsonUtils.createObjectNode();
    res.put("payStatus", payStatus);
    if (payStatus == PayStatus.pay_success.getVal()) {
//      ProductOrder productOrder = productOrderService.findByOrderCode(queryNo);
      ObjectNode jsonNode = JsonUtils.createObjectNode();
      jsonNode.put("userId", TokenThreadLocal.getTokenObjNonNull().objId().toString());
//      jsonNode.put("refId", productOrder.getId());
      List<Map<String, Object>> rewards = channelMessageSender
        .sendSyncMessage(MessageChannel.AUTO_PROMOTION_ORDER, jsonNode);

      // 推荐/分享好友消费送现金
      UserBaseInfo userBaseInfo = findById(TokenThreadLocal.getTokenObjNonNull().objId().toString());
      jsonNode.put("referrerId", userBaseInfo.getReferrerUserId());
//      jsonNode.put("payAmount", productOrder.getPayAmount());
      channelMessageSender.sendMessage(MessageChannel.AUTO_PROMOTION_ORDER, jsonNode);
      res.putPOJO("rewards", rewards);
    }
    return res;
  }

  public int getPayStatus(String type, String queryNo, TransactionChannel transactionChannel) throws Exception {
//    Map<String, Object> payInfo = payService.queryPayInfo(transactionChannel, queryNo);
//    return getPayResult(type, queryNo, transactionChannel, payInfo);
    return -1;
  }



  /**
   * 判断当日是否登录过并增加1
   *
   * @param userId
   *
   * @return
   */
  public boolean isLoginFirstOfDayIncrease(String userId) {
    Cache cache = cacheManager.getCache(CacheName.FIRST_LOGIN_OF_DAY);
    Integer count = cache.get(userId, Integer.class);
    if (count == null) {
      count = 1;
    } else {
      count++;
    }
    Date expireDate = DateTime.now().millisOfDay().withMaximumValue().toDate();
    cache.put(userId, count);
    cache.expireAt(userId, expireDate);
    return count == 1 ? true : false;
  }


  /**
   * 判断当日是否登录过
   *
   * @param userId
   *
   * @return
   */
  public boolean isLoginFirstOfDay(String userId) {
    Cache cache = cacheManager.getCache(CacheName.FIRST_LOGIN_OF_DAY);
    Integer count = cache.get(userId, Integer.class);
    boolean isFirst = false;
    if (count == null) {
      isFirst = true;
    }
    return isFirst;
  }

  @Transactional(rollbackFor = Exception.class)
  public void clearOtherBind(String openId, String phone) {
    getDao().clearOtherBind(openId, phone);
  }

  @Transactional(rollbackFor = Exception.class)
  public void clearOtherMiniBind(String miniOpenId, String phone) {
    getDao().clearOtherMiniBind(miniOpenId, phone);
  }
}
