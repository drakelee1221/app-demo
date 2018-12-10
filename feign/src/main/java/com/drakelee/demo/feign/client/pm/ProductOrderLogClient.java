package com.drakelee.demo.feign.client.pm;

import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

/**
 * ProductOrderLogClient
 *
 * @author <a href="929592332@qq.com">wangXin</a>
 * @version v1.0.0
 * @date 2018-11-15 15:02
 */
@FeignClient(value = "${module-pm}")
public interface ProductOrderLogClient {
  /**
   * 新增订单日志
   *
   * @param params
   * <p>  orderId      - Notnull  - Str     - 订单id
   * <p>  beforeStatus - Nullable - Integer - 订单改变之前状态
   * <p>  afterStatus  - Notnull  - Integer - 订单改变之后状态
   * <p>  remark       - Nullable - Str     - 备注
   * <p>  logName      - Notnull  - Str     - 日志名称，来源于OrderLogName枚举
   * <p>  attachment   - Nullable - Str     - 附件路径
   * <p>  userId   - Notnull - Str     - 操作人ID
   *
   * @return
   */
  @PostMapping(value = GatewayPath.API_INTERNALS
    + "/product/order/log", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ResponseEntity<Void> addProductOrderLog(@RequestBody Map<String, Object> params);
}
