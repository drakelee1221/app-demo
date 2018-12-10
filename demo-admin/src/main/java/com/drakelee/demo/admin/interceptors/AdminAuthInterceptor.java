

package com.drakelee.demo.admin.interceptors;

import com.base.components.common.boot.SpringBootApplicationRunner;
import com.base.components.common.exception.auth.AuthException;
import com.base.components.common.exception.other.ForbiddenException;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.ServletContextHolder;
import com.fasterxml.jackson.core.type.TypeReference;
import com.google.common.collect.Sets;
import com.drakelee.demo.admin.dto.member.AdminAuth;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.drakelee.demo.common.dto.admin.SysAppInfoDto;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.Set;

/**
 * 接收由网关层传输过来的token对象
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-12 14:03
 */
@Component
@ConfigurationProperties("base.admin.login-permission-path")
@RefreshScope
public class AdminAuthInterceptor implements HandlerInterceptor {
  /** 已授权并传参的应用程序请求标记 */
  private static final String PASS_AUTH_APP_FORWARD = "011fcb32-7201-4f06-9dc6-e719fd971654";
  private static final String PASS_AUTH_APP_FORWARD_KEY = "PASS_AUTH_APP_FORWARD";
  private static final String APP_NAME_KEY = "_APP_NAME_";
  private static final String CONTROLLER_PACKAGE_NAME = "controller";
  /** 只需登录的全匹配 uri */
  private Set<String> equalsPath = Sets.newHashSet();
  /** 只需登录的前匹配 uri */
  private Set<String> startWithPath = Sets.newHashSet();
  private Set<String> indexPath = Sets.newHashSet("/admin", "/admin/");

  @Value("${base.admin.login-path}")
  private String loginPath;
  @Autowired
  private SysMemberService sysMemberService;

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    String uri = request.getRequestURI();
    if (PASS_AUTH_APP_FORWARD.equals(request.getAttribute(PASS_AUTH_APP_FORWARD_KEY))) {
      //让已授权并传参的应用通过
      return true;
    }
    AdminAuth adminAuth = sysMemberService.getCurrentAdminAuth();
    if (adminAuth != null) {
      if (adminAuth.getSuperRole()) {
        return true;
      }
      for (String s : getEqualsPath()) {
        if(s.equals(uri)){
          return true;
        }
      }
      for (String s : getStartWithPath()) {
        if(uri.startsWith(s)){
          return true;
        }
      }
      SysAppInfoDto checked = adminAuth.checkAuthPath(uri, request.getMethod());
      if (checked != null) {
        request.setAttribute(PASS_AUTH_APP_FORWARD_KEY, PASS_AUTH_APP_FORWARD);
        request.setAttribute(APP_NAME_KEY, checked.getName());
//        String params = getParams(checked.getParamsJson());
//        if (params != null) {
//          request.getRequestDispatcher(uri + "?aaa=1" ).forward(request, response);
//          return false;
//        }
        return true;
      }
      else{
        return returnForbidden(handler, request, response);
      }
    } else {
      return returnUnauthorized(handler, request, response);
    }
  }

  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                         ModelAndView modelAndView) throws Exception {
  }

  @Override
  public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
    throws Exception {
    sysMemberService.cleanCurrentAdminAuth();
  }

  private String getParams(String paramJson) {
    if (StringUtils.isNotBlank(paramJson)
      && !"{}".equals(paramJson) && paramJson.startsWith("{") && paramJson.endsWith("}")) {
      try {
        Map<String, Object> params = JsonUtils.reader(paramJson, new TypeReference<Map<String, Object>>() {
        });
        if (!params.isEmpty()) {
          StringBuilder sb = new StringBuilder();
          for (Map.Entry<String, Object> param : params.entrySet()) {
            sb.append("&").append(param.getKey()).append("=").append(param.getValue());
          }
          return sb.toString();
        }
      } catch (Exception ignored) {
      }
    }
    return null;
  }

  private boolean returnUnauthorized(Object handler, HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    String uri = request.getRequestURI();
    if(indexPath.contains(uri)){
      ServletContextHolder.sendRedirect(loginPath);
      return false;
    }
    if(isCustomPackage(handler)){
      throw new AuthException();
    }else{
      response.setStatus(HttpStatus.UNAUTHORIZED.value());
      request.getRequestDispatcher("/admin/error/401").forward(request, response);
      return false;
    }
  }

  private boolean returnForbidden(Object handler, HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    if(isCustomPackage(handler)){
      sysMemberService.cleanCurrentAdminAuth();
      throw new ForbiddenException();
    }
    return true;
  }

  private boolean isCustomPackage(Object handler){
    String name = handler.toString();
    return name.contains(CONTROLLER_PACKAGE_NAME) && name.contains(SpringBootApplicationRunner.getProjectPackagePrefix());
  }

  public Set<String> getStartWithPath() {
    return startWithPath;
  }

  public void setStartWithPath(Set<String> startWithPath) {
    this.startWithPath = startWithPath;
  }

  public Set<String> getEqualsPath() {
    return equalsPath;
  }

  public void setEqualsPath(Set<String> equalsPath) {
    this.equalsPath = equalsPath;
  }
}
