package com.drakelee.demo.feign.client.pm;

import com.fasterxml.jackson.databind.node.ObjectNode;
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
public interface UserClient {

  /**
   * 用户登录
   *
   * @param params -
   * <p> phone              - Notnull   - Str - 手机号
   * <p> pwd                - Nullable  - Str - 登录密码，与verifyCode不能都为空
   * <p> verifyCode         - Nullable  - Str - 短信验证码，与pwd不能都为空，见 /edge/sms/code
   * <p> selectRegionId     - Nullable - Str -  选择的地区ID
   *
   * @return UserToken
   */
  @PostMapping(value = GatewayPath.API_PM + "/user/login", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ResponseEntity<ObjectNode> userLogin(@RequestBody Map<String, String> params);

}
