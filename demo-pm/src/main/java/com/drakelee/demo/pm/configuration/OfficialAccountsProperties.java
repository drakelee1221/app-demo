package com.drakelee.demo.pm.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

/**
 * 公众号配置
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-16 13:32
 */
@Configuration
@RefreshScope
public class OfficialAccountsProperties {
  @Value("${base.pm.wechat.appId}")
  private  String appId;
  @Value("${base.pm.wechat.secret}")
  private String secret;
  @Value("${base.pm.wechat.token}")
  private String token;
  private String accessToken;
  @Value("${base.pm.wechat.aesKey}")
  private String aesKey;
  @Value("${base.pm.wechat.redirectUrl}")
  private String redirectUrl;
  @Value("${base.pm.wechat.autoLoginRedirectUrl}")
  private String autoLoginRedirectUrl;

  @Value("${base.pm.wechat.subAppId}")
  private String subAppId;
  @Value("${base.pm.wechat.mchId}")
  private String mchId;
  @Value("${base.pm.wechat.mchKey}")
  private String mchKey;
  @Value("${base.pm.wechat.subMchId}")
  private String subMchId;
  @Value("${base.pm.wechat.notifyUrl}")
  private String notifyUrl;
  @Value("${base.pm.wechat.tradeType}")
  private String tradeType;
  @Value("${base.pm.wechat.signType}")
  private String signType;
  @Value("${base.pm.wechat.keyPath}")
  private String keyPath;
  @Value("${base.pm.wechat.useSandboxEnv}")
  private boolean sandboxEnv;
  @Value("${base.pm.wechat.payTest}")
  private boolean payTest;
  @Value("${base.pm.wechat.refundUrl}")
  private String refundUrl;
  private String sandboxKey;

  public String getAppId() {
    return appId;
  }

  public void setAppId(String appId) {
    this.appId = appId;
  }

  public String getSecret() {
    return secret;
  }

  public void setSecret(String secret) {
    this.secret = secret;
  }

  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }

  public String getAccessToken() {
    return accessToken;
  }

  public void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  public String getAesKey() {
    return aesKey;
  }

  public void setAesKey(String aesKey) {
    this.aesKey = aesKey;
  }

  public String getRedirectUrl() {
    return redirectUrl;
  }

  public void setRedirectUrl(String redirectUrl) {
    this.redirectUrl = redirectUrl;
  }

  public String getAutoLoginRedirectUrl() {
    return autoLoginRedirectUrl;
  }

  public void setAutoLoginRedirectUrl(String autoLoginRedirectUrl) {
    this.autoLoginRedirectUrl = autoLoginRedirectUrl;
  }

  public String getSubAppId() {
    return subAppId;
  }

  public void setSubAppId(String subAppId) {
    this.subAppId = subAppId;
  }

  public String getMchId() {
    return mchId;
  }

  public void setMchId(String mchId) {
    this.mchId = mchId;
  }

  public String getMchKey() {
    return mchKey;
  }

  public void setMchKey(String mchKey) {
    this.mchKey = mchKey;
  }

  public String getSubMchId() {
    return subMchId;
  }

  public void setSubMchId(String subMchId) {
    this.subMchId = subMchId;
  }

  public String getNotifyUrl() {
    return notifyUrl;
  }

  public void setNotifyUrl(String notifyUrl) {
    this.notifyUrl = notifyUrl;
  }

  public String getTradeType() {
    return tradeType;
  }

  public void setTradeType(String tradeType) {
    this.tradeType = tradeType;
  }

  public String getSignType() {
    return signType;
  }

  public void setSignType(String signType) {
    this.signType = signType;
  }


  public String getKeyPath() {
    return keyPath;
  }

  public void setKeyPath(String keyPath) {
    this.keyPath = keyPath;
  }

  public boolean isSandboxEnv() {
    return sandboxEnv;
  }

  public void setSandboxEnv(boolean sandboxEnv) {
    this.sandboxEnv = sandboxEnv;
  }

  public String getSandboxKey() {
    return sandboxKey;
  }

  public void setSandboxKey(String sandboxKey) {
    this.sandboxKey = sandboxKey;
  }

  public boolean isPayTest() {
    return payTest;
  }

  public void setPayTest(boolean payTest) {
    this.payTest = payTest;
  }

  public String getRefundUrl() {
    return refundUrl;
  }

  public void setRefundUrl(String refundUrl) {
    this.refundUrl = refundUrl;
  }
}
