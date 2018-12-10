

package com.drakelee.demo.feign.configuration;

import com.base.components.feign.configuration.BaseFeignConfiguration;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

/**
 * Feign Configuration
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-30 15:29
 */
@Configuration
@EnableFeignClients(basePackages = {"com.drakelee.demo.feign.client.**"})
@AutoConfigureBefore(BaseFeignConfiguration.class)
public class CustomFeignConfiguration {
}
