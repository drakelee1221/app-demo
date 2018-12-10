package com.drakelee.demo.common.constants.msgqueue.channels;

import com.base.components.common.constants.msgqueue.Channel;

/**
 * 消息Channel，用来区分listener的业务类别
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-14 15:57
 */
public enum MessageChannel implements Channel {

  /** 测试 */
  TEST_CHANNEL("测试"),
  /** 用户注册 */
  USER_REGISTER_CHANNEL("用户注册"),
  /** 订单退款 */
  ORDER_REFUND("订单退款"),
  /** 申请退款 */
  REQUEST_REFUND("申请退款"),
  CONFIRM_REFUND("确认退款"),
  REFUSE_REFUND("拒绝退款"),
  /** 提交合作意向 */
  SUBMIT_INTENTION("提交合作意向"),
  /** 供需审核通过 */
  SUPPLY_DEMAND_PASS("供需审核通过"),
  /** 订单确认 */
  ORDER_CONFIRM("确认订单"),
  /** 转移订单给专业人员 */
  ORDER_TRANSFORM("转移订单给专业人员"),
  /** 客户对公司人员进行评价 */
  EVALUATE_EMPLOYEE("客户对公司人员进行评价"),
  /** 客户投诉 */
  USER_COMPLAIN("客户投诉"),
  /** 客户投诉回复 */
  USER_COMPLAIN_REPLY("客户投诉回复"),
  /** 开始服务 */
  SERVICE_START("开始服务"),
  /** 服务驳回 */
  SERVICE_REJECT("服务驳回"),
  /** 添加服务日志 */
  ADD_SERVICE_LOG("添加服务日志"),
  /** 取消订单 */
  ORDER_CANCEL("取消订单"),
  /** call me */
  CALL_ME("call_me"),
  /** call me 处理 */
  CALL_ME_DEAL("call_me-处理"),
  /** call me 自动处理 */
  CALL_ME_AUTO_DEAL("call_me-自动处理"),
  /** 收到咨询 */
  CONSULT_RECEIVED("收到咨询"),
  /** 咨询回复 */
  CONSULT_REPLY("咨询回复"),
  /** 下单*/
  ORDER_SAVE("下单"),
  /** 订单修改*/
  ORDER_MODIFY("订单修改"),
  /** 提现 审核*/
  WITHDRAW_AUDIT("提现-审核"),
  /** 提现 拒绝*/
  WITHDRAW_REJECT("提现-拒绝"),
  /** 用户登录*/
  USER_LOGIN("用户登录"),
  /** 转移订单*/
  TRANSFORM_ORDER("转移订单"),
  /** 服务审核*/
  TRANSFORM_AUDIT("服务审核"),
  /** 登录自动活动抽奖 */
  AUTO_PROMOTION_LOGIN("登录自动活动抽奖"),
  AUTO_PROMOTION_FIRST_LOGIN("用户首次登录"),
  /** 注册自动活动抽奖 */
  AUTO_PROMOTION_REGISTER("注册自动活动抽奖"),
  /** 购买服务自动活动抽奖 */
  AUTO_PROMOTION_ORDER("购买服务自动活动抽奖"),
  /** 奖品类型-余额 */
  REWARD_TYPE_AMOUNT("奖品类型-余额"),
  /** 奖品类型-表单填写 */
  REWARD_TYPE_FORM("奖品类型-表单填写"),
  /** 奖品类型-无奖励 */
  REWARD_TYPE_NOTHING("奖品类型-无奖励"),
  /** 企业注册 */
  ORG_REGISTER("企业注册"),
  /** 修改订单 */
  CHANGE_ORDER("修改订单"),
  /** 服务人员注册审核 */
  SERVICE_REGISTER_AUDIT("服务人员注册审核"),
  ORDER_PAY_SUCCESS("订单支付成功"),
  COUPONS_USE("优惠卷使用"),
  /** 抽奖 */
  REWARD("活动抽奖"),
  ;

  private String desc;

  MessageChannel(String desc) {
    this.desc = desc;
  }

  @Override
  public String getDesc() {
    return desc;
  }

}
