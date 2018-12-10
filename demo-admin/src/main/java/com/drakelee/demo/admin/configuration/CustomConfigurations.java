
package com.drakelee.demo.admin.configuration;

import com.google.common.collect.Sets;
import com.drakelee.demo.admin.interceptors.AdminAuthInterceptor;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.base.components.common.interceptors.TokenObjReceiveInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Set;

/**
 * 启动相关配置
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-10
 */
@Configuration
@ConfigurationProperties("base.admin")
@RefreshScope
public class CustomConfigurations {
  private Set<String> authExcludePath = Sets.newHashSet();
  @Autowired
  private AdminAuthInterceptor adminAuthInterceptor;

  @Bean
  public WebMvcConfigurer crossConfiguration(SysMemberService sysMemberService) {
    String[] excludePath = authExcludePath.toArray(new String[authExcludePath.size()]);
    return new WebMvcConfigurer() {
      /**
       * token对象对象拦截
       */
      @Override
      public void addInterceptors(InterceptorRegistry registry) {
        //获取上游服务传递过来的token对象
        registry.addInterceptor(new TokenObjReceiveInterceptor()).addPathPatterns("/admin/**")
                .excludePathPatterns(excludePath);
        registry.addInterceptor(adminAuthInterceptor).addPathPatterns("/admin/**")
                .excludePathPatterns(excludePath);
      }
    };
  }

  public Set<String> getAuthExcludePath() {
    return authExcludePath;
  }

  public void setAuthExcludePath(Set<String> authExcludePath) {
    this.authExcludePath = authExcludePath;
  }
}
