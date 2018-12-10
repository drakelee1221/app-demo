

package com.drakelee.demo.pm.configuration;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * Google-Kaptcha
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-19 11:44
 */
@Configuration
@ConfigurationProperties("base.captcha")
@RefreshScope
public class CaptchaConfigurations {

  private Properties props = new Properties();

  @Bean
  public DefaultKaptcha defaultKaptcha() {
    Config config = new Config(props);
    DefaultKaptcha kp = new DefaultKaptcha();
    kp.setConfig(config);
    return kp;
  }

  public Properties getProps() {
    return props;
  }
}
