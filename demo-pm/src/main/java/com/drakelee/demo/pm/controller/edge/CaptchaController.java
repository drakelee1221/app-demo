

package com.drakelee.demo.pm.controller.edge;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.common.collect.Maps;
import com.drakelee.demo.pm.service.user.UserBaseInfoService;
import com.base.components.cache.Cache;
import com.base.components.cache.CacheManager;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.sms.SmsTemplateId;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.exception.business.SmsException;
import com.base.components.common.exception.business.SmsException.ErrorCode;
import com.drakelee.demo.common.service.sms.SmsService;
import com.base.components.common.util.CaptchaUtil;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.IPUtils;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.RandomCodeHelper;
import com.drakelee.demo.pm.service.user.UserBaseInfoService;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * UserController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-10 17:44
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
@RefreshScope
public class CaptchaController {
  public static final String SMS_COUNT_EXPIRE_KEY_PREFIX = "expire_";

  @Autowired
  private CacheManager cacheManager;

  @Autowired
  private UserBaseInfoService userBaseInfoService;

  @Autowired
  private DefaultKaptcha defaultKaptcha;

  @Value("${base.sms.limit.countOfDay:10}")
  private int smsCountOfDay;

  @Autowired(required = false)
  private SmsService smsService;

  @Value("${base.sms.enable}")
  private Boolean smsEnable;

  @Value("${base.sms.limit:60000}")
  private long smsReqLimit;

  /**
   * 发送短信前获取校验的图片验证码
   *
   * @param params -
   * <p> type         - Notnull  - Int - 发送类型： 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册，9、余额支付验证
   */
  @GetMapping(value = "/edge/captcha", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public void preSend(@RequestParam Map<String, String> params, HttpServletResponse response) throws IOException {
    Cache preCache = jugdeType(params);
    String code = defaultKaptcha.createText();
    preCache.put(code, code);
    response.setContentType("image/jpg");
    ImageIO.write(defaultKaptcha.createImage(code), "jpg", response.getOutputStream());
  }

  /**
   * 图形验证码校验
   *
   * @param params -
   * <p> preCode      - Notnull  - Str - 校验的验证码
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册，9、余额支付验证
   *
   * @return
   */
  @GetMapping(value = "/edge/captcha/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity validateCaptcha(@RequestParam Map<String, String> params) {
    SmsException.assertIsTrue(params.get("preCode") != null, ErrorCode.validate_empty);
    String preCode = params.get("preCode");
    SmsException.assertIsTrue(params.get("type") != null, ErrorCode.type_empty);
    int type = Integer.parseInt(params.get("type"));
    SmsException.assertIsTrue(type >= 0 && type <= 9, ErrorCode.type_error);
    CacheName cacheName;
    //登录
    if (type == 0) {
      cacheName = CacheName.PRE_SMS_CODE_LG;
    }
    //注册
    else if (type == 1) {
      cacheName = CacheName.PRE_SMS_CODE_RG;
    }
    //找回密码
    else if (type == 2) {
      cacheName = CacheName.PRE_SMS_CODE_CP;
    }
    //修改手机号
    else if (type == 3) {
      cacheName = CacheName.PRE_SMS_CODE_PHONE;
    }
    //余额提现
    else if (type == 4) {
      cacheName = CacheName.PRE_SMS_CODE_TX;
    }
    //登录密码错误超过限制
    else if (type == 5) {
      cacheName = null;
    }
    //修改邮箱或者验证原手机号
    else if (type == 6) {
      cacheName = CacheName.PRE_SMS_CODE_EMAIL;
    }
    //机构注册
    else if (type == 7) {
      cacheName = CacheName.PRE_ORG_REGISTER;
    }
    //服务人员注册
    else if (type == 8) {
      cacheName = CacheName.PRE_SMS_CODE_RG;
    }
    //余额支付验证
    else {
      cacheName = CacheName.PRE_BALANCE_PAY;
    }
    Cache cache = cacheManager.getCache(cacheName);
    String cachedVerifyCode = cache.get(preCode, String.class);
    SmsException.assertIsTrue(RandomCodeHelper.checkCacheCode(preCode, cachedVerifyCode), ErrorCode.validate_error);
    return new ResponseEntity<>(HttpStatus.OK);
  }

  /**
   * 根据js解密代码获取混淆验证码
   *
   * @param params -
   * <p> type         - Notnull  - Int - 发送类型: 0=登录，1=注册，2=找回密码, 3=修改手机号 ,4=余额提现,5=登录密码错误超过限制,6=修改邮箱或者验证原手机号,7、机构注册，8、服务人员注册，9、余额支付验证
   * <p> length       - Notnull  - Int - code长度(4-10位数字)
   * <p> phone        - Nullable - Str - 手机号，可空，用于 type = 1，3
   * <p> decryptJs    - Notnull  - Str - 用于解密的js混淆代码
   */
  @GetMapping(value = "/edge/captcha/key", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity preSendSafe(@RequestParam Map<String, String> params, HttpServletRequest request) {
    Integer length = ConvertUtil.checkNotNull(params, "length", ErrorCode.encrypt_code_type.getInfo(), Integer.class);
    String decryptJs = ConvertUtil.checkNotNull(params, "decryptJs", ErrorCode.js_null.getInfo(), String.class);
    Assert.isTrue(length >= 4 && length <= 10, ErrorCode.encrypt_code_limit.getInfo());
    //注册和修改手机
    Integer type = ConvertUtil.checkNotNull(params, "type", Integer.class);
    String phone = params.get("phone");
    if (org.apache.commons.lang3.StringUtils.isNotBlank(phone) && (type == 1 || type == 3)) {
      Assert.isTrue(!userBaseInfoService.checkExists(phone), "该手机号已存在！");
    }
    //-------------
    Cache preCache = jugdeType(params);
    String code = "";
    String accessKey = "";
    // 同一个IP每一个js只能调用一次，过期前段重新获取
    String ip = IPUtils.getRealIp(request);
    ip.replace(":", ".");
    Cache decryptJsCache = cacheManager.getCache(CacheName.JS_DECRYPT);
    String decryptJsCacheStr = decryptJsCache.get(ip, String.class);
    SmsException.assertIsTrue(decryptJsCacheStr != null, ErrorCode.js_expire.getCode(), ErrorCode.js_expire.getInfo());
    if (decryptJs.equals(CaptchaUtil.jsDecrypt_1)) {
      accessKey = CaptchaUtil.getRandomCode(32);
      code = CaptchaUtil.getCode(accessKey, length);
    }
    if (decryptJs.equals(CaptchaUtil.jsDecrypt_2)) {
      code = CaptchaUtil.getRandomCode(length);
      accessKey = CaptchaUtil.getEncryptRandomCode(code);
    }
    if (decryptJs.equals(CaptchaUtil.jsDecrypt_3)) {
      accessKey = CaptchaUtil.getRandomCode(32);
      code = CaptchaUtil.getSimpleCode(accessKey, length);
    }
    System.out.println(code);
    preCache.put(code, code);

    // 移除js
    decryptJsCache.evict(ip);

    return new ResponseEntity<>(JsonUtils.mapper.createObjectNode().
      put("accessKey", accessKey), HttpStatus.OK);
  }



  /**
   * 前段随机获取解密js方法
   *
   * @return
   */
  @GetMapping(value = "/edge/captcha/key/js", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity preSendJs(@RequestParam Map<String, String> params, HttpServletRequest request) {
    String ip = IPUtils.getRealIp(request);
    ip.replace(":", ".");
    // 同一个IP每次需要不一样的js方法
    Cache decryptJsCache = cacheManager.getCache(CacheName.JS_DECRYPT);
    String decryptJs = "";
    decryptJs = decryptJsCache.get(ip, String.class);
    String newJs = getDecryptJs();
    while (!StringUtils.isEmpty(decryptJs) && decryptJs.equals(newJs)) {
      newJs = getDecryptJs();
    }
    decryptJsCache.put(ip, newJs);
    return new ResponseEntity<>(JsonUtils.mapper.createObjectNode().
      put("decryptJs", newJs), HttpStatus.OK);
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
    SmsException.assertIsTrue(params.get("phone") != null, ErrorCode.phone_empty);
    String phone = params.get("phone");
    filterSmsReq(phone);
    SmsException.assertIsTrue(checkPhone(phone), ErrorCode.phone_error);
    SmsException.assertIsTrue(params.get("preCode") != null, ErrorCode.validate_empty);
    String preCode = params.get("preCode");
    SmsException.assertIsTrue(params.get("type") != null, ErrorCode.type_empty);
    int type = Integer.parseInt(params.get("type"));
    SmsException.assertIsTrue(type >= 0 && type <= 9, ErrorCode.type_error);
    CacheName preCacheName, cacheName;
    ErrorCode errorCode;
    SmsTemplateId smsTemplateId;
    //登录
    if (type == 0) {
      errorCode = ErrorCode.error_user;
      preCacheName = CacheName.PRE_SMS_CODE_LG;
      cacheName = CacheName.VERIFY_CODE_LG;
      smsTemplateId = SmsTemplateId.ALiSMS_Login;
    }
    //注册
    else if (type == 1) {
      errorCode = ErrorCode.phone_has_register;
      preCacheName = CacheName.PRE_SMS_CODE_RG;
      cacheName = CacheName.VERIFY_CODE_RG;
      smsTemplateId = SmsTemplateId.ALiDaYu_Register;
    }
    //找回密码
    else if (type == 2) {
      errorCode = ErrorCode.error_user;
      preCacheName = CacheName.PRE_SMS_CODE_CP;
      cacheName = CacheName.VERIFY_CODE_CP;
      smsTemplateId = SmsTemplateId.ALiDaYu_ChangePwd;
    }
    //修改手机号
    else if (type == 3) {
      errorCode = ErrorCode.phone_has_register;
      preCacheName = CacheName.PRE_SMS_CODE_PHONE;
      cacheName = CacheName.VERIFY_CODE_PHONE;
      smsTemplateId = SmsTemplateId.ALiSMS_PhoneChange;
    }
    //余额提现
    else if (type == 4) {
      errorCode = ErrorCode.phone_error;
      preCacheName = CacheName.PRE_SMS_CODE_TX;
      cacheName = CacheName.VERIFY_CODE_TX;
      smsTemplateId = SmsTemplateId.ALiSMS_withdraw;
    }
    //登录密码错误超过限制
    else if (type == 5) {
      errorCode = null;
      preCacheName = null;
      cacheName = null;
      smsTemplateId = null;
    }
    //修改邮箱或者验证原手机号
    else if (type == 6) {
      errorCode = ErrorCode.phone_error;
      preCacheName = CacheName.PRE_SMS_CODE_EMAIL;
      cacheName = CacheName.VERIFY_CODE_EMAIL;
      smsTemplateId = SmsTemplateId.ALiSMS_PhoneChange;
    }
    //企业注册
    else if (type == 7) {
      errorCode = ErrorCode.validate_error;
      preCacheName = CacheName.PRE_ORG_REGISTER;
      cacheName = CacheName.ORG_REGISTER;
      smsTemplateId = SmsTemplateId.ALiSMS_org_register;
    }
    //服务人员注册
    else {
      errorCode = ErrorCode.validate_error;
      preCacheName = CacheName.PRE_SMS_CODE_RG;
      cacheName = CacheName.VERIFY_CODE_RG;
      smsTemplateId = SmsTemplateId.ALiSMS_org_register;
    }
    if (preCacheName != null) {
      Cache preCache = cacheManager.getCache(preCacheName);
      String cachedVerifyCode = preCache.get(preCode, String.class);
      SmsException.assertIsTrue(RandomCodeHelper.checkCacheCode(preCode, cachedVerifyCode), ErrorCode.validate_error);
      preCache.evict(preCode);
    }
    boolean exists = userBaseInfoService.checkExists(phone);
    //注册
    if (type == 1 || type == 3) {
      exists = !exists;
      SmsException.assertIsTrue(exists, errorCode);
    }

    String verifyCode = RandomCodeHelper.random(6);
    Cache cache = cacheManager.getCache(cacheName);
    //非登陆时查看短信次数是否超过当天限制
    if (type != 0) {
      checkSmsCount(cache, phone);
    }
    cache.put(phone, verifyCode);
    incrementSmsCount(cache, phone);

    String testMsg = null;
    //未开起短信服务
    if (smsService == null || !smsEnable) {
      testMsg = "{\"code\":\"" + verifyCode + "\", \"msg\":\"短信发送服务未开启\"}";
    }
    //开起短信服务
    else {
      Map<String, Object> extras = Maps.newHashMap();
      extras.put("code", verifyCode);
      //      long expireMinutes =  cacheManager.getCache(cacheName).getDefaultExpiresSecond() / 60;
      //      extras.put("LASTTIME", expireMinutes);
      smsService.sendSmsSync(phone, null, smsTemplateId, extras);
      cacheManager.getCache(CacheName.USER_SMS_LASTTIME).put(phone, System.currentTimeMillis());
    }
    return new ResponseEntity<>(testMsg, HttpStatus.OK);
  }

  /**
   * 过滤过于频繁的短信发送请求
   *
   * @param phone
   */
  private void filterSmsReq(String phone) {
    org.springframework.cache.Cache.ValueWrapper lasttime = cacheManager.getCache(CacheName.USER_SMS_LASTTIME)
                                                                        .get(phone);
    SmsException
      .assertIsTrue(lasttime.get() == null || (System.currentTimeMillis() - ((long) lasttime.get())) >= smsReqLimit,
                    ErrorCode.request_frequently
      );
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
    SmsException.assertIsTrue(params.get("phone") != null, ErrorCode.phone_empty);
    String phone = params.get("phone");
    SmsException.assertIsTrue(checkPhone(phone), ErrorCode.phone_error);
    SmsException.assertIsTrue(params.get("code") != null, ErrorCode.validate_empty);
    String code = params.get("code");
    SmsException.assertIsTrue(params.get("type") != null, ErrorCode.type_empty);
    int type = Integer.parseInt(params.get("type"));
    SmsException.assertIsTrue(type >= 0 && type <= 8, ErrorCode.type_error);
    CacheName cacheName;
    //登录
    if (type == 0) {
      cacheName = CacheName.VERIFY_CODE_LG;
    }
    //注册
    else if (type == 1) {
      cacheName = CacheName.VERIFY_CODE_RG;
    }
    //找回密码
    else if (type == 2) {
      cacheName = CacheName.VERIFY_CODE_CP;
    }
    //修改手机号
    else if (type == 3) {
      cacheName = CacheName.VERIFY_CODE_PHONE;
    }
    //余额提现
    else if (type == 4) {
      cacheName = CacheName.VERIFY_CODE_TX;
    }
    //登录密码错误超过限制
    else if (type == 5) {
      cacheName = null;
    }
    //修改邮箱或者验证原手机号
    else if (type == 6) {
      cacheName = CacheName.VERIFY_CODE_EMAIL;
    }
    //企业注册
    else if (type == 7) {
      cacheName = CacheName.ORG_REGISTER;
    }
    //服务人员注册
    else {
      cacheName = CacheName.VERIFY_CODE_RG;
    }
    Cache preCache = cacheManager.getCache(cacheName);
    String cachedVerifyCode = preCache.get(phone, String.class);
    SmsException.assertIsTrue(RandomCodeHelper.checkCacheCode(code, cachedVerifyCode), ErrorCode.validate_error);
    return new ResponseEntity<>(HttpStatus.OK);
  }



  private void checkSmsCount(Cache cache, String phone) {
    String key = SMS_COUNT_EXPIRE_KEY_PREFIX + phone;
    Integer count = cache.get(key, Integer.class);
    SmsException.assertIsTrue(count == null || count < smsCountOfDay, ErrorCode.count_limit.getCode(),
                              ErrorCode.count_limit.getInfo().replace("{count}", String.valueOf(smsCountOfDay))
    );
  }

  private void incrementSmsCount(Cache cache, String phone) {
    //生成失效时间：当天最后一毫秒，此操作需在获取缓存之前执行
    Date expireDate = DateTime.now().millisOfDay().withMaximumValue().toDate();
    String key = SMS_COUNT_EXPIRE_KEY_PREFIX + phone;
    Integer count = cache.get(key, Integer.class);
    if (count == null) {
      count = 1;
    } else {
      count++;
    }
    cache.put(key, count);
    cache.expireAt(key, expireDate);
  }

  private Pattern phonePattern = Pattern.compile("^[1][3-9]\\d{9}$");

  public boolean checkPhone(String phone) {
    Matcher m = phonePattern.matcher(phone);
    return m.matches();
  }

  private Cache jugdeType(Map<String, String> params) {
    SmsException.assertIsTrue(params.get("type") != null, ErrorCode.type_empty);
    int type = Integer.parseInt(params.get("type"));
    SmsException.assertIsTrue(type >= 0 && type <= 9, ErrorCode.type_error);
    CacheName cacheName;
    //登录
    if (type == 0) {
      cacheName = CacheName.PRE_SMS_CODE_LG;
    }
    //注册
    else if (type == 1) {
      cacheName = CacheName.PRE_SMS_CODE_RG;
    }
    //找回密码
    else if (type == 2) {
      cacheName = CacheName.PRE_SMS_CODE_CP;
    }
    //修改手机号
    else if (type == 3) {
      cacheName = CacheName.PRE_SMS_CODE_PHONE;
    }
    //余额提现
    else if (type == 4) {
      cacheName = CacheName.PRE_SMS_CODE_TX;
    }
    //登录密码错误超过限制
    else if (type == 5) {
      cacheName = CacheName.PRE_SMS_ERROR_PASSWORD_CODE_LG;
    }
    //修改邮箱或者验证原手机号
    else if (type == 6) {
      cacheName = CacheName.PRE_SMS_CODE_EMAIL;
    }
    //机构注册
    else if (type == 7) {
      cacheName = CacheName.PRE_ORG_REGISTER;
    }
    //服务人员注册
    else if (type == 8) {
      cacheName = CacheName.PRE_SMS_CODE_RG;
    }
    //余额支付
    else {
      cacheName = CacheName.PRE_BALANCE_PAY;
    }
    Cache preCache = cacheManager.getCache(cacheName);
    return preCache;
  }


  /**
   * 获取decryptJs
   *
   * @return
   */
  private String getDecryptJs() {
    String decryptJs = "";
    Random r = new Random();
    int i = r.nextInt(3) + 1;
    switch (i) {
      case 1:
        decryptJs = CaptchaUtil.jsDecrypt_1;
        break;
      case 2:
        decryptJs = CaptchaUtil.jsDecrypt_2;
        break;
      case 3:
        decryptJs = CaptchaUtil.jsDecrypt_3;
        break;
      default:
        decryptJs = CaptchaUtil.jsDecrypt_1;
        break;
    }
    return decryptJs;
  }


  /**
   * 获取余额支付验证码
   *
   * @param params -
   * <p> phone             - Notnull  - Str - 电话
   * <p> orderCode         - Notnull  - Str - 订单编号
   * <p> preCode           - Notnull  - Str - 发送前code
   * @param request
   *
   * @return
   */
  @GetMapping(value = "/edge/sms/pay/code", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity smsPayVerifyCode(@RequestParam Map<String, String> params, HttpServletRequest request) {
    SmsException.assertIsTrue(params.get("phone") != null, ErrorCode.phone_empty);
    String phone = params.get("phone");
    filterSmsReq(phone);
    SmsException.assertIsTrue(checkPhone(phone), ErrorCode.phone_error);
    SmsException.assertIsTrue(params.get("preCode") != null, ErrorCode.validate_empty);
    String preCode = params.get("preCode");
    SmsException.assertIsTrue(params.get("orderCode") != null, ErrorCode.order_code_null);
    String orderCode = params.get("orderCode");

    // 发送前的code验证
    CacheName preCacheName = CacheName.PRE_BALANCE_PAY;
    Cache preCache = cacheManager.getCache(preCacheName);
    String cachedVerifyCode = preCache.get(preCode, String.class);
    SmsException.assertIsTrue(RandomCodeHelper.checkCacheCode(preCode, cachedVerifyCode), ErrorCode.validate_error);
    preCache.evict(preCode);

    CacheName cacheName = CacheName.BALANCE_PAY;
    String verifyCode = RandomCodeHelper.random(6);
    Cache cache = cacheManager.getCache(cacheName);
    String key = phone + orderCode;
    cache.put(key, verifyCode);

    String testMsg = null;
    //未开起短信服务
    if (smsService == null || !smsEnable) {
      testMsg = "{\"code\":\"" + verifyCode + "\", \"msg\":\"短信发送服务未开启\"}";
    }
    //开起短信服务
    else {
      Map<String, Object> extras = Maps.newHashMap();
      extras.put("code", verifyCode);
      smsService.sendSmsSync(phone, null, SmsTemplateId.ALiDaYu_balance_pay, extras);
      cacheManager.getCache(CacheName.USER_SMS_LASTTIME).put(phone, System.currentTimeMillis());
    }
    return new ResponseEntity<>(testMsg, HttpStatus.OK);
  }

  /**
   * 余额支付短信验证码-校验
   *
   * @param params -
   * <p> phone             - Notnull  - Str - 电话
   * <p> orderCode         - Notnull  - Str - 订单编号
   * <p> code              - Notnull  - Str - 短信验证码
   * @param request
   *
   * @return
   */
  @GetMapping(value = "/edge/sms/pay/validate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity smsPayValidate(@RequestParam Map<String, String> params, HttpServletRequest request) {
    SmsException.assertIsTrue(params.get("phone") != null, ErrorCode.phone_empty);
    String phone = params.get("phone");
    SmsException.assertIsTrue(checkPhone(phone), ErrorCode.phone_error);
    SmsException.assertIsTrue(params.get("code") != null, ErrorCode.validate_empty);
    String code = params.get("code");
    SmsException.assertIsTrue(params.get("orderCode") != null, ErrorCode.order_code_null);
    String orderCode = params.get("orderCode");
    CacheName cacheName = CacheName.BALANCE_PAY;
    Cache preCache = cacheManager.getCache(cacheName);
    String key = phone + orderCode;
    String cachedVerifyCode = preCache.get(key, String.class);
    return ResponseEntity.ok(RandomCodeHelper.checkCacheCode(code, cachedVerifyCode));
  }



}
