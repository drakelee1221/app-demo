package com.drakelee.demo.common.constants.sms;

/**
 * ParamType
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-06-26 10:11
 */
public enum  SmsParamType {
  USERINFO(
    "userInfo",
    SmsTemplateUsuallyParam.PASSWORD,
    SmsTemplateUsuallyParam.ID,
    SmsTemplateUsuallyParam.PHONE,
    SmsTemplateUsuallyParam.AVATAR,
    SmsTemplateUsuallyParam.USER_NICKNAME,
    SmsTemplateUsuallyParam.GENDER,
    SmsTemplateUsuallyParam.BIRTH,
    SmsTemplateUsuallyParam.USER_EMAIL,
    SmsTemplateUsuallyParam.OPEN_ID,
    SmsTemplateUsuallyParam.USER_QQ,
    SmsTemplateUsuallyParam.USER_TYPE,
    SmsTemplateUsuallyParam.USER_TYPE_ID,
    SmsTemplateUsuallyParam.BALANCE,
    SmsTemplateUsuallyParam.REGISTER_TIME,
    SmsTemplateUsuallyParam.REGISTER_IP,
    SmsTemplateUsuallyParam.LAST_LOGIN_TIME,
    SmsTemplateUsuallyParam.LAST_LOGIN_IP,
    SmsTemplateUsuallyParam.STATUS,
    SmsTemplateUsuallyParam.WX_NAME,
    SmsTemplateUsuallyParam.WORK_STATUS,
    SmsTemplateUsuallyParam.PROFILE,
    SmsTemplateUsuallyParam.REGISTER_REGION,
    SmsTemplateUsuallyParam.REGION_ID,
    SmsTemplateUsuallyParam.SELECT_REGION_ID,
    SmsTemplateUsuallyParam.HOME_PAGE
  )
  ;
  private String code;
  private SmsTemplateUsuallyParam[] params;
  SmsParamType(String userInfo,SmsTemplateUsuallyParam ...password) {
    this.code =userInfo;
    this.params = password;

  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public SmsTemplateUsuallyParam[] getParams() {
    return params;
  }

  public void setParams(SmsTemplateUsuallyParam[] params) {
    this.params = params;
  }
}
