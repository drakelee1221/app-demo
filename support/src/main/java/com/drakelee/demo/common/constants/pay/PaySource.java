package com.drakelee.demo.common.constants.pay;

/**
 * PaySource
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-06-29 09:36
 */
public enum PaySource {
  PC("pc","PC"),
  WAP("wap","普通浏览器"),
  WECHAT("wechat","微信浏览器"),
  APP_ANDROID("android","Android手机"),
  APP_IOS("ios","IOS手机");
  private String desc;
  private String code;
  PaySource(String code,String desc) {
    this.desc = desc;
    this.code = code;
  }

  public String getDesc() {
    return desc;
  }

  public String getCode() {
    return code;
  }
}
