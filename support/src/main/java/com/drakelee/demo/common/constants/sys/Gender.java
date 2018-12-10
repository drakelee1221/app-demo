

package com.drakelee.demo.common.constants.sys;

import org.apache.commons.lang3.StringUtils;

/**
 * 性别常量
 *
 * @author <a href="lijian@xianyunsoft.com">Li Jian</a>
 * @version 1.0.0, 2017-07-10
 */
public enum Gender {
  male(1,"男"),

  female(2,"女"),

  unknown(0,"未知");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }


  Gender(int code,String desc) {
    this.code = code;
    this.desc = desc;
  }
  public static Gender parseDesc(String desc){
    if(StringUtils.isNotEmpty(desc)){
      for (Gender gender : values()) {
          if(desc.contains(gender.desc)){
            return gender;
          }
      }
    }
    return null;
  }

  public static Gender parseCode(int code){
    for (Gender gender : values()) {
      if(code == gender.code){
        return gender;
      }
    }
    return null;
  }
}
