package com.drakelee.demo.admin.controller.operation.sms;

import com.base.components.common.constants.Valid;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.operation.sms.SmsSendRecordService;
import com.drakelee.demo.admin.service.operation.sms.SmsTemplateService;
import com.drakelee.demo.admin.service.operation.sms.SysSmsService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.sys.Sms;
import com.drakelee.demo.common.domain.sys.SmsSendRecord;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * SmsController
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-03 14:26
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
@RefreshScope
@ConfigurationProperties(prefix = "base.admin")
public class SmsController {
  @Autowired
  private SysSmsService sysSmsService;
  @Autowired
  private SmsTemplateService templateService;
  @Autowired
  private SmsSendRecordService recordService;
  @GetMapping("/operation/sms/index")
  public String rechargeIndex(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "operation/sms/index";
  }

  /**
   * 短信分页查询
   * @param params
   * <p>  startDate                      - Notnull   - Str - desc
   * <p>  endDate                      - Notnull   - Str - desc
   * <p>  keywords                      - Notnull   - Str - desc
   * <p>  status                      - Notnull   - Str - desc
   * @return
   */
  @GetMapping("/operation/sms/pages")
  public ResponseEntity querySysSms(@RequestParam Map<String,String> params) {
    DataPage page = sysSmsService.querySysSms(params);
    return new ResponseEntity<>(page, HttpStatus.OK);
  }

  /**
   *保存短信
   * @param params
   * <p>  content                      - Notnull   - Str - 短信参数json字符串
   * <p>  addressee                    - Notnull   - Str - 接收手机号码
   * <p>  remarks                      - Notnull   - Str - 备注
   * <p>  templateId                   - Notnull   - Str - 模板id
   * @return
   */
  @PostMapping(value = "/operation/sms",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity saveSysSms(@RequestParam Map<String,String> params) throws IOException {
    String userId = "";
    String id = sysSmsService.saveFilterSms(userId, params);
    return new ResponseEntity<>(JsonResult.success(id), HttpStatus.OK);
  }

  /**
   * 发送短信
   * @param id
   * @return
   * @throws Exception
   */
  @PostMapping("/operation/sms/send")
  public ResponseEntity sendSms(@RequestParam("id") String id) throws Exception {
    sysSmsService.sendSms(id);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.OK);
  }

  /**
   * 查询开启的短信模板
   * @return
   */
  @GetMapping("/operation/sms/template")
  public ResponseEntity getTemplate() {
    List<Map<String, Object>> templates = templateService.queryOpenSmsTemplate();

    return new ResponseEntity<>(templates, HttpStatus.OK);
  }
  /**
   * 获取邮件
   * @param id
   * @return
   */
  @GetMapping("/operation/sms/{id}")
  public ResponseEntity getMail(@PathVariable("id") String id) {
    Sms sms = sysSmsService.findById(id);
    Assert.notNull(sms, "未获取到数据");
    ObjectNode smsObj = JsonUtils.convert(sms, ObjectNode.class);
    if(sms.getSmsSendMode().equals(Valid.TRUE.getVal())){
      //获取记录
      ConditionGroup<SmsSendRecord> build = ConditionGroup.build()
        .addCondition("smsId", ConditionEnum.OPERATE_EQUAL,id);
      List<SmsSendRecord> records = recordService.findAll(build);
      List<String> phones = records.stream().map(SmsSendRecord::getPhone).collect(Collectors.toList());
      String join = StringUtils.join(phones, "\n");
      smsObj.put("phones",join);
    }

    return new ResponseEntity<>(smsObj, HttpStatus.OK);
  }
  @GetMapping("/operation/sms/users")
  public ResponseEntity querySmsUser(@RequestParam Map<String,String> params) {
    DataPage dp =  sysSmsService.querySmsUser(params);
    return new ResponseEntity<>(dp, HttpStatus.OK);
  }
  @DeleteMapping(value = "/operation/sms",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity deleteSms(@RequestParam Map<String,String> params) {
    String smsId = ConvertUtil.checkNotNull(params, "smsId", "短信id为空", String.class);
    sysSmsService.deleteSms(smsId);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.OK);
  }
}
