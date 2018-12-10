

package com.drakelee.demo.admin.controller.common;

import com.base.components.common.token.RequireToken;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.ServletContextHolder;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.member.AdminAuth;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.drakelee.demo.admin.service.message.SysMessageService;
import com.drakelee.demo.admin.service.user.UserBaseInfoService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.token.user.UserMemberToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Home Controller
 *
 * @author <a href="yijianhua@xianyunsoft.com">Yi Jianhua</a>
 * @version 1.0.0, 2017-11-27 16:48
 */
@Controller
public class HomeController {
  @Autowired
  private SysMemberService sysMemberService;
  @Autowired
  private UserBaseInfoService userBaseInfoService;
  @Autowired
  private SysMessageService sysMessageService;

  @GetMapping({"", "/", GatewayPath.ADMIN, GatewayPath.ADMIN +"/"})
  public String index(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    if(TokenThreadLocal.getTokenObj() == null){
      return ServletContextHolder.sendRedirectString("redirect:" + GatewayPath.ADMIN + "/login");
    }
    return ServletContextHolder.sendRedirectString("redirect:" + GatewayPath.ADMIN + "/index");
  }

  /**
   * 首页
   *
   * @return
   */
  @GetMapping(GatewayPath.ADMIN + "/index")
  public String indexPage(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    UserMemberToken memberToken = TokenThreadLocal.getTokenObjNonNull(UserMemberToken.class);
    modelMap.put("memberToken", memberToken);
    AdminAuth currentAdminAuth = sysMemberService.getCurrentAdminAuth();
    modelMap.put("adminAuth", currentAdminAuth);
    return "common/index";
  }

  @GetMapping(value = GatewayPath.ADMIN + "/home")
  public String home(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "common/home";
  }
  @GetMapping(value = GatewayPath.ADMIN + "/information")
  public String information(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    UserMemberToken memberToken = TokenThreadLocal.getTokenObjNonNull(UserMemberToken.class);
    modelMap.put("memberToken", memberToken);
    return "common/information";
  }

  @PostMapping(value = GatewayPath.ADMIN + "/information/update")
  @ResponseBody
  public ResponseEntity informationUpdate(HttpServletRequest request, HttpServletResponse response,
                                          @RequestParam Map<String, String> param) {
    return ResponseEntity.ok(JsonResult.success(sysMemberService.updateBaseInfoAndTokenObj(param)));
  }

  /**
   * 用户注册量查询
   * @return
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping(value = GatewayPath.ADMIN + "/home/chart/register")
  public ResponseEntity queryRegister(@RequestParam Map<String, String> params) {
    Map<String,Object> result = userBaseInfoService.queryRegister(params.get("endTime"), null);
    Map<String, Object> year = userBaseInfoService.queryRegister(params.get("endTime"), "year");
    Map<String, Object> month = userBaseInfoService.queryRegister(params.get("endTime"), "month");
    result.put("yearXAxis", year.get("xAxis"));
    result.put("yearYAxis", year.get("yAxis"));
    result.put("monthXAxis", month.get("xAxis"));
    result.put("monthYAxis", month.get("yAxis"));
    return new ResponseEntity(JsonResult.success(result),HttpStatus.OK);
  }

  @RequireToken(UserMemberToken.class)
  @GetMapping(value = GatewayPath.ADMIN + "/home/chart/data")
  public ResponseEntity queryHomeData(@RequestParam Map<String,String> params) {

    Map<String,Object> resultMap = new HashMap<>();
    resultMap.put("users",BigDecimal.ZERO);
    resultMap.put("orderAmount",BigDecimal.ZERO);
    resultMap.put("todayAmount",BigDecimal.ZERO);
    resultMap.put("todayOrders",BigDecimal.ZERO);
    resultMap.put("companies",BigDecimal.ZERO);
    resultMap.put("todayRecharge", BigDecimal.ZERO );
    return new ResponseEntity<>(JsonResult.success(resultMap),HttpStatus.OK);
  }

  @RequireToken(UserMemberToken.class)
  @GetMapping(value = GatewayPath.ADMIN + "/home/chart/operationdata")
  public ResponseEntity queryHomeOperationData(@RequestParam Map<String, String> params) {

    long notice = sysMessageService.countUnReadMessage();
    Map<String, Object> resultMap = new HashMap<>();
    resultMap.put("callme", 0);
    resultMap.put("supply", 0);
    resultMap.put("complains", BigDecimal.ZERO);
    resultMap.put("consults", BigDecimal.ZERO);
    resultMap.put("notice", notice);
    resultMap.put("demand", 0);
    resultMap.put("unorder", 0);
    return new ResponseEntity<>(JsonResult.success(resultMap), HttpStatus.OK);
  }

  @RequireToken(UserMemberToken.class)
  @GetMapping(value = GatewayPath.ADMIN + "/home/chart/logindata")
  public ResponseEntity queryHomeLoginData(@RequestParam Map<String,String> params) {

    List<Map> manager = userBaseInfoService.countUnLogin(false);
    List<Map> user = userBaseInfoService.countUnLogin(true);
    Map<String, Map> managerMap = ConvertUtil.transformMap(manager, val -> val.get("days").toString());
    Map<String, Map> userMap = ConvertUtil.transformMap(user, val -> val.get("days").toString());
    Map<String,Object> resultMap = new HashMap<>();
    resultMap.put("sevenDaysManager", managerMap.get("seven") == null ? 0 : managerMap.get("seven").get("count"));
    resultMap.put("fifteenDaysManager", managerMap.get("fifteen") == null ? 0 : managerMap.get("fifteen").get("count"));
    resultMap.put("thirtyDaysManager", managerMap.get("thirty") == null ? 0 : managerMap.get("thirty").get("count"));
    resultMap.put("sevenDaysUser", userMap.get("seven") == null ? 0 : userMap.get("seven").get("count"));
    resultMap.put("fifteenDaysUser", userMap.get("fifteen") == null? 0: userMap.get("fifteen").get("count"));
    resultMap.put("thirtyDaysUser", userMap.get("thirty") == null ? 0 : userMap.get("thirty").get("count"));
    return new ResponseEntity<>(JsonResult.success(resultMap),HttpStatus.OK);
  }
}
