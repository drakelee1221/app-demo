

package com.drakelee.demo.admin.controller.ueditor;

import com.drakelee.demo.admin.controller.ueditor.base.ActionEnter;
import com.drakelee.demo.admin.controller.ueditor.base.ActionEnter;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ueditor , 模板文件中引入实例：<br/>
 * <pre>
      <#--UEditor begin -->
      <#-- ID，默认为ueditor_id，创建后会以此ID声明一个全局变量 -->
      <#assign ueditor_id="xxxxxxx"/>
      <#-- 设置高度，默认400 -->
      <#assign ueditor_height="400"/>
      <#include "/ueditor/include.ftl"/>
      <#--UEditor end -->
 * </pre>
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-12-19 12:55
 */
@Controller
public class UeditorFileManagerController {

  @RequestMapping(value = GatewayPath.ADMIN + "/ueditor/controller")
  @ResponseBody
  public String controller(HttpServletRequest request, HttpServletResponse response) {
    String rootPath = this.getClass().getResource("/").getPath();
    rootPath = rootPath.substring(0, rootPath.length()-1);
    return new ActionEnter(request, rootPath).exec();
  }
}
