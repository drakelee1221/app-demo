

package com.drakelee.demo.admin.controller.message;

import com.drakelee.demo.admin.service.message.SysMessageService;
import com.drakelee.demo.admin.service.user.BaseUserTypeService;
import com.drakelee.demo.admin.service.message.SysMessageService;
import com.drakelee.demo.admin.service.user.BaseUserTypeService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * SysMessageController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-19 16:21
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class SysMessageController {
  @Autowired
  private SysMessageService sysMessageService;
  @Autowired
  private BaseUserTypeService baseUserTypeService;
  @GetMapping(value = "/message/index")
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    modelMap.put("userTypes", baseUserTypeService.findAllExceptBaseUser());
    return "message/index";
  }

  @GetMapping("/message/page")
  @ResponseBody
  public ResponseEntity page(@RequestParam Map<String, String> param, HttpServletRequest request, HttpServletResponse response) {
    return ResponseEntity.ok(sysMessageService.findDetailPage(param));
  }
}
