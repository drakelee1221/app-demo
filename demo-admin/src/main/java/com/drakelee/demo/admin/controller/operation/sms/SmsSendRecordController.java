package com.drakelee.demo.admin.controller.operation.sms;

import com.drakelee.demo.admin.service.operation.sms.SmsSendRecordService;
import com.drakelee.demo.admin.service.operation.sms.SmsSendRecordService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * SmsSendRecord Controller
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-22
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class SmsSendRecordController {

  @Autowired
  private SmsSendRecordService smsSendRecordService;

  /**
   * 页面
   *
   * @param request
   * @param response
   * @param modelMap
   *
   * @return
   */
  @GetMapping({"/operation/sms/record/index"})
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    String smsId = request.getParameter("smsId");
    modelMap.put("smsId", smsId);
    return "operation/sms/record/index";
  }


  /**
   * 分页
   *
   * @param params -
   * <p> pageNum                     - Nullable   - Int - 当前页
   * <p> pageSize                    - Nullable   - Int - 每页记录数
   * <p> smsId                       - Nullable  - 短信id
   * <p> searchPhone                 - Nullable  - 电话
   * <p> searchUserName              - Nullable  - 用户名
   * <p> searchStatus                - Nullable  - 状态
   *
   * @return
   */
  @GetMapping(value = "/operation/sms/record/page")
  public ResponseEntity page(@RequestParam Map<String, String> params) {
    return new ResponseEntity<>(smsSendRecordService.pageRecord(params), HttpStatus.OK);
  }

  /**
   * 根据ID查询
   *
   * @param id -
   *
   * @return smsSendRecord
   */
  @GetMapping(value = "/operation/sms/record/{id}")
  public ResponseEntity findById(@PathVariable String id) {
    return new ResponseEntity<>(smsSendRecordService.findById(id), HttpStatus.OK);
  }


}
