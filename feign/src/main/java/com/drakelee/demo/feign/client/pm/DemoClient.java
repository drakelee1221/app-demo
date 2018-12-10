

package com.drakelee.demo.feign.client.pm;

import com.base.components.common.dto.page.DataPage;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

/**
 * DemoClient
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-01-17 14:08
 */
@FeignClient(value = "${module-pm}")
public interface DemoClient {

  @GetMapping(value = "/api/demo", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  DataPage getTest(@RequestParam Map<String, String> params);

  /**
   * save demo
   * @param paramMap -
   * @return Demo
   */
  @RequestMapping(path = "/api/demo", method = RequestMethod.POST,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ResponseEntity<com.drakelee.demo.common.domain.demo.Demo> save(@RequestBody Map<String, String> paramMap);

  /**
   * save demo
   * @param paramMap -
   * @return Demo
   */
  @RequestMapping(path = "/api/demo/2", method = RequestMethod.POST,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  com.drakelee.demo.common.domain.demo.Demo save2(@RequestBody Map<String, String> paramMap);
}
