package com.drakelee.demo.common.constants.user.company;

/**
 * CompanyScale 公司规模
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/17 0017 10:37
 */
public enum CompanyScale {

  ONE(1, "0-50人"),
  TWO(2, "50-100人"),
  THREE(3, "100-200人"),
  FOUR(4, "200-500人"),
  FIVE(5, "500人以上");

  private int code;
  private String desc;
  private String key;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }


  public CompanyScale getByCode(int code) {
    for (CompanyScale item : CompanyScale.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }

  CompanyScale(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }
}
