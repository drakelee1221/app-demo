

package com.drakelee.demo.pm.controller.user;

import com.base.components.cache.CacheManager;
import com.base.components.common.exception.business.BusinessException;
import com.base.components.common.exception.business.PasswordErrorException;
import com.base.components.common.exception.business.PasswordErrorLimitException;
import com.base.components.common.token.RequireToken;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.BrowserUtil;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.IPUtils;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.PasswordUtil;
import com.base.components.common.util.ServletContextHolder;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.UserType;
import com.drakelee.demo.common.constants.product.DataSource;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.constants.transaction.TransactionChannel;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.common.token.user.DistributionAdminToken;
import com.drakelee.demo.common.token.user.DistributionUserToken;
import com.drakelee.demo.common.token.user.UserExpertToken;
import com.drakelee.demo.common.token.user.UserManagerToken;
import com.drakelee.demo.common.token.user.UserServiceToken;
import com.drakelee.demo.common.token.user.UserToken;
import com.drakelee.demo.feign.client.pm.UserClient;
import com.drakelee.demo.pm.service.sys.SysMessageService;
import com.drakelee.demo.pm.service.user.UserBaseInfoService;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Maps;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.lang.invoke.MethodHandles;
import java.util.Map;

/**
 * UserController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-10 17:44
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
@RefreshScope
public class UserController implements UserClient {
  private static final Logger logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
  @Autowired
  private UserBaseInfoService userBaseInfoService;
  @Autowired
  private SysMessageService sysMessageService;
//  @Autowired
//  private ServiceConsultService serviceConsultService;
//  @Autowired
//  private ProductOrderService productOrderService;
//  @Autowired
//  private ProductServiceService productServiceService;
//  @Autowired
//  private UserEvaluateService userEvaluateService;
  @Autowired
  private CacheManager cacheManager;


  /**
   * 用户登录
   *
   * @param params -
   * <p> phone              - Notnull   - Str - 手机号
   * <p> pwd                - Nullable  - Str - 登录密码，与verifyCode不能都为空
   * <p> verifyCode         - Nullable  - Str - 短信验证码，与pwd不能都为空，见 /edge/sms/code
   * <p> selectRegionId     - Nullable - Str -  选择的地区ID
   *
   * @return UserToken
   */
  @Override
  @PostMapping(value = "/user/login", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<ObjectNode> userLogin(@RequestBody Map<String, String> params) {
    HttpServletRequest request = ServletContextHolder.getRequestNonNull();
    String phone = ConvertUtil.checkNotNull(params, "phone", "手机号不能为空", String.class);
//    Assert.isTrue(ValidatorUtil.isPhoneNum(phone), "手机格式不正确");
    params.put("loginIp", IPUtils.getRealIp(request));
    try {
      ObjectNode res = userBaseInfoService.userLogin(params);
      return new ResponseEntity<>(res, HttpStatus.CREATED);
    } catch (PasswordErrorException e) {
      userBaseInfoService.userLoginPasswordError(params);
      throw new IllegalArgumentException(e.getMessage());
    } catch (PasswordErrorLimitException e) {
      throw new BusinessException(e.getMessage(), e.getErrorCode());
    }
  }

  /**
   * 根据token获取微信登录的平台用户对象
   * @param params -
   * <p> token        - Notnull  - Str - token
   * @return ObjectNode
   */
  @GetMapping(value = "/user/token-type/user", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userByToken(@RequestParam Map<String,String> params){
    return byToken(params, WeChatController.WX_AUTO_LOGIN_TOKEN_TYPE_USER);
  }

  /**
   * 根据token获取微信登录的微信用户对象
   * @param params -
   * <p> token        - Notnull  - Str - token
   * @return WxMpUser
   */
  @GetMapping(value = "/user/token-type/wx", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity openIdByToken(@RequestParam Map<String,String> params){
    return byToken(params, WeChatController.WX_AUTO_LOGIN_TOKEN_TYPE_WX);
  }

  private ResponseEntity byToken(Map<String,String> params, String type){
    String token = params.get("token");
    Object cached = null;
    if(StringUtils.isNotBlank(token)){
      try {
        if(WeChatController.WX_AUTO_LOGIN_TOKEN_TYPE_USER.equals(type)){
          cached = cacheManager.getCache(CacheName.WECHAT_LOGIN_TOKENOBJ).get(token, ObjectNode.class);
        }else{
          cached = cacheManager.getCache(CacheName.WECHAT_LOGIN_TOKENOBJ).get(token, WxMpUser.class);
        }
      } catch (Exception ignore) {
      }

      if(cached != null){
        cacheManager.getCache(CacheName.WECHAT_LOGIN_TOKENOBJ).evict(token);
        return new ResponseEntity<>(cached, HttpStatus.OK);
      }
    }
    return new ResponseEntity<>(JsonUtils.createObjectNode(), HttpStatus.OK);
  }

  /**
   * 用户注册
   *
   * @param params -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> pwd          - Notnull  - Str - 登录密码
   * <p> verifyCode   - Notnull  - Str - 短信验证码，见 /edges/sms/code
   * <p> referrerId   - Nullable - Str - 推荐人id
   *
   * @return UserToken
   */
  @PostMapping(value = "/user/register", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userRegister(@RequestBody Map<String, String> params, HttpServletRequest request) {
    params.put("registIp", IPUtils.getRealIp(request));
    int i = BrowserUtil.isMobile(request) ? DataSource.MOBILE.getVal() : DataSource.PC.getVal();
    params.put("isMobile", String.valueOf(i));
    ObjectNode res = userBaseInfoService.userRegister(params);
    return new ResponseEntity<>(res, HttpStatus.CREATED);
  }

  /**
   * 用户修改密码
   *
   * @param params -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> pwd          - Notnull  - Str - 新登录密码
   * <p> oldPwd       - Nullable  - Str - 旧密码，如果不填则通过手机短信验证
   * <p> verifyCode   - Nullable  - Str - 短信验证码，见 /edges/sms/code
   *
   * @return UserToken
   */
  @PutMapping(value = "/user/password", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userChangePassword(@RequestBody Map<String, String> params, HttpServletRequest request) {
    params.put("loginIp", IPUtils.getRealIp(request));
    userBaseInfoService.changePassword(params);
    //修改密码完成后，重新登录返回token
    ObjectNode userToken = userBaseInfoService.userLogin(null, params, false);
    return new ResponseEntity<>(userToken.get("userToken"), HttpStatus.OK);
  }


  /**
   * 修改用户手机
   *
   * @param params -
   * <p> phone             - Notnull  - Str - 新手机
   * <p> verifyCode        - Notnull  - Str - 新手机接收验证码
   *
   * @return
   */
  @PutMapping(value = "/user/phone", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class,
    DistributionUserToken.class, DistributionAdminToken.class})
  public ResponseEntity updatePhone(@RequestBody Map<String, String> params) {
    ConvertUtil.checkNotNull(params, "phone", "手机不能为空", String.class);
    ConvertUtil.checkNotNull(params, "verifyCode", "验证码不能为空", String.class);
    params.put("userId", TokenThreadLocal.getTokenObjNonNull().objId().toString());
    UserBaseInfo user = userBaseInfoService.updateUserPhone(params);
    Map<String, String> paramsLogin = Maps.newHashMap();
    paramsLogin.put("phone", user.getPhone());
    paramsLogin.put("pwd", PasswordUtil.decryptPassword(user.getPhone(), user.getPwd()));
    ObjectNode userToken = userBaseInfoService.userLogin(null, paramsLogin, false);
    return new ResponseEntity<>(userToken.get("userToken"), HttpStatus.CREATED);
  }


  /**
   * 完善资料
   *
   * @param params -
   * <p>  userNickName             - Nullable  - Str - 姓名
   * <p>  gender                   - Nullable  - Int - 性别
   * <p>  birth                    - Nullable  - Str - 生日
   * <p>  userEmail                - Nullable  - Str - 邮箱
   * <p>  avatar                   - Nullable  - Str - 头像
   * <p>  selectRegionId           - Nullable  - Str - 用户选择的地区Id
   * <p>  selectRegion             - Nullable  - Str - 用户选择的地区
   *
   * @return
   */
  @PutMapping(value = "/user/info", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity completeInfo(@RequestBody Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    userBaseInfoService.completeInfo(userId, params);
    return new ResponseEntity(HttpStatus.CREATED);
  }


  /**
   * 获取当前用户个人资料(去除敏感信息)
   *
   * @param params
   *
   * @return
   */
  @GetMapping(value = "/user/info", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userInfo(@RequestParam Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    UserBaseInfo userBaseInfo = userBaseInfoService.findUserInfoWithoutPwdById(userId);
    return new ResponseEntity<>(userBaseInfo, HttpStatus.OK);
  }

  /**
   * 获取用户详情
   *
   * @param id
   *
   * @return
   */
  @GetMapping(value = "/user/info/{id}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userInfo(@PathVariable("id") String id) {
    UserBaseInfo userBaseInfo = userBaseInfoService.findUserInfoWithoutPwdById(id);
    return new ResponseEntity<>(userBaseInfo, HttpStatus.OK);
  }

  /**
   * 根据Id获取用户简略详情
   *
   * @param userId
   *
   * @return
   */
  @GetMapping(value = "/user/info/simple", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class, DistributionUserToken.class})
  public ResponseEntity userInfoSimple(String userId) {
    return new ResponseEntity<>(userBaseInfoService.userInfoSimple(userId), HttpStatus.OK);
  }


  /**
   * 根据电话搜索客户经理（同一个用户一天最多搜索三次）
   *
   * @param params -
   * <p>  phone                     - Notnull   -Str  -电话
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class})
  @GetMapping(value = "/user/manager", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userManager(@RequestParam Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    String phone = ConvertUtil.checkNotNull(params, "phone", "电话不能为空", String.class);
    UserBaseInfo userBaseInfo = userBaseInfoService
      .findManagerServicerExpert(userId, phone, UserType.MANAGER.getCode(), CacheName.MANAGER_SEARCH);
    return new ResponseEntity<>(userBaseInfo, HttpStatus.OK);
  }


  /**
   * 根据电话搜索专业的资深顾问（同一个用户一天最多搜索三次）
   *
   * @param params -
   * <p>  phone                     - Notnull   -Str  -电话
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class})
  @GetMapping(value = "/user/expert", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userExpert(@RequestParam Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    String phone = ConvertUtil.checkNotNull(params, "phone", "电话不能为空", String.class);
    UserBaseInfo userBaseInfo = userBaseInfoService
      .findManagerServicerExpert(userId, phone, UserType.EXPERT.getCode(), CacheName.EXPERT_SEARCH);
    return new ResponseEntity<>(userBaseInfo, HttpStatus.OK);
  }


  /**
   * 根据电话搜索专业的服务人员（同一个用户一天最多搜索三次）
   *
   * @param params -
   * <p>  phone                     - Notnull   -Str  -电话
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class})
  @GetMapping(value = "/user/servicer", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userServicer(@RequestParam Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    String phone = ConvertUtil.checkNotNull(params, "phone", "电话不能为空", String.class);
    UserBaseInfo userBaseInfo = userBaseInfoService
      .findManagerServicerExpert(userId, phone, UserType.SERVICE.getCode(), CacheName.SERVICER_SEARCH);
    return new ResponseEntity<>(userBaseInfo, HttpStatus.OK);
  }


  /**
   * 获取邮箱绑定状态
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class, DistributionUserToken.class})
  @GetMapping(value = "/user/email/status", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity userEmailStatus() {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    UserBaseInfo userBaseInfo = userBaseInfoService.findUserInfoWithoutPwdById(userId);
    Boolean status = true;
    if (userBaseInfo != null && StringUtils.isBlank(userBaseInfo.getUserEmail())) {
      status = false;
    }
    Map<String, Boolean> res = Maps.newHashMap();
    res.put("status", status);
    return new ResponseEntity<>(res, HttpStatus.OK);
  }


  /**
   * 修改用户邮箱
   *
   * @param params -
   * <p> email             - Notnull  - Str - 新邮箱
   * <p> verifyCode        - Notnull  - Str - 手机接收的验证码
   * <p> oldEmail          - Nullable  - Str - 原邮箱
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class, DistributionUserToken.class})
  @PutMapping(value = "/user/email/edit", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity updateUserEmail(@RequestBody Map<String, String> params) {
    String email = ConvertUtil.checkNotNull(params, "email", "邮箱不能为空", String.class);
    String verifyCode = ConvertUtil.checkNotNull(params, "verifyCode", "验证码不能为空", String.class);
    String oldEmail = ConvertUtil.convertNullable(params.get("oldEmail"),String.class);
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    userBaseInfoService.updateUserEmail(userId, email, verifyCode ,oldEmail);
    return new ResponseEntity<>(HttpStatus.OK);
  }

  /**
   * 第一次设置用户邮箱
   *
   * @param params -
   * <p> email             - Notnull  - Str - 邮箱
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class, DistributionUserToken.class})
  @PutMapping(value = "/user/email", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity setUserEmail(@RequestBody Map<String, String> params) {
    String email = ConvertUtil.checkNotNull(params, "email", "邮箱不能为空", String.class);
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    userBaseInfoService.setUserEmail(userId, email);
    return new ResponseEntity<>(HttpStatus.OK);
  }


  /**
   * 未读消息，待回复咨询，微信绑定
   *
   * @param userId
   *
   * @return
   */
  private ObjectNode getBaseInfo(String userId) {
    UserBaseInfo userBaseInfo = userBaseInfoService.findById(userId);
    Assert.notNull(userBaseInfo, "未找到用户");
    ObjectNode data = JsonUtils.createObjectNode();
    ObjectNode userNode = JsonUtils.convert(userBaseInfo, ObjectNode.class);
    userNode.remove("pwd");
    data.putPOJO("userInfo", userNode);
    int count = sysMessageService.countUnReadMessage(userId);
    data.putPOJO("unReadMessage", count);
//    int replyConsult = serviceConsultService.countUnReplyConsult(userId);
//    data.put("unReplyConsult", replyConsult);
    return data;

  }


  /**
   * 获取用户支付状态
   *
   * @param params <p>  type                      - Notnull   - Str - 0 订单，1 充值
   * <p>  queryNo                   - Notnull   - Str - 订单编号，充值支付编号
   * <p>  payType                   - Notnull   - Str - 支付类型 1.支付宝，2微信
   *
   * @return
   */
  @GetMapping(value = "/pay/status/circulation", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getPayStatus(@RequestParam Map<String, String> params, HttpServletRequest request)
    throws Exception {
    String type = ConvertUtil.checkNotNull(params, "type", "支付类型不能为空", String.class);
    String queryNo = ConvertUtil.checkNotNull(params, "queryNo", "查询编号为空", String.class);
    String payType = ConvertUtil.checkNotNull(params, "payType", "payType为空,1.支付宝，2微信", String.class);
    TransactionChannel transactionChannel = EnumUtil.parse(TransactionChannel.class, "val", Integer.valueOf(payType));
    ObjectNode res = userBaseInfoService.getPayStatusWithPromotion(type, queryNo, transactionChannel);
    String realIp = IPUtils.getRealIp(request);
    logger.info("realIp:" + realIp);
    return new ResponseEntity<>(res, HttpStatus.OK);
  }

  /**
   * 选择区域
   *
   * @param regionId 区域id
   */
  @PostMapping(value = "/user/region/{regionId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity selectRegion(@PathVariable("regionId") String regionId) {
    Serializable userId = TokenThreadLocal.getTokenObjNonNull().objId();
    return new ResponseEntity<>(userBaseInfoService.selectRegion(userId.toString(), regionId), HttpStatus.CREATED);
  }


}
