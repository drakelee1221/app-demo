package com.drakelee.demo.pm.controller.user;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import com.base.components.cache.Cache;
import com.base.components.cache.CacheManager;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.IPUtils;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.ServletContextHolder;
import com.base.components.common.util.UUIDUtils;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.pay.PaySource;
import com.drakelee.demo.common.constants.pay.WechatTradeStatus;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.pm.configuration.OfficialAccountsProperties;
import com.drakelee.demo.pm.service.user.UserBaseInfoService;
import com.drakelee.demo.pm.service.user.WeChatService;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.github.binarywang.wxpay.bean.notify.WxPayOrderNotifyResult;
import com.github.binarywang.wxpay.bean.notify.WxPayRefundNotifyResult;
import com.github.binarywang.wxpay.constant.WxPayConstants;
import com.github.binarywang.wxpay.service.WxPayService;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.common.util.crypto.SHA1;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import me.chanjar.weixin.mp.util.crypto.WxMpCryptUtil;
import me.chanjar.weixin.mp.util.xml.XStreamTransformer;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.invoke.MethodHandles;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

/**
 * WeiXinController
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-16 09:57
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
@RefreshScope
public class WeChatController {
  private static final Logger logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
  public static final String WX_AUTO_LOGIN_TOKEN_KEY = "__token__";
  public static final String WX_AUTO_LOGIN_TOKEN_TYPE_KEY = "__token_type__";
  public static final String WX_AUTO_LOGIN_TOKEN_TYPE_USER = "user";
  public static final String WX_AUTO_LOGIN_TOKEN_TYPE_WX = "wx";
  @Autowired
  private WxMpService mpService;
  @Autowired
  private OfficialAccountsProperties accountsProperties;
  @Autowired
  private UserBaseInfoService userBaseInfoService;
  @Autowired
  private WeChatService weChatService;
  @Autowired
  private WxMpMessageRouter messageRouter;
  @Autowired
  private WxPayService wxPayService;
  @Autowired
  private CacheManager cacheManager;
  @Autowired
  private WxMpConfigStorage configStorage;
//  @Autowired
//  private PayService payService;
  private static final String WECHAT_BIND_PREFIX = "bind_prefix_";
  @Value("${base.pm.wechat.success-url}")
  private String successUrl;
  @Value("${base.pm.wechat.mobileBindSuccess}")
  private String mobileBindSuccess;
  @Autowired
  private WxMaService maService;

  /**
   * 绑定微信
   * @param
   */
  @GetMapping("/weixin/binding")
  public ResponseEntity<String> bindWeiXinUserInfo(@RequestParam Map<String,String> params, HttpServletResponse response)
    throws WxErrorException, IOException {
    String code=params.get("code");
    String userId=params.get("userId");
    String state = params.get("state");
    //默认PC端绑定
    String bindType = ConvertUtil.convert(params.get("bindType"),PaySource.PC.getCode());
    logger.info("bindType:"+bindType+",state:"+state);
    if(StringUtils.isNotBlank(code) && StringUtils.isBlank(userId)){
      Assert.notNull(code,"code获取失败");
      Assert.notNull(state,"缺少必要参数state");
      String[] param = state.split("$");
      String phone = param[0];
      WxMpOAuth2AccessToken accessToken = mpService.oauth2getAccessToken(code);
      //获取微信用户信息
      WxMpUser wxUser = mpService.oauth2getUserInfo(accessToken, null);

      userBaseInfoService.clearOtherBind(wxUser.getOpenId(),phone);
      weChatService.bind(phone, wxUser);

      String key = WECHAT_BIND_PREFIX+phone;
      Cache cache = cacheManager.getCache(CacheName.WECHAT_BIND);
      cache.put(key,1);
      //设置绑定缓存 60秒
      cache.expire(key, 60, TimeUnit.SECONDS);
      String redirectUrl = mobileBindSuccess;
      if(param.length == 1 || param[1].equals(PaySource.PC.getCode())){
        redirectUrl = successUrl;
      }
      ServletContextHolder.sendRedirect(redirectUrl);
      return null;
    }else{
      Assert.notNull(userId,"缺少userId参数");
      UserBaseInfo user = userBaseInfoService.getOne(userId);
      String key = WECHAT_BIND_PREFIX+user.getPhone();
      Cache cache = cacheManager.getCache(CacheName.WECHAT_BIND);
      cache.put(key,0);
      cache.expire(key, 60, TimeUnit.SECONDS);
      String authUrl="";
      if(StringUtils.isBlank(bindType)
        || PaySource.WECHAT.getCode().equals(bindType)
        || PaySource.PC.getCode().equals(bindType)){
        //pc端 微信内部绑定
        authUrl=mpService.oauth2buildAuthorizationUrl(
          accountsProperties.getRedirectUrl(), WxConsts.OAuth2Scope.SNSAPI_USERINFO, user.getPhone());
      }else if(PaySource.WAP.getCode().equals(bindType)){
        //非微信内部浏览器绑定
        authUrl=mpService.buildQrConnectUrl(accountsProperties.getRedirectUrl(), WxConsts.OAuth2Scope.SNSAPI_USERINFO, user.getPhone()+"$"+bindType);
      }
      ServletContextHolder.sendRedirect(authUrl);
      return null;
    }

  }

  /**
   * 微信自动登录
   * @param params
   * @param response
   * @return
   * @throws WxErrorException
   * @throws IOException
   */
  @GetMapping("/weixin/autoLogin")
  public ResponseEntity  autoLogin(@RequestParam Map<String,String> params, HttpServletResponse response, HttpServletRequest request)
    throws WxErrorException, IOException {
    String code = params.get("code");
    String redirectUrl = params.get("redirectUrl");
    logger.info("redirectUrl:"+redirectUrl);
    String key;
    Cache cache = cacheManager.getCache(CacheName.WECHAT_REDIRECT);
    if(StringUtils.isNotBlank(code)){
      key = params.get("state");
      String url = cache.get(key, String.class);
      Assert.isTrue(StringUtils.isNotBlank(url),"无跳转地址");
      url = URLDecoder.decode(url, "UTF-8");
      String ip = IPUtils.getRealIp(request);
      WxMpUser wxMpUser = weChatService.verifyCode(code);
      String token = "NONE";
      String tokenType = "";
      if(wxMpUser != null && StringUtils.isNotBlank(wxMpUser.getOpenId())) {
        UserBaseInfo userInfo = weChatService.verifyOpenId(wxMpUser.getOpenId());
        if(userInfo != null) {
          params.put("loginIp", ip);
          params.put("wxName",wxMpUser.getNickname());
          params.put("wxImg",wxMpUser.getHeadImgUrl());
          params.put("openId",wxMpUser.getOpenId());
          ObjectNode tokenObjectNode=userBaseInfoService.userLogin(userInfo, params, true);
          ObjectNode userTokenObj = JsonUtils.findAndPutObjectNode(tokenObjectNode, "userToken");
          userTokenObj.put("openId", wxMpUser.getOpenId());
          token = userTokenObj.path("token").asText();
          tokenType = WX_AUTO_LOGIN_TOKEN_TYPE_USER;
          cacheManager.getCache(CacheName.WECHAT_LOGIN_TOKENOBJ).put(token, tokenObjectNode);
        }else{
          token = wxMpUser.getOpenId();
          tokenType = WX_AUTO_LOGIN_TOKEN_TYPE_WX;
          cacheManager.getCache(CacheName.WECHAT_LOGIN_TOKENOBJ).put(token, wxMpUser);
        }
      }
      url = (url + (url.contains("?")?"&":"?")+ WX_AUTO_LOGIN_TOKEN_KEY + "=" + token +
        "&" + WX_AUTO_LOGIN_TOKEN_TYPE_KEY + "=" + tokenType);
      ServletContextHolder.sendRedirect(url);
      return null;
    }else{
      key = UUIDUtils.generateKey();
      cache.put(key, URLEncoder.encode(redirectUrl, "UTF-8"));
      //设置绑定缓存 60秒
      cache.expire(key, 120, TimeUnit.SECONDS);
    }
    String authUrl = mpService.oauth2buildAuthorizationUrl(
      accountsProperties.getAutoLoginRedirectUrl(), WxConsts.OAuth2Scope.SNSAPI_USERINFO,key);
    ServletContextHolder.sendRedirect(authUrl);
    return null;
  }

  /**
   * 获取绑定地址
   * @return
   */
  @GetMapping(value = "/weixin/user/bind-address",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<String> getBindAddress(){
    String link = accountsProperties.getRedirectUrl()+"?userId="+TokenThreadLocal.getTokenObjNonNull().objId().toString();
    return new ResponseEntity<>(link, HttpStatus.OK);
  }
  /**
   * 获取用户id用于生成二维码链接参数
   * @return
   */
  @GetMapping(value = "/weixin/user/id",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<String> getUserId(){
    return new ResponseEntity<String>((String) TokenThreadLocal.getTokenObjNonNull().objId(), HttpStatus.OK);
  }

  /**
   * 解除绑定
   * @return
   */
  @PutMapping(value = "/weixin/unbind",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public void unBind(){
    weChatService.unBind((String) TokenThreadLocal.getTokenObjNonNull().objId());
  }

  /**
   * 获取用户微信绑定状态
   * @return
   */
  @GetMapping(value = "/weixin/binding/status",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getBindStates(){
    boolean isBound = weChatService.getBoundStates((String) TokenThreadLocal.getTokenObjNonNull().objId());
    return new ResponseEntity<>(isBound,HttpStatus.OK);
  }

  /**
   * 用于轮询获取用户微信绑定状态
   * @param phone
   * @return
   */
  @GetMapping(value = "/weixin/binding/circulation",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getBindStates(@RequestParam("phone") String phone){
    String key = WECHAT_BIND_PREFIX+phone;
    Cache cache = cacheManager.getCache(CacheName.WECHAT_BIND);
    Object o = cache.get(key).get();
    Integer rs = 0;
    if(o == null){
      boolean isBound = weChatService.getBoundStates((String) TokenThreadLocal.getTokenObjNonNull().objId());
      rs = isBound?1:0;
    }else{
      rs = Integer.valueOf(o.toString());
    }
    return new ResponseEntity<>(rs,HttpStatus.OK);
  }


  @GetMapping(value = "/weixin/msg/test",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity msgTest() throws WxErrorException {
    /*Map<String,String> params = new HashMap<>();
    params.put("userName","您好");
    weChatService
      .sendWxMessage("7946a3f9-9f49-4b65-ad42-5a75ca6088e9", "7946a3f9-9f49-4b65-ad42-5a75ca6088e9", WxMsgTemplate.TEST, params);*/
    return new ResponseEntity<>(HttpStatus.OK);
  }

  /**
   * 微信事件接收
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping(value = "/weixin/event")
  public String event(HttpServletRequest request) throws Exception {
    String msgSignature = request.getParameter("signature");
    String nonce = request.getParameter("nonce");
    String timestamp = request.getParameter("timestamp");
    String echostr = request.getParameter("echostr");

    Enumeration<String> parameterNames = request.getParameterNames();
    while (parameterNames.hasMoreElements()){
      logger.info("event param:"+parameterNames.nextElement());
    }
    logger.info("msg_signature:"+msgSignature);
    logger.info("nonce:"+nonce);
    logger.info("timestamp:"+timestamp);
    if(StringUtils.isNotBlank(echostr)){
      String[] s = {accountsProperties.getToken(),timestamp,nonce};
      Arrays.sort(s);
      String gen = SHA1.gen(s);
      logger.info("gen:"+gen);
      if(msgSignature.equals(gen)){
        return echostr;
      }
    }
    return "";
  }
  /**
   * 微信事件接收
   * @param request
   * @return
   * @throws Exception
   */
  @PostMapping(value = "/weixin/event")
  public String receiveEvent(HttpServletRequest request) throws Exception {
    String msgSignature = request.getParameter("msg_signature");
    String nonce = request.getParameter("nonce");
    String timestamp = request.getParameter("timestamp");

    Enumeration<String> parameterNames = request.getParameterNames();
    while (parameterNames.hasMoreElements()){
      logger.info("event param:"+parameterNames.nextElement());
    }
    logger.info("msg_signature:"+msgSignature+" nonce:"+nonce+" timestamp:"+timestamp);
    WxMpCryptUtil wxMpCryptUtil = new WxMpCryptUtil(configStorage);
    BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream()));
    StringBuilder stb = new StringBuilder();
    String line;
    while ((line = in.readLine()) != null) {
      stb.append(line);
    }
    logger.info(stb.toString());
    String decrypt = wxMpCryptUtil.decrypt(msgSignature, timestamp, nonce, stb.toString());
    logger.info(decrypt);
    WxMpXmlMessage message = XStreamTransformer.fromXml(WxMpXmlMessage.class, decrypt);
    WxMpXmlOutMessage route = messageRouter.route(message);
    return wxMpCryptUtil.encrypt(route.toString());
  }
  /**
   * 支付完成后微信通知地址
   * @param request
   * @return
   * @throws Exception
   */
  @PostMapping(value = "/weixin/pay/notify")
  public ResponseEntity payNotify(HttpServletRequest request) throws Exception {
    BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream()));
    StringBuilder stb = new StringBuilder();
    String line;
    while ((line = in.readLine()) != null) {
      stb.append(line);
    }
    WxPayOrderNotifyResult result = WxPayOrderNotifyResult.fromXML(stb.toString());
    logger.info("wechat notify", JsonUtils.convert(result, ObjectNode.class).toString());
    //校验
    /*WxPayServiceAbstractImpl abcPayService = new WxPayServiceApacheHttpImpl();
    abcPayService.setConfig(wxPayService.getConfig());*/
    result.checkResult(wxPayService, WxPayConstants.SignType.MD5, true);

    //校验支付结果
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
    SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String response = weChatService.verifyPayResult(result.getOutTradeNo(), result.getTransactionId(),
                                                    WxPayOrderNotifyResult.fenToYuan(result.getTotalFee()),
                                                    format1.format(format.parse(result.getTimeEnd())), result.getAttach(),
                                                    EnumUtil.parse(WechatTradeStatus.class,"code",result.getResultCode()));
    return new ResponseEntity<>(response,HttpStatus.OK);
  }
  /**
   * 微信退款通知
   * @param request
   * @return
   * @throws Exception
   */
  @PostMapping(value = "/weixin/refund/notify")
  public ResponseEntity refundNotify(HttpServletRequest request) throws Exception {
    BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream()));
    StringBuilder stb = new StringBuilder();
    String line;
    while ((line = in.readLine()) != null) {
      stb.append(line);
    }
    WxPayRefundNotifyResult result = WxPayRefundNotifyResult.fromXML(stb.toString(), accountsProperties.getMchKey());
    logger.info("退款通知", JsonUtils.convert(result, ObjectNode.class).toString());

//    String res = payService.refundSuccess(result.getReqInfo().getOutTradeNo(), result.getReqInfo().getRefundStatus(),
//                                            TransactionChannel.WECHAT);
//    return new ResponseEntity<>(res,HttpStatus.OK);
    return new ResponseEntity<>(HttpStatus.OK);
  }
  /**
   * 获取OpenId
   * @param params
   * <p>  code                      - Notnull   - Str - desc
   * @return
   * @throws WxErrorException
   */
  @RequestMapping(value = "/weixin/openId",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getOpenId(@RequestParam Map<String,String> params) throws WxErrorException {
    String code = ConvertUtil.checkNotNull(params, "code", "code不能为空", String.class);
    WxMaJscode2SessionResult accessToken = maService.jsCode2SessionInfo(code);
    return new ResponseEntity<>(accessToken.getOpenid(),HttpStatus.OK);
  }

  /**
   * 小程序自动登录
   * @param params
   * @param request
   * @return
   */
  @PostMapping(value = "/mini/autologin", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity miniAutoLogin(@RequestBody Map<String, String> params, HttpServletRequest request)
    throws WxErrorException {
    String code = ConvertUtil.checkNotNull(params, "code", String.class);
    WxMaJscode2SessionResult result = weChatService.verifyMiniCode(code);
    Optional<UserBaseInfo> userBaseInfo = weChatService.verifyMiniOpenId(result.getOpenid());
    if (!userBaseInfo.isPresent()) {
      return ResponseEntity.ok(JsonUtils.createObjectNode().set("userToken", JsonUtils.createObjectNode()
                                                                                      .put("miniOpenId",
                                                                                           result.getOpenid()
                                                                                      )));
    }
    params.put("loginIp", IPUtils.getRealIp(request));
    params.put("miniOpenId", result.getOpenid());
    ObjectNode tokenObjectNode = userBaseInfoService.userLogin(userBaseInfo.get(), params, true);
    return ResponseEntity.ok(tokenObjectNode);
  }
}
