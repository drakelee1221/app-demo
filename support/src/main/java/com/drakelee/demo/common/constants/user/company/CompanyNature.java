package com.drakelee.demo.common.constants.user.company;

/**
 * CompanyNature 企业性质
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/17 0017 10:37
 */
public enum CompanyNature {

  ONE(1, "国有企业"),
  TWO(2, "中外合作企业"),
  THREE(3, "中外合资企业"),
  FOUR(4, "外商独资企业"),
  FIVE(5, "集体企业"),
  SIX(6, "私营企业");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }


  public CompanyNature getByCode(int code) {
    for (CompanyNature item : CompanyNature.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }

  CompanyNature(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
