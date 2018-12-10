

package com.drakelee.demo.admin.controller.auth;

import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ErrorController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-08 15:08
 */
@Controller
@RequestMapping(GatewayPath.ADMIN + "/error")
public class ErrorController {
  @RequestMapping("/500")
  public String internalServerError(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "error/500";
  }
  @RequestMapping("/400")
  public String badRequest(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "error/400";
  }
  @RequestMapping("/401")
  public String unauthorized(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "error/401";
  }
  @RequestMapping("/403")
  public String forbidden(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "error/403";
  }
  @RequestMapping("/404")
  public String notFound(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "error/404";
  }
}
