

package com.drakelee.demo.common.constants.sys;

import org.apache.commons.lang3.StringUtils;

/**
 * 优惠卷使用状态
 *
 * @author <a href="lijian@xianyunsoft.com">Li Jian</a>
 * @version 1.0.0, 2017-07-10
 */
public enum CouponsStatus {
  un_use(0,"未使用"),

  used(1,"使用已支付"),

  un_pay(2,"已使用未支付"),
  invalid(3,"已作废");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }


  CouponsStatus(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }
  public static CouponsStatus parseDesc(String desc){
    if(StringUtils.isNotEmpty(desc)){
      for (CouponsStatus gender : values()) {
          if(desc.contains(gender.desc)){
            return gender;
          }
      }
    }
    return null;
  }

  public static CouponsStatus parseCode(int code){
    for (CouponsStatus gender : values()) {
      if(code == gender.code){
        return gender;
      }
    }
    return null;
  }
}
