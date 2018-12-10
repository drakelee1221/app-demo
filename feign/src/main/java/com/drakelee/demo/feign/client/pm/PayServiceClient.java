package com.drakelee.demo.feign.client.pm;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

/**
 * PayServiceClient
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-28 11:05
 */
@FeignClient(value = "${module-pm}")
public interface PayServiceClient {

  @GetMapping(path = GatewayPath.API_PM+"/pay/info", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ObjectNode getPayInfo(@RequestParam Map<String,Object> params);

  /**
   * 余额支付
   * @param params
   * <p>  orderNo                      - Notnull   - Str - 订单编号
   * @return
   */
  @PutMapping(path = GatewayPath.API_PM+"/product/pay/balance", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ObjectNode payBalance(@RequestBody Map<String,Object> params);

  /**
   * 组合支付
   * @param params
   * <p>  orderNo                      - Notnull   - Str - 订单编号
   * @return
   */
  @GetMapping(path = GatewayPath.API_PM+"/product/pay/link", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  String payCombo(@RequestParam Map<String,Object> params);

  @GetMapping(value = GatewayPath.API_PM+"/wechat/share/config",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ObjectNode getShareConfig(@RequestParam Map<String,String> params);
}
