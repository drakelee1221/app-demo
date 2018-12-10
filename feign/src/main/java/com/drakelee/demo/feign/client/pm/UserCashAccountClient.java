package com.drakelee.demo.feign.client.pm;

import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

/**
 * UserClient
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version v1.0.0
 * @date 2018-11-14 16:16
 */
@FeignClient(value = "${module-pm}")
public interface UserCashAccountClient {

  /**
   * 提现
   * @param params
   * @return
   */
  @PostMapping(value =  GatewayPath.API_PM +"/user/withdraw",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ResponseEntity withdraw(@RequestBody Map<String, String> params);
}
