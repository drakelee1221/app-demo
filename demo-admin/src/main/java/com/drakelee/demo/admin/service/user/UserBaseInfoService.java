package com.drakelee.demo.admin.service.user;

import com.alibaba.fastjson.JSON;
import com.base.components.common.constants.Valid;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.token.TokenManager;
import com.base.components.common.util.PasswordUtil;
import com.base.components.common.util.StringHider;
import com.base.components.common.util.ValidatorUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.base.components.database.service.AbstractJpaService;
import com.drakelee.demo.admin.service.attachment.AttachmentService;
import com.drakelee.demo.admin.service.region.RegionService;
import com.drakelee.demo.admin.util.AuthUtilHelper;
import com.drakelee.demo.common.constants.UserType;
import com.drakelee.demo.common.constants.admin.AuthCode;
import com.drakelee.demo.common.constants.sys.Gender;
import com.drakelee.demo.common.constants.user.WorkStatus;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.database.dao.user.BaseUserTypeDao;
import com.drakelee.demo.database.dao.user.UserBaseInfoDao;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * UserBaseInfoService
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/28 0028 14:21
 */
@Service
public class UserBaseInfoService extends AbstractJpaService<UserBaseInfo, String, UserBaseInfoDao> {
  @Autowired
  AttachmentService attachmentService;
  @Autowired
  private BaseUserTypeDao baseUserTypeDao;
  @Autowired
  private RegionService regionService;
  @Autowired
  private UserBaseInfoDao userBaseInfoDao;
  @Autowired
  private TokenManager tokenManager;


  /**
   * 用户管理分页查询用户列表
   *
   * @param params
   *
   * @return
   */
  public DataPage listPage(Map<String, String> params) {
    String regionId = params.get("regionId");
    if (StringUtils.isNotEmpty(regionId)) {
      List<Region> all = regionService.findAll();
      Set<String> allChildren = regionService.findAllChildren(regionId, all);
      params.put("regionIds", JSON.toJSONString(allChildren));
    }
    return getDao().listPage(params).map(val -> {
      if (val.get("avatar") != null) {
        val.put("avatar", attachmentService.displayAtta(String.valueOf(val.get("avatar"))));
      }
      val.put(
        "phone", StringHider.hidePhone(
          (String) val.get("phone"),
          !AuthUtilHelper.getAuth().checkRoleCodeAll(AuthCode.SENSITIVE_DATA_AUTH.toString())
        ));
      return val;
    });
  }

  public Map<String, Object> queryRegister(String endTime, String type) {
    int size = 30;
    LocalDate endDate = LocalDate.now();
    if (StringUtils.isNotBlank(endTime)) {
      endDate = LocalDate.parse(endTime);
    }
    LocalDate startDate = endDate.minusDays(size);
    if ("year".equalsIgnoreCase(type)) {
      startDate = startDate.minusYears(1);
      endDate = endDate.minusYears(1);
    } else if ("month".equalsIgnoreCase(type)) {
      startDate = startDate.minusMonths(1);
      endDate = endDate.minusMonths(1);
    }
    List<Map<String, Object>> mapList = getDao()
      .queryRegister(Date.valueOf(startDate), Date.valueOf(endDate.plusDays(1)));
    List<String> xAxis = new ArrayList<>();
    List<String> yAxis = new ArrayList<>();
    Map<String, Map<String, Object>> temp = Maps.newHashMap();
    for (Map<String, Object> map : mapList) {
      temp.put((String) map.get("registTime"), map);
    }
    for (int i = 0; i <= size; i++) {
      LocalDate curDate = startDate.plusDays(i);
      Map info = temp.get(curDate.toString());
      if (info != null) {
        xAxis.add(info.get("registTime").toString());
        yAxis.add(info.get("nums").toString());
      } else {
        xAxis.add(curDate.toString());
        yAxis.add("0");
      }
    }
    Map<String, Object> returnMap = new HashMap<>();
    returnMap.put("xAxis", xAxis);
    returnMap.put("yAxis", yAxis);
    return returnMap;
  }

  /**
   * 查询平台用户
   *
   * @return
   */
  public long countUser() {
    return getDao().countUser(UserType.USER.getCode());
  }

  public List<Map> countUnLogin(boolean normalUser) {
    DateTime sevenDay = DateTime.now().minusDays(7);
    DateTime fifteenDay = DateTime.now().minusDays(15);
    DateTime thirtyDay = DateTime.now().minusDays(30);
    DateTime maxDay = DateTime.now().minusDays(999);
    if (normalUser) {
      return getDao().countUnLogin(thirtyDay.toDate(), fifteenDay.toDate(), sevenDay.toDate(), maxDay.toDate(),
                                   UserType.USER.getCode()
      );
    } else {
      return getDao().countUnLoginNotequal(thirtyDay.toDate(), fifteenDay.toDate(), sevenDay.toDate(), maxDay.toDate(),
                                           UserType.USER.getCode()
      );
    }
  }

  public BigDecimal countUserBalance() {
    return getDao().countUserBalance();
  }

  @Transactional(rollbackFor = Exception.class)
  public String clientRegister(String phone, String pwd) {
    Assert.isTrue(ValidatorUtil.isPhoneNum(phone), "手机格式不正确");
    Assert.hasText(pwd, "请填入密码");
    Assert.isTrue(getDao()
        .count(ConditionGroup.build().addCondition("phone", ConditionEnum.OPERATE_EQUAL, phone))
        <= 0, "该手机用户已注册");
    java.util.Date now = new java.util.Date();
    //用户主表
    UserBaseInfo userBase = new UserBaseInfo();
    userBase.setGender(Gender.unknown.getCode());
    userBase.setPhone(phone);
    userBase.setPwd(PasswordUtil.encryptPassword(phone, pwd));
    userBase.setUserNickName("和" + phone.substring(phone.length() - 4));
    userBase.setRegionId("");
    userBase.setRegistIp("127.0.0.1");
    userBase.setRemark("");
    userBase.setUserType(UserType.USER.getCode());
    userBase.setUserTypeId(baseUserTypeDao.findIdByUserType(UserType.USER.getCode()));
    userBase.setRegistTime(now);
    userBase.setPasswordErrors(0);
    userBase.setStatus(Valid.TRUE.getVal());
    userBase.setLastLoginIp("");
    userBase.setWorkStatus(WorkStatus.working.getVal());
    userBase.setBalance(BigDecimal.ZERO);

    getDao().save(userBase);
    return userBase.getId();
  }


  /**
   * 查询地区一般用户数量
   *
   * @param allChildren
   *
   * @return
   */
  public long countByRegion(Set<String> allChildren) {
    long count = 0;
    for (String item : allChildren) {
      long itemCount = getDao()
        .count(ConditionGroup.build().addCondition("regionId", ConditionEnum.OPERATE_EQUAL, item));
      count += itemCount;
    }
    return count;
  }

  public UserBaseInfo findByPhone(String phone) {
    return getDao().findByPhone(phone);
  }


  public UserBaseInfo findByPhoneAndUserNickNameAndUserType(String phone, String name, Integer type) {
    return getDao().findByPhoneAndUserNickNameAndUserType(phone, name, type);
  }

  @Transactional(rollbackFor = Exception.class)
  public void disableUser(String userId) {
    UserBaseInfo user = findById(userId);
    user.setStatus(Valid.FALSE.getVal());
    getDao().saveAndFlush(user);
    // 冻结用户则需清除token信息
    if (user.getStatus() == Valid.FALSE.getVal()) {
      tokenManager.cleanTokenWithObjId(user.getId());
    }
  }
  @Transactional(rollbackFor = Exception.class)
  public void enableUser(String userId) {
    UserBaseInfo user = findById(userId);
    user.setStatus(Valid.TRUE.getVal());
    getDao().saveAndFlush(user);
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
}
