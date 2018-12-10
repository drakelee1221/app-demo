

package com.drakelee.demo.common.constants.sms;

/**
 * 短信模板ID
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-08-18 13:54
 */
public enum SmsTemplateId {

  /**
   * 登录确认验证码
   * <p> 拓展参数：{"code":"123456"}
   * <p> code: 验证码
   */
  ALiSMS_Login("SMS_128955112"),

  /**
   * 登录异常验证码
   * <p> 拓展参数：{"code":"123456"}
   * <p> code: 验证码
   */
  ALiSMS_Login_Exc("SMS_128955111"),

  /**
   * 用户注册验证码
   * <p> 拓展参数：{"code":"123456"}
   * <p> code: 验证码
   */
  ALiDaYu_Register("SMS_142146949"),


  /**
   * 修改密码验证码
   * <p> 拓展参数：{"code":"123456"}
   * <p> code: 验证码
   */
  ALiDaYu_ChangePwd("SMS_142146944"),
  /**
   * 下单成功
   * <p> phone
   * <p> productName
   */
  ALiSMS_OrderSave("SMS_142151884"),
  /**
   *需求审核通过
   * <p> type 需求/供应
   */
  ALiSMS_require_audit_success("SMS_142146906"),
  /**
   * 提交合作意向
   * <p> type 需求/供应
   * <p> phone 手机号
   */
  AliSms_commit_collaborate("SMS_142151879"),
  /**
   *提交callme信息
   */
  ALiSMS_CallMe("SMS_142151911"),
  /**
   *修改手机号码
   * <p> code
   */
  ALiSMS_PhoneChange("SMS_142146937"),
  /**
   *提现审核成功
   * <p> amount 金额
   */
  ALiSMS_withdraw_audit_success("SMS_142147334"),
  /**
   *提现审核失败
   * <p> amount 金额
   */
  ALiSMS_withdraw_audit_fail("SMS_142147331"),
  /**
   *投诉回复
   */
  ALiSMS_complain_reply("SMS_142146919"),
  /**
   *投诉
   */
  ALiSMS_complain("SMS_142151891"),
  /**
   *咨询回复通知
   */
  ALiSMS_consult_reply("SMS_142151886"),
  /**
   *服务开始
   * <p> phone 手机号
   * <p> productName 产品名称
   */
  ALiSMS_service_start("SMS_142151895"),
  /**
   *订单确认
   * <p> orderNo 订单编号
   */
  ALiSMS_order_confirm("SMS_142146923"),
  /**
   *订单退款
   * <p> orderNo 订单编号
   */
  ALiSMS_order_refund("SMS_142146903"),
  /**
   *申请退款
   * <p> orderCode 订单编号
   */
  ALiSMS_request_refund("SMS_151579607"),
  /**
   *订单取消
   * <p> orderNo 订单编号
   */
  ALiSMS_order_cancel("SMS_142146920"),
  /**
   *订单修改
   * <p> orderNo 订单编号
   */
  ALiSMS_order_modify("SMS_142146918"),
  /**
   *账户转移
   * <p> code
   */
  ALiSMS_account_transfer("SMS_142146932"),
  /**
   *邮箱设置
   * <p> code
   */
  ALiSMS_set_email("SMS_142146933"),
  /**
   * 提现申请
   * <p> code
   */
  ALiSMS_withdraw("SMS_142146927"),
  /**
   * 企业注册
   * <p> code
   */
  ALiSMS_org_register("SMS_142146901"),
  /**
   * 企业注册
   * <p> code
   */
  ALiSMS_org_register_invitecode("SMS_142146901"),

  /**
   * 用户余额支付
   * <p> code: 验证码
   */
  ALiDaYu_balance_pay("SMS_142151873"),

  /**
   * 服务人员申请审核通知
   * <p> userName: 用户名称
   */
  ALiDaYu_service_audit("SMS_142146954"),
  /**
   * callme派单通知
   * <p> productName: 产品名称
   * <p> phone:客户经理手机号
   */
  ALiDaYu_callme("SMS_142151871"),
  /**
   * 优惠卷赠送通知
   * <p> phone: 手机号
   * <p> couponsAmount: 优惠卷总金额
   */
  ALiDaYu_coupons_notify("SMS_145920676"),
  /**
   * 优惠卷使用通知
   * <p> phone: 手机号
   */
  ALiDaYu_coupons_use_notify("SMS_145910787")
  ;
  private String templateId;

  SmsTemplateId(String templateId) {
    this.templateId = templateId;
  }

  public String getTemplateId() {
    return templateId;
  }

}
