

package com.drakelee.demo.zuul;

import com.base.components.common.boot.BannerPrinter;
import com.base.components.common.boot.SpringBootApplicationRunner;
import com.base.components.common.configuration.CustomSystemPropertiesConfiguration;
import com.base.components.common.rpc.ribbon.CustomRibbonConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.hystrix.dashboard.EnableHystrixDashboard;
import org.springframework.cloud.netflix.ribbon.RibbonClients;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

/**
 * ZuulApplication
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-02-12 17:17
 *
 */
@EnableZuulProxy
@EnableEurekaClient
@EnableCircuitBreaker
@EnableHystrixDashboard
@SpringBootApplication(scanBasePackages = {"com.base.components.**","com.drakelee.demo.**"})
@RibbonClients(defaultConfiguration = CustomRibbonConfiguration.class)
public class ZuulApplication {
  public static void main(String[] args) {
    CustomSystemPropertiesConfiguration.INSTANCE
      .configApplicationServerPort(10010)
      .configApplicationShortName("zuul");
    SpringBootApplicationRunner.run(ZuulApplication.class, BannerPrinter.create(), args);
  }
}
