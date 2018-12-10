
package com.drakelee.demo.pm.configuration;

import com.base.components.common.interceptors.TokenObjReceiveInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 启动相关配置
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-10
 */
@Configuration
public class CustomConfigurations {

  @Bean
  public WebMvcConfigurer crossConfiguration() {
    return new WebMvcConfigurer() {

      /**
       * token对象对象拦截
       */
      @Override
      public void addInterceptors(InterceptorRegistry registry) {
        //获取上游服务传递过来的token对象
        registry.addInterceptor(new TokenObjReceiveInterceptor()).addPathPatterns("/**")
                .excludePathPatterns("/user/login**");
      }
    };
  }
}
