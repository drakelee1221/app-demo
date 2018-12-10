package com.drakelee.demo.common.constants.user.company;

/**
 * CompanyIndustry
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/2 0002 11:59
 */
public enum CompanyIndustry {
  ONE(1, "农、林、牧、渔业"),
  TWO(2, "采矿业"),
  THREE(3, "制造业"),
  FOUR(4, "电力、热力、燃气及水生产和供应业"),
  FIVE(5, "建筑业"),
  SIX(6, "批发和零售业"),
  SEVEN(7, "交通运输、仓储和邮政业"),
  EIGHT(8, "住宿和餐饮业"),
  NINE(9, "信息传输、软件和信息技术服务业"),
  TEN(10, "金融业"),
  ELEVEN(11, "房地产业"),
  TWELVE(12, "科学研究和技术服务业"),
  THIRTEEN(13, "水利、环境和公共设施管理业"),
  FOURTEEN(14, "居民服务、修理和其他服务业"),
  FIFTEEN(15, "教育"),
  SIXTEEN(16, "卫生和社会工作"),
  SEVENTEEN(17, "文化、体育和娱乐业"),
  EIGHTEEN(18, "公共管理、社会保障和社会组织"),
  NINETEEN(19, "国际组织"),
  TWENTY(20, "其他");



  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }


  public CompanyIndustry getByCode(int code) {
    for (CompanyIndustry item : CompanyIndustry.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }

  CompanyIndustry(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }
}
