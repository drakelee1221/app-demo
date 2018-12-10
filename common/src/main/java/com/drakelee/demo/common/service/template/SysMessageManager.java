package com.drakelee.demo.common.service.template;

import com.google.common.collect.Maps;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 系统消息模板获取
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/20 0020 15:34
 */
public class SysMessageManager {

  @ConfigurationProperties("base.common.sysmessage")
  @Component("sysMsgTemplates")
  @RefreshScope
  public static class Templates{

    private Map<String, String> sysTemplates = Maps.newHashMap();

    private Map<String, String> wechatTemplates = Maps.newHashMap();

    private Map<String, String> smsTemplates = Maps.newHashMap();

    public Map<String, String> getSysTemplates() {
      return sysTemplates;
    }

    public Map<String, String> getWechatTemplates() {
      return wechatTemplates;
    }

    public Map<String, String> getSmsTemplates() {
      return smsTemplates;
    }
  }

}
