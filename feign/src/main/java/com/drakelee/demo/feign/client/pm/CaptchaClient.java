package com.drakelee.demo.feign.client.pm;

import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.Map;

/**
 * CaptchaClient  发送短信所需方法
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/6/12 0012 18:26
 */
@FeignClient(value = "${module-pm}")
public interface CaptchaClient {


  /**
   * 发送短信前获取校验的图片验证码
   *
   * @param params -
   * <p> type         - Notnull  - Int - 发送类型： 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   */
  @GetMapping(value = "/api/edge/captcha", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  void preSend(@RequestParam Map<String, String> params) throws IOException;


  /**
   * 根据js解密代码获取混淆验证码
   *
   * @param params -
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   * <p> length       - Notnull  - Int - code长度(4-10位数字)
   * <p> phone        - Nullable - Str - 手机号，可空，用于 type = 1，3
   * <p> decryptJs    - Notnull  - Str - 用于解密的js混淆代码
   */
  @GetMapping(value = "/api/edge/captcha/key", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ObjectNode preSendSafe(@RequestParam Map<String, String> params);


  /**
   * 前段随机获取解密js方法
   *
   * @return
   */
  @GetMapping(value = "/api/edge/captcha/key/js", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ObjectNode preSendJs(@RequestParam Map<String, String> params);

  /**
   * 发送短信获取验证码
   *
   * @param params -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> preCode      - Notnull  - Str - 校验发送短信前的验证码
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号
   * ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   */
  @GetMapping(value = "/api/edge/sms/code", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  String smsVerifyCode(@RequestParam Map<String, String> params);

  /**
   * 短信验证码-校验
   *
   * @param params
   *
   * @return
   */
  @GetMapping(value = "/api/edge/sms/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  void smsValidate(@RequestParam Map<String, String> params);

  /**
   * 图形验证码校验
   *
   * @param params -
   * <p> preCode      - Notnull  - Str - 校验的验证码
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   *
   * @return
   */
  @GetMapping(value = "/api/edge/captcha/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  void validateCaptcha(@RequestParam Map<String, String> params);

  /**
   * 余额支付短信验证码-校验
   *
   * @param params -
   * <p> phone             - Notnull  - Str - 电话
   * <p> orderCode         - Notnull  - Str - 订单编号
   * <p> code              - Notnull  - Str - 短信验证码
   * @return
   */
  @GetMapping(value = "/api/edge/sms/pay/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  boolean smsPayValidate(@RequestParam Map<String, String> params);

}
