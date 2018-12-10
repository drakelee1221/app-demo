

package com.drakelee.demo.cache;


import com.base.components.cache.Nameable;

/**
 * 缓存类别，对应 xxx-cache.yml 中 base.common.cache.expires
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-16 09:39
 */
public enum CacheName implements Nameable {

  /**
   * admin端，登录权限
   */
  ADMIN_AUTH_INFO,


  /**
   * 登录-短信发送前的验证码
   */
  PRE_SMS_CODE_LG,

  /**
   * 登录-验证码
   */
  VERIFY_CODE_LG,

  /**
   * 注册-短信发送前的验证码
   */
  PRE_SMS_CODE_RG,

  /**
   * 注册-验证码
   */
  VERIFY_CODE_RG,

  /**
   * 修改密码-短信发送前的验证码
   */
  PRE_SMS_CODE_CP,

  /**
   * 修改密码-验证码
   */
  VERIFY_CODE_CP,

  /**
   * 修改手机号-短信发送前的验证码
   */
  PRE_SMS_CODE_PHONE,

  /**
   * 修改手机号-验证码
   */
  VERIFY_CODE_PHONE,
  /**
   * 提现-短信发送前的验证码
   */
  PRE_SMS_CODE_TX,

  /**
   * 提现-验证码
   */
  VERIFY_CODE_TX,

  /**
   * 客户经理搜索
   */
  MANAGER_SEARCH,

  /**
   * 服务人员搜索
   */
  SERVICER_SEARCH,

  /**
   * 资深顾问搜索
   */
  EXPERT_SEARCH,

  /**
   * 订单编号顺序号
   */
  ORDER_NO_SERIAL,
  /**
   * 充值记录顺序号
   */
  RECHARGE_NO_SERIAL,
  /**
   * 附件id对应url
   */
  ATTACHMENT_ID_URL,
  /**
   * 附件id对应的权限列表
   */
  ATTACHMENT_ID_LIST,

  /**
   * 用户一个小时内密码输入错误
   */
  PASSWORD_ERROR,

  /**
   * 登录-密码错误超过限制短信发送前的验证码
   */
  PRE_SMS_ERROR_PASSWORD_CODE_LG,
  /**
   * 微信绑定
   */
  WECHAT_BIND,

  /**
   * 用户上次发送短信验证码的时间,用作发送间隔限制
   */
  USER_SMS_LASTTIME,

  /**
   * 修改邮箱
   */
  PRE_SMS_CODE_EMAIL,

  /**
   * 修改邮箱-验证码
   */
  VERIFY_CODE_EMAIL,

  /**
   * 订单支付
   */
  ORDER_PAY,
  /**
   * 充值支付
   */
  RECHARGE_PAY,

  /**
   * JS加解密代码
   */
  JS_DECRYPT,

  /**
   * 是否是当天第一次登录
   */
  FIRST_LOGIN_OF_DAY,
  /**
   * 企业注册
   */
  ORG_REGISTER,
  PRE_ORG_REGISTER,
  /**
   * 人员注册
   */
  SERVICE_USER_REGISTER,
  PRE_SERVICE_USER_REGISTER,
  UP_NO_TOKEN,
  /**
   * 微信登录重定向临时对象
   */
  WECHAT_LOGIN_TOKENOBJ,

  /**
   * 余额支付验证码
   */
  BALANCE_PAY,
  PRE_BALANCE_PAY,

  /**
   * 字典缓存
   */
  DICTIONARY,
  /**
   * 微信配置缓存
   */
  WECHAT_CACHE,

  /**
   * CALLME分配客户经理条件缓存
   */
  CALL_ME_CONDITION,

  /**
   * CALLME分配客户经理条件缓存MD5排序
   */
  CALL_ME_CONDITION_MD5,
  /**
   * 临时订单缓存 1分钟
   */
  ORDER_TEMP_CACHE,
  /**
   * 产品包分享缓存 5小时
   */
  MANAGER_COMBO_SHARE_CACHE,
  /**
   * 分享
   */
  SHARELINK,
  /**
   * 推荐人数
   */
  REFERRER_PERSONS,
  /**
   * 自动登录跳转地址
   */
  WECHAT_REDIRECT,

  /**
   * 公司名称分数
   */
  COMPANY_SCORES,
  ;

}
