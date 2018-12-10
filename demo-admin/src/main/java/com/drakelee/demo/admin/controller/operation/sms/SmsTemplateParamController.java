package com.drakelee.demo.admin.controller.operation.sms;

import com.drakelee.demo.admin.service.operation.sms.SmsTemplateParamService;
import com.drakelee.demo.admin.service.operation.sms.SmsTemplateParamService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.sys.SmsTemplateParam;
import com.base.components.common.dto.page.DataPage;
import com.base.components.database.dao.base.condition.ConditionGroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * SmsTemplateUsuallyParam Controller
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-22
 */
@RestController
@RequestMapping(GatewayPath.ADMIN)
public class SmsTemplateParamController {

  @Autowired
  private SmsTemplateParamService smsTemplateParamService;

  /**
   * 分页
   * @param params -
   * <p> pageNum        - Nullable   - Int - 当前页
   * <p> pageSize       - Nullable   - Int - 每页记录数
   * 
   * @return DataPage
   */
  @GetMapping(value = "/smsTemplate/param/page")
  public ResponseEntity page(@RequestParam Map<String, String> params) {
    ConditionGroup<SmsTemplateParam> conditionGroup = ConditionGroup.build();
    // 条件: e.g. conditionGroup.addCondition("id", ConditionEnum.OPERATE_EQUAL,params.get("id"))
    return new ResponseEntity<>(DataPage.from(smsTemplateParamService.findAll(
      Pages.Helper.pageable(params, new Sort(Sort.Direction.ASC, "id")))), HttpStatus.OK);
  }


}
