package com.drakelee.demo.feign.client.pm;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

/**
 * ProductOrderClient
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-07-04 11:07
 */
@FeignClient(value = "${module-pm}")
public interface ProductOrderClient {
  /**
   * 服务续签
   * @param params
   * <p>  serviceId                      - Notnull   - Str - 服务id
   * <p>  duration                      - Notnull   - Str - 时长 年
   * <p>  items                         - Notnull   - Str - 选购数量
   * @return
   */
  @PutMapping(value = GatewayPath.API_PM+"/product/service/extension", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ObjectNode serviceExtension(@RequestBody Map<String,Object> params) throws Exception;
}
