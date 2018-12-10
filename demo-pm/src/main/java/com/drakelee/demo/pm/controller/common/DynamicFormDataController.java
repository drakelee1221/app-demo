package com.drakelee.demo.pm.controller.common;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.admin.DynamicFormData;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.pm.service.common.DynamicFormDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.Map;

/**
 * DynamicFormData Controller
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-15
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
public class DynamicFormDataController {

  @Autowired
  private DynamicFormDataService dynamicFormDataService;


  /**
   * 新增
   *
   * @param params -
   *
   * @return dynamicFormData
   */
  @PostMapping(value = "/dynamicFormData/pub", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity save(@RequestBody Map<String, String> params) {
    ObjectNode jsonData = JsonUtils.mapper.createObjectNode();
    try {
      jsonData = JsonUtils
        .reader(ConvertUtil.checkNotNull(params, "jsonData", String.class), ObjectNode.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("json数据异常");
    }
    dynamicFormDataService.save(params, jsonData);
    return new ResponseEntity<>(HttpStatus.CREATED);
  }

  /**
   * 修改
   *
   * @param params -
   *
   * @return dynamicFormData
   */
  @PutMapping(value = "/dynamicFormData", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity update(@RequestBody Map<String, String> params) {
    DynamicFormData dynamicFormData = ConvertUtil.populate(dynamicFormDataService.findById(params.get("id")), params);
    return new ResponseEntity<>(dynamicFormDataService.saveOrUpdate(dynamicFormData), HttpStatus.ACCEPTED);
  }

}
