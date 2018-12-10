

package com.drakelee.demo.admin.controller.common;

import com.base.components.common.util.IPUtils;
import com.base.components.common.util.ServletContextHolder;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.token.TokenType;
import com.drakelee.demo.common.token.user.UserMemberToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.invoke.MethodHandles;

/**
 * 登录/退出 Controller
 *
 * @author <a href="yijianhua@xianyunsoft.com">Yi Jianhua</a>
 * @version 1.0.0, 2017-11-27 16:48
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
@RefreshScope
public class LoginController {
  private static final Logger logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
  @Autowired
  private SysMemberService memberService;
  /**
   * 登录页
   *
   * @return
   */
  @GetMapping("/login")
  public String login() {
    return "common/login";
  }

  /**
   * 机构注册页
   *
   * @return
   */
  @GetMapping("/register/org")
  public String registerOrg() {
    return "common/org_register";
  }

  /**
   * 服务人员注册页
   *
   * @return
   */
  @GetMapping("/register/servicer")
  public String registerServicer() {
    return "common/servicer_register";
  }

  /**
   * 注册页
   *
   * @return
   *//*
  @GetMapping("/register")
  public String register() {
    return "common/register";
  }*/

  /**
   * 实现登录
   *
   * @param username
   * @param password
   * @param model
   *
   * @return
   */
  @PostMapping("/login")
  public String login(@RequestParam("username") String username, @RequestParam("password") String password,
                      ModelMap model, HttpServletRequest request, HttpServletResponse response) {
    try {
      UserMemberToken userMemberToken = memberService.login(username, password, IPUtils.getRealIp(request));
      Cookie cookie = new Cookie(TokenType.USER_MEMBER_TOKEN.getTokenKey(), userMemberToken.getToken());
      cookie.setPath(GatewayPath.ADMIN);
      response.addCookie(cookie);
      return ServletContextHolder.sendRedirectString("redirect:" + GatewayPath.ADMIN + "/index");
    } catch (Exception e) {
      logger.error("login", e);
      model.put("errorMsg", e.getMessage());
      return "common/login";
    }
  }

  /**
   * 退出登录
   *
   * @return
   */
  @GetMapping("/logout")
  public String logout(HttpServletRequest request, HttpServletResponse response) {
    String token = null;
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
      if(TokenType.USER_MEMBER_TOKEN.getTokenKey().equals(cookie.getName())){
        token = cookie.getValue();
        break;
      }
    }
    if(token != null){
      memberService.logout(token);
    }
    Cookie cookie = new Cookie(TokenType.USER_MEMBER_TOKEN.getTokenKey(), "");
    cookie.setMaxAge(0);
    cookie.setPath(GatewayPath.ADMIN);
    response.addCookie(cookie);
    return ServletContextHolder.sendRedirectString("redirect:" + GatewayPath.ADMIN + "/login");
  }
}
