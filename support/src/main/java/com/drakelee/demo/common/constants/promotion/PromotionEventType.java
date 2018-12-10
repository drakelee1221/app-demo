package com.drakelee.demo.common.constants.promotion;

/**
 * PromotionEventType 活动触发条件枚举值
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/17 0017 10:02
 */
public enum PromotionEventType {

  /**
   * 登录
   */
  LOGIN,
  /**
   * 当日首次登录
   */
  FIRST_LOGIN,
  /**
   * 购买服务
   */
  ORDER,
  /**
   * 注册
   */
  REGISTER,
  /**
   * 发优惠券
   */
  COUPONS,
  /**
   * 分享页面注册登录
   */
  SHARE_REGISTER_LOGIN,

  /**
   * 分享页面注册
   */
  SHARE_REGISTER,

  PromotionEventType(){}

}
