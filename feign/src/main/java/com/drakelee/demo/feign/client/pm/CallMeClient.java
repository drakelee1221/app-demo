package com.drakelee.demo.feign.client.pm;

import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

/**
 * CallMeClient
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/8/7 0007 17:01
 */
@FeignClient(value = "${module-pm}")
public interface CallMeClient {

  /**
   * 新增callme
   * @param params
   * @return
   *
   * @throws Exception
   */
  @PostMapping(value = GatewayPath.API_INTERNALS + "/callme-mj", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  String addCallMe(@RequestBody Map<String, String> params);

}
