package com.drakelee.demo.common.constants.drp;

/**
 * 渠道类型
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/17 0017 09:45
 */
public enum DrpChannelType {

  SIGN_CHANNEL(0, "签约渠道"),
  OUT_CHANNEL(1, "普通外部渠道");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }



  DrpChannelType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }


}
