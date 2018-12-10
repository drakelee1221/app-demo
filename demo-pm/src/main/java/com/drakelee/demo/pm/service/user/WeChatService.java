package com.drakelee.demo.pm.service.user;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.common.constants.PreCreateType;
import com.drakelee.demo.common.constants.pay.WechatTradeStatus;
import com.drakelee.demo.common.constants.product.PayStatus;
import com.drakelee.demo.common.constants.weChat.TemplateMsgReceiveStatus;
import com.drakelee.demo.common.constants.weChat.WxMsgTemplate;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.common.domain.user.WeixinMsgLog;
import com.drakelee.demo.database.dao.user.UserBaseInfoDao;
import com.drakelee.demo.database.dao.user.WeixinMsgLogDao;
import com.drakelee.demo.pm.configuration.OfficialAccountsProperties;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.github.binarywang.wxpay.bean.notify.WxPayNotifyResponse;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.bean.result.WxPayUnifiedOrderResult;
import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.constant.WxPayConstants;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.util.SignUtils;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.common.util.RandomUtils;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.WxMpTemplateMsgService;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.lang.invoke.MethodHandles;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * WeiXinService
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-16 14:54
 */
@Service
@RefreshScope
@ConfigurationProperties(prefix = "base.pm.wechat.messgae")
public class WeChatService {
  private static final Logger logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
  @Autowired
  private WxMpService mpService;
  @Autowired
  private UserBaseInfoService userBaseInfoService;
  @Autowired
  private UserBaseInfoDao baseInfoDao;
  @Autowired
  private WxMpTemplateMsgService msgService;
  @Autowired
  private WeixinMsgLogDao msgLogDao;
  @Autowired
  private WxPayService wxPayService;
  @Autowired
  private OfficialAccountsProperties accountsProperties;
//  @Autowired
//  private PayService payService;
  @Autowired
  private WxMaService wxMaService;
  /**
   * 公众号消息穿透配置
   */
  private Map<String, String> penetrate;

  /**
   * 微信绑定
   *
   * @param phone 手机号
   *
   * @throws WxErrorException
   */
  public void bind(String phone, WxMpUser wxUser) {
    String nickName = wxUser.getNickname();
    String headImgUrl = wxUser.getHeadImgUrl();
    UserBaseInfo userBaseInfo = userBaseInfoService.findUserByPhone(phone);
    Assert.notNull(userBaseInfo, "未找到对应用户");
    if (StringUtils.isBlank(wxUser.getNickname())) {
      nickName = userBaseInfo.getUserNickName();
    }
    userBaseInfo.setOpenId(wxUser.getOpenId());
    userBaseInfo.setWxName(nickName);
    userBaseInfo.setWxImg(headImgUrl);
    baseInfoDao.saveAndFlush(userBaseInfo);
  }

  /**
   * 根据code获取微信用户
   *
   * @param code
   *
   * @return
   *
   * @throws WxErrorException
   */
  public WxMpUser verifyCode(String code) throws WxErrorException {
    WxMpOAuth2AccessToken accessToken = mpService.oauth2getAccessToken(code);
    //获取微信用户信息
    return mpService.oauth2getUserInfo(accessToken, null);
  }

  /**
   * 根据小程序code获取微信用户
   *
   * @param code
   *
   * @return
   *
   * @throws WxErrorException
   */
  public WxMaJscode2SessionResult verifyMiniCode(String code) throws WxErrorException {
    return wxMaService.jsCode2SessionInfo(code);
  }


  /**
   * 根据openId获取用户信息
   *
   * @param openId
   *
   * @return
   */
  public UserBaseInfo verifyOpenId(String openId) {
    return baseInfoDao.findByOpenId(openId);
  }


  /**
   * 微信解绑
   *
   * @param userId
   */
  public void unBind(String userId) {
    Optional<UserBaseInfo> user = baseInfoDao.findById(userId);
    Assert.isTrue(user.isPresent(), "user is not present!");
    UserBaseInfo userBaseInfo = user.get();
    userBaseInfo.setOpenId(null);
    userBaseInfo.setWxName(null);
    userBaseInfo.setWxImg(null);
    baseInfoDao.saveAndFlush(userBaseInfo);
  }

  /**
   * 获取微信绑定状态
   *
   * @param userId
   *
   * @return
   */
  public boolean getBoundStates(String userId) {
    Optional<UserBaseInfo> user = baseInfoDao.findById(userId);
    Assert.isTrue(user.isPresent(), "user is not present!");
    UserBaseInfo userBaseInfo = user.get();
    return StringUtils.isNotBlank(userBaseInfo.getOpenId());
  }

  /**
   * 公众号消息发送
   *
   * @param userId 发送用户id
   * @param receiveId 接受用户id
   * @param template 消息模板
   * @param params 模板参数
   *
   * @throws WxErrorException
   */
  @Transactional(rollbackFor = Exception.class)
  public void sendWxMessage(String userId, String receiveId, WxMsgTemplate template, Map<String, String> params) {
    String[] ids = receiveId.split(",");
    if(ids.length == 0){
      return;
    }
    List<UserBaseInfo> user = baseInfoDao.findAllById(Arrays.asList(ids));
    user.forEach(userBaseInfo -> {
      //未绑定时，不发送消息
      if (StringUtils.isNotBlank(userBaseInfo.getOpenId())) {
        WxMpTemplateMessage.WxMpTemplateMessageBuilder mpTemplateMessage = WxMpTemplateMessage.builder();
        mpTemplateMessage.templateId(template.getTemplateId());
        mpTemplateMessage.toUser(userBaseInfo.getOpenId());
        //设置参数
        List<WxMpTemplateData> dataList = new ArrayList<>();
        for (Map.Entry<String, String> entry : params.entrySet()) {
          WxMpTemplateData templateData = new WxMpTemplateData();
          templateData.setName(entry.getKey());
          templateData.setValue(entry.getValue());
          dataList.add(templateData);
        }
        String url = penetrate.get(template.toString());
        if(StringUtils.isNotBlank(params.get("wxMessageUrl"))){
          url = penetrate.get(params.get("wxMessageUrl"));
        }
        logger.info("template:"+template.toString());
        if (StringUtils.isNotBlank(url)) {
          String urlParams = params.get("urlParams");
          logger.info("urlParams:" + urlParams);
          String penetrateUrl = url;
          if (StringUtils.isNotBlank(urlParams)) {
            penetrateUrl = String.format(url, (Object[]) urlParams.split(","));
          }
          mpTemplateMessage.url(penetrateUrl);
          logger.info("parseUrl:" + penetrateUrl);
        }
        mpTemplateMessage.data(dataList);
        String msgId = null;
        try {
          msgId = msgService.sendTemplateMsg(mpTemplateMessage.build());
        } catch (WxErrorException e) {
          logger.error(e.getMessage());
        }
        //消息发送记录
        WeixinMsgLog msgLog = new WeixinMsgLog();
        msgLog.setMsgId(msgId);
        msgLog.setOpenId(userBaseInfo.getOpenId());
        msgLog.setReceiveId(receiveId);
        msgLog.setSendTime(new Date());
        msgLog.setTemplateId(template.getTemplateId());
        msgLog.setUserId(userId);
        msgLog.setWxName(userBaseInfo.getWxName());
        msgLog.setTemplateName(template.getDesc());
        msgLogDao.saveAndFlush(msgLog);
      }
    });

  }

  /**
   * 更新公众号消息接受状态
   *
   * @param msgId 消息id
   * @param status
   */
  @Transactional(rollbackFor = Exception.class)
  public void updateMsgStatus(Long msgId, String status) {
    ConditionGroup<WeixinMsgLog> condition = ConditionGroup.build().addCondition("msgId", ConditionEnum.OPERATE_EQUAL,
                                                                                 String.valueOf(msgId));
    Optional<WeixinMsgLog> optionalMsgLog = msgLogDao.findOne(condition);
    Assert.isTrue(optionalMsgLog.isPresent(), "WeixinMsgLog " + msgId + " is not present");
    WeixinMsgLog msgLog = optionalMsgLog.get();
    TemplateMsgReceiveStatus logStatus = EnumUtil.parse(TemplateMsgReceiveStatus.class, "weChatVal", status);
    Assert.notNull(logStatus, "未找到对应状态值：" + status);
    msgLog.setRecevieStatus(logStatus.getVal());
    msgLogDao.saveAndFlush(msgLog);
  }

  /**
   * pc发起订单支付
   *
   * @param desc 商品描述
   * @param total 总金额（分）
   * @param orderNo 订单编号
   * @param orderCreateTime 订单创建时间
   * @param orderExpireTime 订单过期时间
   * @param ip 终端ip
   *
   * @return 二维码地址
   *
   * @throws WxPayException
   */
  public String weChatPreCreate(String desc, Integer total, String orderNo, String orderCreateTime,
                                String orderExpireTime, String ip, PreCreateType type) throws Exception {
    WxPayUnifiedOrderRequest.WxPayUnifiedOrderRequestBuilder orderRequest = WxPayUnifiedOrderRequest.newBuilder();
    //商品描述
    orderRequest.body(desc);
    //总金额
    orderRequest.totalFee(total);
    //商品id
    orderRequest.productId(orderNo);
    orderRequest.outTradeNo(orderNo);
    if (StringUtils.isNotBlank(orderCreateTime)) {
      //订单生成时间
      orderRequest.timeStart(orderCreateTime);
    }
    if (StringUtils.isNotBlank(orderExpireTime)) {
      //订单失效时间
      orderRequest.timeExpire(orderExpireTime);
    }
    //终端IP
    orderRequest.spbillCreateIp(ip);
    orderRequest.attach(String.valueOf(type.getVal()));
    WxPayConfig config = wxPayService.getConfig();
    if (config.isUseSandboxEnv()) {
      if (StringUtils.isBlank(accountsProperties.getSandboxKey())) {
        accountsProperties.setSandboxKey(wxPayService.getSandboxSignKey());
      }
      config.setMchKey(accountsProperties.getSandboxKey());
    }
    WxPayUnifiedOrderResult wxPayUnifiedOrderResult = wxPayService.unifiedOrder(orderRequest.build());
    return wxPayUnifiedOrderResult.getCodeURL();
  }

  /**
   * 验证订单支付结果
   *
   * @param outTradeNo
   * @param transactionId
   * @param totalFee
   * @param timeEnd
   * @param attach
   * @param tradeCode
   *
   * @return
   *
   * @throws Exception
   */
  @Transactional(rollbackFor = Exception.class)
  public String verifyPayResult(String outTradeNo, String transactionId, String totalFee, String timeEnd, String attach,
                                WechatTradeStatus tradeCode) throws Exception {
    //订单号
    PreCreateType createType = EnumUtil.parse(PreCreateType.class, "val", Integer.valueOf(attach));
    if (createType == null) {
      return WxPayNotifyResponse.fail("类型错误");
    }
    DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
    DateTime parse = DateTime.parse(timeEnd, format);
    Date payTime = parse.toDate();
    PayStatus payStatus;
    if (createType.equals(PreCreateType.ORDER)) {
//      ProductOrder productOrder = orderDao.findByPayStatusAndOrderCode(PayStatus.paying.getVal(), outTradeNo);
//      if (productOrder == null) {
//        return WxPayNotifyResponse.success("校验成功");
//      }

      if (tradeCode.equals(WechatTradeStatus.SUCCESS)) {
        //支付金额
        String orderAmount = "1.00";
        if (accountsProperties.isPayTest()) {
          orderAmount = "0.01";
        }
        if (!orderAmount.equals(totalFee)) {
          logger.error("orderNo:" + outTradeNo + "支付金额不匹配，应付金额：" + orderAmount + "元");
          //支付金额不匹配
          return WxPayNotifyResponse.fail("支付金额不匹配，应付金额：" + orderAmount + "元");
        }
        payStatus = PayStatus.pay_success;

      } else {
        logger.info("orderNo:" + outTradeNo + " 支付失败");
        payStatus = PayStatus.pay_fail;
      }
//      payService.updateOrderPayStatus(productOrder, payStatus, transactionId, payTime, TransactionChannel.WECHAT);
    } else if (createType.equals(PreCreateType.RECHARGE)) {
//      Recharge recharge = rechargeDao.findByStatusAndRechargeNo(PayStatus.paying.getVal(), outTradeNo);
//      if (recharge == null) {
//        return WxPayNotifyResponse.success("校验成功");
//      }

      if (tradeCode.equals(WechatTradeStatus.SUCCESS)) {
//        BigDecimal payAmount = recharge.getAmount();
        BigDecimal payAmount = BigDecimal.valueOf(1);
        String payAmountStr = payAmount.setScale(2, BigDecimal.ROUND_FLOOR).toPlainString();
        if (accountsProperties.isPayTest()) {
          payAmountStr = "0.01";
        }
        if (!totalFee.equals(payAmountStr)) {
//          logger.info("rechargeNo:" + recharge.getRechargeNo() + "，充值支付金额不匹配，应付金额：" + payAmountStr);
          return WxPayNotifyResponse.fail("充值支付金额不匹配，应付金额：" + payAmountStr);
        }
        payStatus = PayStatus.pay_success;
      } else {
//        logger.info("rechargeNo:" + recharge.getRechargeNo() + ",支付失败");
        payStatus = PayStatus.pay_fail;
      }
//      payService.updateRechargePayStatus(recharge, payStatus, transactionId, payTime, TransactionChannel.WECHAT);
    }
    return WxPayNotifyResponse.success("校验成功");
  }

  /**
   * H5订单支付
   *
   * @param desc
   * @param total
   * @param orderNo
   * @param orderCreateTime
   * @param orderExpireTime
   * @param ip
   * @param type
   *
   * @return
   *
   * @throws Exception
   */
  public String h5WeChatPreCreate(String desc, int total, String orderNo, String orderCreateTime,
                                  String orderExpireTime, String ip, PreCreateType type) throws Exception {
    WxPayUnifiedOrderRequest.WxPayUnifiedOrderRequestBuilder orderRequest = WxPayUnifiedOrderRequest.newBuilder();
    //商品描述
    orderRequest.body(desc);
    //总金额
    orderRequest.totalFee(total);
    //商品id
    orderRequest.productId(orderNo);
    orderRequest.outTradeNo(orderNo);
    if (StringUtils.isNotBlank(orderCreateTime)) {
      //订单生成时间
      orderRequest.timeStart(orderCreateTime);
    }
    if (StringUtils.isNotBlank(orderExpireTime)) {
      //订单失效时间
      orderRequest.timeExpire(orderExpireTime);
    }
    //终端IP
    orderRequest.spbillCreateIp(ip);
    orderRequest.attach(String.valueOf(type.getVal()));
    orderRequest.tradeType(WxPayConstants.TradeType.MWEB);
    WxPayConfig config = wxPayService.getConfig();
    if (config.isUseSandboxEnv()) {
      if (StringUtils.isBlank(accountsProperties.getSandboxKey())) {
        accountsProperties.setSandboxKey(wxPayService.getSandboxSignKey());
      }
      config.setMchKey(accountsProperties.getSandboxKey());
    }
    WxPayUnifiedOrderResult wxPayUnifiedOrderResult = wxPayService.unifiedOrder(orderRequest.build());
    return wxPayUnifiedOrderResult.getMwebUrl();
  }

  public String h5WeChatBrowserPreCreate(String desc, int total, String orderNo, String orderCreateTime,
                                         String orderExpireTime, String ip, PreCreateType type, String openId)
    throws Exception {
    WxPayUnifiedOrderRequest.WxPayUnifiedOrderRequestBuilder orderRequest = WxPayUnifiedOrderRequest.newBuilder();
    //商品描述
    orderRequest.body(desc);
    //总金额
    orderRequest.totalFee(total);
    //商品id
    orderRequest.productId(orderNo);
    orderRequest.outTradeNo(orderNo);
    orderRequest.openid(openId);
    if (StringUtils.isNotBlank(orderCreateTime)) {
      //订单生成时间
      orderRequest.timeStart(orderCreateTime);
    }
    if (StringUtils.isNotBlank(orderExpireTime)) {
      //订单失效时间
      orderRequest.timeExpire(orderExpireTime);
    }
    //终端IP
    orderRequest.spbillCreateIp(ip);
    orderRequest.attach(String.valueOf(type.getVal()));
    orderRequest.tradeType(WxPayConstants.TradeType.JSAPI);
    WxPayConfig config = wxPayService.getConfig();
    if (config.isUseSandboxEnv()) {
      if (StringUtils.isBlank(accountsProperties.getSandboxKey())) {
        accountsProperties.setSandboxKey(wxPayService.getSandboxSignKey());
      }
      config.setMchKey(accountsProperties.getSandboxKey());
    }
    WxPayUnifiedOrderResult wxPayUnifiedOrderResult = wxPayService.unifiedOrder(orderRequest.build());
    Map<String, String> param = new HashMap<>(6);
    String prepayId = wxPayUnifiedOrderResult.getPrepayId();
    config.getAppId();
    param.put("appId", config.getAppId());
    DateTime now = DateTime.now();
    DateTimeFormatter format = DateTimeFormat.forPattern("yyyyMMddHHmmss");
    String timeStamp = now.toString(format);
    param.put("timeStamp", timeStamp);
    param.put("nonceStr", RandomUtils.getRandomStr());
    param.put("package", "prepay_id=" + prepayId);
    param.put("signType", config.getSignType());
    String sign = SignUtils.createSign(param, config.getSignType(), config.getMchKey(), false);
    param.put("paySign", sign);
    ObjectNode paramObj = JsonUtils.convert(param, ObjectNode.class);
    return paramObj.toString();

  }

  public Map<String, String> getPenetrate() {
    return penetrate;
  }

  public void setPenetrate(Map<String, String> penetrate) {
    this.penetrate = penetrate;
  }

  public Optional<UserBaseInfo> verifyMiniOpenId(String openId) {
    return baseInfoDao.findByMiniOpenId(openId);
  }
}
