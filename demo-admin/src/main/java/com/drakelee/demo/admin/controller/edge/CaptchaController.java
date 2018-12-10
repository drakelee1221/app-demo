package com.drakelee.demo.admin.controller.edge;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.feign.client.pm.CaptchaClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * CaptchaController
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/6/12 0012 18:31
 */
@RestController
@RequestMapping(GatewayPath.ADMIN)
public class CaptchaController {

  @Autowired
  private CaptchaClient captchaClient;

  /**
   * 发送短信前获取校验的图片验证码
   *
   * @param params -
   * <p> type         - Notnull  - Int - 发送类型： 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   */
  @GetMapping(value = "/edge/captcha", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public void preSend(@RequestParam Map<String, String> params, HttpServletResponse response) throws IOException {
    captchaClient.preSend(params);
  }

  /**
   * 根据js解密代码获取混淆验证码
   *
   * @param params -
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   * <p> length       - Notnull  - Int - code长度(4-10位数字)
   * <p> phone        - Nullable - Str - 手机号，可空，用于 type = 1，3
   * <p> decryptJs    - Notnull  - Str - 用于解密的js混淆代码
   */
  @GetMapping(value = "/edge/captcha/key", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity preSendSafe(@RequestParam Map<String, String> params, HttpServletRequest request) {
    ObjectNode objectNode = captchaClient.preSendSafe(params);
    return new ResponseEntity(JsonResult.success(objectNode), HttpStatus.OK);
  }

  /**
   * 前段随机获取解密js方法
   *
   * @return
   */
  @GetMapping(value = "/edge/captcha/key/js", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity preSendJs(@RequestParam Map<String, String> params, HttpServletRequest request) {
    ObjectNode objectNode = captchaClient.preSendJs(params);
    return new ResponseEntity(JsonResult.success(objectNode), HttpStatus.OK);
  }

  /**
   * 发送短信获取验证码
   *
   * @param params -
   * <p> phone        - Notnull  - Str - 手机号
   * <p> preCode      - Notnull  - Str - 校验发送短信前的验证码
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号
   * ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   */
  @GetMapping(value = "/edge/sms/code", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity smsVerifyCode(@RequestParam Map<String, String> params, HttpServletRequest request) {
    String str = captchaClient.smsVerifyCode(params);
    return new ResponseEntity(JsonResult.success(str), HttpStatus.OK);
  }

  /**
   * 短信验证码-校验
   *
   * @param params
   * @param request
   *
   * @return
   */
  @GetMapping(value = "/edge/sms/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity smsValidate(@RequestParam Map<String, String> params, HttpServletRequest request) {
    captchaClient.smsValidate(params);
    return new ResponseEntity(HttpStatus.OK);
  }

  /**
   * 图形验证码校验
   *
   * @param params -
   * <p> preCode      - Notnull  - Str - 校验的验证码
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册
   *
   * @return
   */
  @GetMapping(value = "/edge/captcha/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity validateCaptcha(@RequestParam Map<String, String> params) {
    captchaClient.validateCaptcha(params);
    return new ResponseEntity(HttpStatus.OK);
  }



}
