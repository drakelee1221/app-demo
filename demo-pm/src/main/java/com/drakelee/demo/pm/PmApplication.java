

package com.drakelee.demo.pm;

import com.base.components.common.configuration.CustomSystemPropertiesConfiguration;
import com.base.components.common.boot.BannerPrinter;
import com.base.components.common.boot.SpringBootApplicationRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

/**
 * UserApplication
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-02-05 09:39
 *
 */
@EnableEurekaClient
@SpringBootApplication(scanBasePackages = {"com.base.components.**","com.drakelee.demo.**","me.chanjar.weixin.**"})
public class PmApplication {

  /**
   * The entry point of application.
   *
   * @param args the input arguments
   */
  public static void main(String[] args) {

    CustomSystemPropertiesConfiguration.INSTANCE
      .configApplicationRandomServerPort(60010)
//      .configApplicationServerPort(60010)
      .configApplicationShortName("pm");
    SpringBootApplicationRunner.run(PmApplication.class, BannerPrinter.create(), args);
  }
}
