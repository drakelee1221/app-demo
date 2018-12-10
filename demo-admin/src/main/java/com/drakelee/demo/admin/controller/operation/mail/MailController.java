package com.drakelee.demo.admin.controller.operation.mail;

import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.operation.mail.MailService;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.operation.mail.MailService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.sys.Email;
import com.drakelee.demo.common.domain.sys.Mailbox;
import com.base.components.common.dto.page.DataPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * MailController
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-02 15:59
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class MailController {
  @Autowired
  private MailService mailService;

  @GetMapping("/operation/mail/index")
  public String rechargeIndex(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "operation/mail/index";
  }

  /**
   * 邮件分页查询
   * @param params
   * <p>  startDate                      - Notnull   - Str - desc
   * <p>  endDate                      - Notnull   - Str - desc
   * <p>  keywords                      - Notnull   - Str - desc
   * <p>  status                      - Notnull   - Str - desc
   * @return
   */
  @GetMapping("/operation/mail/pages")
  public ResponseEntity queryMails(@RequestParam Map<String,String> params) {
    DataPage page = mailService.queryMails(params);
    return new ResponseEntity<>(page, HttpStatus.OK);
  }

  /**
   *
   * @param params
   * @return
   */
  @PostMapping("/operation/mail")
  public ResponseEntity saveMail(@RequestParam Map<String,String> params) {
    //TokenThreadLocal.getTokenObjNonNull().objId().toString();
    String userId = "";
    mailService.saveMail(userId,params);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.OK);
  }

  /**
   * 获取邮件
   * @param id
   * @return
   */
  @GetMapping("/operation/mail/{id}")
  public ResponseEntity getMail(@PathVariable("id") String id) {
    String userId = "";
    Email email = mailService.findById(id);
    Assert.notNull(email,"未获取到数据");
    return new ResponseEntity<>(email, HttpStatus.OK);
  }

  @PostMapping("/operation/mail/server")
  public ResponseEntity saveMailServer(@RequestParam Map<String,String> params) {
    mailService.saveMailServer(params);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.OK);
  }

  @GetMapping("/operation/mail/server")
  public ResponseEntity getMailServer() {
    Mailbox email = mailService.getMailServer();
    return new ResponseEntity<>(email, HttpStatus.OK);
  }
  @PostMapping("/operation/mail/send")
  public ResponseEntity sendMail(@RequestParam("id") String id) throws Exception {
    mailService.sendMail(id);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.OK);
  }
}
