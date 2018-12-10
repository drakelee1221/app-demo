package com.drakelee.demo.pm.controller.sys;

import com.drakelee.demo.pm.service.sys.VariableDataService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.pm.service.sys.VariableDataService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/5/21 0021 11:55
 */
@RestController
public class VariableDataController {

  @Autowired
  private VariableDataService variableDataService;

  @GetMapping(path = GatewayPath.API_PM + "/sys/variabledata", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity listData(@RequestParam(required = false) Map<String, String> params) {
    ConditionGroup build = ConditionGroup.build();
    if(StringUtils.isNotBlank(params.get("type"))){
      build.addCondition("type", ConditionEnum.OPERATE_EQUAL, Integer.parseInt(params.get("type")));
    }
    if(StringUtils.isNotBlank(params.get("refId"))){
      build.addCondition("refId", ConditionEnum.OPERATE_EQUAL, params.get("refId"));
    }
    List list = variableDataService.findAll(build, Sort.by(Sort.Direction.DESC, "orderNo"));
    return ResponseEntity.ok(list);
  }
}
