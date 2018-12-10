package com.drakelee.demo.feign.client.pm;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

/**
 * SendMessageClient
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/13 0013 16:41
 */
@FeignClient(value = "${module-pm}")
public interface SendMessageClient {


  /**
   * @param params
   *
   * @return
   *
   * @throws Exception
   */
  @PostMapping(path = "/api/sys/sendSysTemplateMsg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  boolean sendSysTemplateMsg(@RequestBody Map<String, String> params);


  /**
   * @param params
   *
   * @return
   *
   * @throws Exception
   */
  @PostMapping(path = "/api/sys/sendSmsTemplateMsg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  boolean sendSmsTemplateMsg(@RequestBody Map<String, String> params);


  /**
   * @param params
   *
   * @return
   *
   * @throws Exception
   */
  @PostMapping(path = "/api/sys/sendWechatTemplateMsg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  boolean sendWechatTemplateMsg(@RequestBody Map<String, String> params);


}
