package com.drakelee.demo.pm.configuration;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.config.WxMaConfig;
import cn.binarywang.wx.miniapp.config.WxMaInMemoryConfig;
import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceApacheHttpImpl;
import com.drakelee.demo.pm.handler.wx.TemplateSendEventHandler;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.WxMpTemplateMsgService;
import me.chanjar.weixin.mp.api.impl.WxMpServiceHttpClientImpl;
import me.chanjar.weixin.mp.api.impl.WxMpTemplateMsgServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * WeixinConfigurations
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-16 10:45
 */
@Configuration
public class WeChatConfigurations {
  @Bean
  @ConditionalOnMissingBean
  public WxMpConfigStorage initConfigStorage(@Autowired OfficialAccountsProperties accountsProperties){
    WxMpConfigRedisStorage configStorage = new WxMpConfigRedisStorage();
    configStorage.setAppId(accountsProperties.getAppId());
    configStorage.setSecret(accountsProperties.getSecret());
    configStorage.setToken(accountsProperties.getToken());
    configStorage.setAesKey(accountsProperties.getAesKey());
    return configStorage;
  }
  @Bean
  @ConditionalOnMissingBean
  public WxMpService initWxMpService(WxMpConfigStorage configStorage){
    WxMpService service = new WxMpServiceHttpClientImpl();
    service.setWxMpConfigStorage(configStorage);
    return service;
  }
  @Bean
  @ConditionalOnMissingBean
  public WxMpTemplateMsgService initTemplateMsgService(WxMpService mpService){
    return new WxMpTemplateMsgServiceImpl(mpService);
  }
  @Bean
  @ConditionalOnMissingBean
  public WxMpMessageRouter initRouter(WxMpService mpService, TemplateSendEventHandler templateSendEventHandler){
    WxMpMessageRouter router = new WxMpMessageRouter(mpService);
    router.rule().async(false)
          .msgType(WxConsts.XmlMsgType.EVENT)
          .event(WxConsts.EventType.TEMPLATE_SEND_JOB_FINISH)
          .handler(templateSendEventHandler).end();
    return router;
  }
  @Bean
  @ConditionalOnMissingBean
  @RefreshScope
  public WxPayService initPayService(@Autowired OfficialAccountsProperties accountsProperties){
    WxPayService payService = new WxPayServiceApacheHttpImpl();
    WxPayConfig payConfig = new WxPayConfig();
    payConfig.setAppId(accountsProperties.getAppId());
    payConfig.setSignType(accountsProperties.getSignType());
    payConfig.setKeyPath(accountsProperties.getKeyPath());
    payConfig.setMchId(accountsProperties.getMchId());
    payConfig.setMchKey(accountsProperties.getMchKey());
    payConfig.setNotifyUrl(accountsProperties.getNotifyUrl());
    payConfig.setSubAppId(accountsProperties.getSubAppId());
    payConfig.setSubMchId(accountsProperties.getSubMchId());
    payConfig.setTradeType(accountsProperties.getTradeType());
    payConfig.setUseSandboxEnv(accountsProperties.isSandboxEnv());
    payConfig.setKeyPath(accountsProperties.getKeyPath());
    payService.setConfig(payConfig);
    return payService;
  }
  @Bean
  @ConditionalOnMissingBean
  @RefreshScope
  public WxMaConfig maConfig(@Autowired WxMaProperties wxMaProperties) {
    WxMaInMemoryConfig config = new WxMaInMemoryConfig();
    config.setAppid(wxMaProperties.getAppid());
    config.setSecret(wxMaProperties.getSecret());
    config.setToken(wxMaProperties.getToken());
    config.setAesKey(wxMaProperties.getAesKey());
    config.setMsgDataFormat(wxMaProperties.getMsgDataFormat());

    return config;
  }
  @Bean
  @ConditionalOnMissingBean
  public WxMaService wxMaService(WxMaConfig maConfig) {
    WxMaService service = new WxMaServiceImpl();
    service.setWxMaConfig(maConfig);
    return service;
  }
}
