package com.drakelee.demo.common.constants.advertisement;

/**
 * BannerPositionCode
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/18 0018 14:43
 */
public enum BannerPositionCode {

  S_ONE("PC首页主banner", "S001"),
  S_TWO("PC首页靠底部banner", "S002"),
  S_THREE("PC行业资讯顶部banner","S003"),
  S_FOUR("移动端首页banner","S004"),
  S_FIVE("移动端服务banner","S005"),
  S_SIX("移动端资讯banner","S006");

  private String desc;
  private String code;

  BannerPositionCode(String desc, String code) {
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
