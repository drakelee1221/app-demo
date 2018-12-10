

package com.drakelee.demo.admin.controller.es;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.es.ElasticSearchInfoService;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.es.ElasticSearchInfoService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * ElasticSearchInfoController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-01-04 12:00
 */
@Controller
@RequestMapping(GatewayPath.ADMIN + "/es")
public class ElasticSearchInfoController {

  @Autowired(required = false)
  private ElasticSearchInfoService elasticSearchInfoService;

  @Value("${spring.data.elasticsearch.properties.master-http-address:}")
  private String esMasterHttpAddress;

  @Value("${spring.data.elasticsearch.properties.transport-addresses:}")
  private String esTransportAddress;

  @GetMapping(value = {"/", "/index"})
  public String index(ModelMap model) {
    model.put("esMasterHttpAddress", esMasterHttpAddress);
    model.put("esTransportAddress", esTransportAddress);
    model.put("esEnabled", elasticSearchInfoService != null);
    return "es/index";
  }


  @GetMapping(value = {"/list"})
  @ResponseBody
  public ResponseEntity<DataPage> list(@RequestParam Map<String, String> params) {
    if(elasticSearchInfoService == null){
      return new ResponseEntity<>(DataPage.getEmpty(), HttpStatus.OK);
    }
    List<ObjectNode> array = elasticSearchInfoService.infoList();
    DataPage<ObjectNode> page = new DataPage<>();
    page.setList(array);
    page.setTotal(array.size());
    return new ResponseEntity<>(page, HttpStatus.OK);
  }

  @GetMapping(value = {"/fields/{indexName}"})
  @ResponseBody
  public ResponseEntity listWithIndexName(@PathVariable("indexName") String indexName) {
    List<ObjectNode> array = elasticSearchInfoService.getFields(indexName);
    return new ResponseEntity<>(array, HttpStatus.OK);
  }

  @GetMapping(value = {"/query/{indexName}"})
  @ResponseBody
  public ResponseEntity listWithIndexName(@PathVariable("indexName") String indexName,
                                          @RequestParam Map<String, String> params) {
    Page<?> page = elasticSearchInfoService
      .fullTextSearch(indexName, params.get("query"), " ", Pages.Helper.pageable(params, null));
    return new ResponseEntity<>(DataPage.from(page), HttpStatus.OK);
  }

  @PostMapping(value = {"/rebuild/{indexName}/{type}"})
  @ResponseBody
  public ResponseEntity rebuild(@PathVariable("indexName") String indexName, @PathVariable("type") String type) {
    String msg = "重构总数：";
    long count = elasticSearchInfoService.rebuild(indexName, type);
    return new ResponseEntity<>(JsonResult.success(msg + count), HttpStatus.OK);
  }



}
