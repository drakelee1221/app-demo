package com.drakelee.demo.admin.controller.attachment;

import com.base.components.common.util.ServletContextHolder;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.attachment.AttachmentService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 后台附件
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/4/4 0004 10:38
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class AttachmentController {

  @Autowired
  private AttachmentService attachmentService;
  /**
   * 临时上传附件返回临时地址
   *
   * @param file - file文件流
   *
   * @return
   */
  @PostMapping(value = "/attachment/uploadAtta")
  @ResponseBody
  public ResponseEntity uploadAtta(@RequestParam MultipartFile file, @RequestParam Map<String, String> params) {
    JsonResult res;
    try {
      ObjectNode objectNode = attachmentService.uploadAtta(file, StringUtils.isBlank(params.get("isPrivate")) ? false : Boolean.valueOf(params.get("isPrivate")));
      res = JsonResult.success(objectNode);
    } catch (Exception e) {
      e.printStackTrace();
      res = JsonResult.fail(e.getMessage());
    }
    return new ResponseEntity<>(res, HttpStatus.OK);
  }
  @PostMapping(value = "/attachment/upload/no/token")
  @ResponseBody
  public ResponseEntity uploadAttaNoToken(@RequestParam MultipartFile file, @RequestParam Map<String, String> params, HttpServletRequest request) {
    JsonResult res;
    try {
      String contactPhone = request.getParameter("contactPhone");
      // 2018-12-05修改为不验证短信
//      Assert.hasText(contactPhone,"联系电话不能为空");
//      tokenValidate.validate(contactPhone,request.getCookies());
      ObjectNode objectNode = attachmentService.uploadAtta(file, StringUtils.isBlank(params.get("isPrivate")) ? false : Boolean.valueOf(params.get("isPrivate")));
      res = JsonResult.success(objectNode);
    } catch (Exception e) {
      e.printStackTrace();
      res = JsonResult.fail(e.getMessage());
    }
    return new ResponseEntity<>(res, HttpStatus.OK);
  }
  @GetMapping(value = "/attachment/redirect")
  public String redirect(@RequestParam Map<String, String> params){
    String s = attachmentService.redirectInternals(params);
    return ServletContextHolder.sendRedirectString("redirect:" + s);
  }
}
