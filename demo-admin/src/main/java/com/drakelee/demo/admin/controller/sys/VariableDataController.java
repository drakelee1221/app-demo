package com.drakelee.demo.admin.controller.sys;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.sys.VariableDataService;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.sys.VariableDataService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.token.RequireToken;
import com.drakelee.demo.common.token.user.UserMemberToken;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/5/21 0021 11:55
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class VariableDataController {

  @Autowired
  private VariableDataService variableDataService;

  @GetMapping(value = {"/sys/variable/index"})
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "sys/variable/index";
  }


  @RequireToken(UserMemberToken.class)
  @PostMapping("/sys/variable")
  @ResponseBody
  public ResponseEntity saveOrUpdata(@RequestParam Map<String, String> params) {
    ConvertUtil.checkNotNull(params, "type", String.class);
    ConvertUtil.checkNotNull(params, "refId", String.class);
    try {
      JsonUtils.reader(ConvertUtil.checkNotNull(params, "jsonData", String.class), ObjectNode.class);
    } catch (IOException e) {
      return ResponseEntity.ok(JsonResult.fail("内容数据格式错误！"));
    }
    variableDataService.addData(params);
    return ResponseEntity.ok(JsonResult.success());
  }

  @RequireToken(UserMemberToken.class)
  @GetMapping("/sys/variable")
  @ResponseBody
  public ResponseEntity listData(@RequestParam(required = false) Map<String, String> params) {
    Page page = variableDataService.findAll(Pages.Helper.pageable(params, Sort.by(Sort.Direction.ASC, "refId", "orderNo")));
    return ResponseEntity.ok(DataPage.from(page));
  }

  @PostMapping("/sys/variable/delete")
  public ResponseEntity delete(@RequestParam Map<String, String> params) {
    variableDataService.delete(ConvertUtil.checkNotNull(params, "id", String.class));
    return ResponseEntity.ok(JsonResult.success());
  }
}
