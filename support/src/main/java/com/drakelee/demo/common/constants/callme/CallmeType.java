package com.drakelee.demo.common.constants.callme;

/**
 * CallmeType callme业务范围分类
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/17 0017 09:45
 */
public enum CallmeType {

  FISCAL(1, "财税服务"),
  BUSINESS(2, "工商服务"),
  TAX(3, "税务筹划"),
  QUALIFUCATION(4, "资质办理"),
  KNOWLEDGE(5, "知识产权"),
//  VIEW(6, "意见"),
//  SUGGEST(7, "建议"),
//  COOPERATION(8, "合作"),
//  OTHER(9, "其他")
  ;

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }

  public static CallmeType getByCode(int code) {
    for (CallmeType item : CallmeType.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }

  CallmeType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }


}
