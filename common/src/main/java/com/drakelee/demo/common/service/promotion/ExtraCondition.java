package com.drakelee.demo.common.service.promotion;

import com.google.common.collect.Maps;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * ExtraCondition
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/11/8 0008 16:37
 */
public class ExtraCondition {

  @ConfigurationProperties("base.pm.promotion")
  @Component("extraCondition")
  @RefreshScope
  public static class extraConditions {

    private Map<String, Map<String,String>> extraCondition = Maps.newHashMap();

    public Map<String, Map<String,String>> getExtraCondition() {
      return extraCondition;
    }
  }

}
