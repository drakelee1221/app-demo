package com.drakelee.demo.common.constants.sms;

/**
 * SmsTemplateUsuallyParam 模板常用参数
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/6/22 0022 14:50
 */
public enum SmsTemplateUsuallyParam {

  // userInfo
  PASSWORD("pwd", "密码"),
  ID("id","id"),
  PHONE("phone","电话"),
  AVATAR("avatar","头像"),
  USER_NICKNAME("userNickName","昵称"),
  GENDER("gender","性别"),
  BIRTH("birth","出生年月"),
  USER_EMAIL("userEmail","邮箱"),
  OPEN_ID("openId","openId"),
  USER_QQ("userQq","qq"),
  USER_TYPE("userType","用户类型"),
  USER_TYPE_ID("userTypeId","用户类型id"),
  BALANCE("balance","余额"),
  REGISTER_TIME("registTime","注册时间"),
  REGISTER_IP("registIp","注册ip"),
  LAST_LOGIN_TIME("lastLoginTime","最近登录时间"),
  LAST_LOGIN_IP("lastLoginIp","最近登陆ip"),
  STATUS("status","状态"),
  WX_NAME("wxName","微信昵称"),
  WORK_STATUS("workStatus","工作状态"),
  PROFILE("profile","个人简介"),
  REGISTER_REGION("registRegion","注册区域"),
  REGION_ID("regionId","区域id"),
  SELECT_REGION_ID("selectRegionId","用户选择区域id"),
  HOME_PAGE("homepage","用户主页"),
  // /userInfo



  ;
  private String code;
  private String desc;

  public String getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }

  SmsTemplateUsuallyParam(String code, String desc) {
    this.code = code;

    this.desc = desc;
  }

}
