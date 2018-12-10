package com.drakelee.demo.common.constants.advertisement;

/**
 * AdvertisementEventType
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/13 0013 15:28
 */
public enum AdvertisementEventType {

  DISPLAY("展示", 0),
  CLICK("点击", 1);

  private String desc;
  private int type;

  AdvertisementEventType(String desc, int type) {
    this.desc = desc;
    this.type = type;
  }

  public String getDesc() {
    return desc;
  }

  public int getType() {
    return type;
  }



}
