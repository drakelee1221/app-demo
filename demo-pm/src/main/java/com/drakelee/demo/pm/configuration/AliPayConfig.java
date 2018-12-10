package com.drakelee.demo.pm.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

/**
 * AliPayConfig
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-20 15:59
 */
@Configuration
@RefreshScope
public class AliPayConfig {
  @Value("${base.pm.alipay.appId}")
  private String appId;
  @Value("${base.pm.alipay.privateKey}")
  private String privateKey;
  @Value("${base.pm.alipay.publicKey}")
  private String publicKey;
  @Value("${base.pm.alipay.getway}")
  private String getway;
  @Value("${base.pm.alipay.sandboxGetway}")
  private String sandboxGetway;
  @Value("${base.pm.alipay.aesKey}")
  private String aesKey;
  @Value("${base.pm.alipay.notifyUrl}")
  private String notifyUrl;
  @Value("${base.pm.alipay.recharge_notifyUrl}")
  private String rechargeNotifyUrl;
  @Value("${base.pm.alipay.useSandboxEnv}")
  private boolean useSandboxEnv;
  /**
   * 订单超时时间
   */
  @Value("${base.pm.alipay.timeout}")
  private String timeout;
  @Value("${base.pm.alipay.sellerId}")
  private String sellerId;
  @Value("${base.pm.alipay.refundUrl}")
  private String refundUrl;
  @Value("${base.pm.alipay.returnUrl}")
  private String returnUrl;
  public String getAppId() {
    return appId;
  }

  public void setAppId(String appId) {
    this.appId = appId;
  }

  public String getPrivateKey() {
    return privateKey;
  }

  public void setPrivateKey(String privateKey) {
    this.privateKey = privateKey;
  }

  public String getPublicKey() {
    return publicKey;
  }

  public void setPublicKey(String publicKey) {
    this.publicKey = publicKey;
  }

  public String getGetway() {
    return getway;
  }

  public void setGetway(String getway) {
    this.getway = getway;
  }

  public String getSandboxGetway() {
    return sandboxGetway;
  }

  public void setSandboxGetway(String sandboxGetway) {
    this.sandboxGetway = sandboxGetway;
  }

  public String getAesKey() {
    return aesKey;
  }

  public void setAesKey(String aesKey) {
    this.aesKey = aesKey;
  }

  public String getNotifyUrl() {
    return notifyUrl;
  }

  public void setNotifyUrl(String notifyUrl) {
    this.notifyUrl = notifyUrl;
  }

  public boolean isUseSandboxEnv() {
    return useSandboxEnv;
  }

  public void setUseSandboxEnv(boolean useSandboxEnv) {
    this.useSandboxEnv = useSandboxEnv;
  }

  public String getTimeout() {
    return timeout;
  }

  public void setTimeout(String timeout) {
    this.timeout = timeout;
  }

  public String getSellerId() {
    return sellerId;
  }

  public void setSellerId(String sellerId) {
    this.sellerId = sellerId;
  }

  public String getRechargeNotifyUrl() {
    return rechargeNotifyUrl;
  }

  public void setRechargeNotifyUrl(String rechargeNotifyUrl) {
    this.rechargeNotifyUrl = rechargeNotifyUrl;
  }

  public String getRefundUrl() {
    return refundUrl;
  }

  public void setRefundUrl(String refundUrl) {
    this.refundUrl = refundUrl;
  }

  public String getReturnUrl() {
    return returnUrl;
  }

  public void setReturnUrl(String returnUrl) {
    this.returnUrl = returnUrl;
  }
}
