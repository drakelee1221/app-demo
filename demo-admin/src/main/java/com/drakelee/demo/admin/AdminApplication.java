

package com.drakelee.demo.admin;

import com.base.components.common.configuration.CustomSystemPropertiesConfiguration;
import com.base.components.common.boot.BannerPrinter;
import com.base.components.common.boot.SpringBootApplicationRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

/**
 * @author <a href="yijianhua@xianyunsoft.com">Yi Jianhua</a>
 * @version 1.0.0, 2017-11-27
 */
@EnableEurekaClient
@SpringBootApplication(scanBasePackages = {"com.base.components.**","com.drakelee.demo.**"})
public class AdminApplication {

  /**
   * The entry point of application.
   *
   * @param args the input arguments
   */
  public static void main(String[] args) {
    CustomSystemPropertiesConfiguration.INSTANCE
      .configApplicationRandomServerPort(60030)
      .configApplicationShortName("admin");
    SpringBootApplicationRunner.run(AdminApplication.class, BannerPrinter.create(), args);
  }
}
