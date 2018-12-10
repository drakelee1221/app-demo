package com.drakelee.demo.admin.controller.user.manager;

import com.base.components.common.constants.sys.Dates;
import com.base.components.common.token.RequireToken;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ObjectSetPropsUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.AdminAuth;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.admin.service.attachment.AttachmentService;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.drakelee.demo.admin.service.region.RegionService;
import com.drakelee.demo.admin.service.user.UserBaseInfoService;
import com.drakelee.demo.admin.service.user.UserCompanyInfoService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.admin.SysMember;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.common.domain.user.UserCompanyInfo;
import com.drakelee.demo.common.token.user.UserMemberToken;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * UserController
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/17 0017 10:20
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class UserBaseInfoController {


  @Autowired
  UserBaseInfoService userBaseInfoService;
  @Autowired
  UserCompanyInfoService userCompanyInfoService;
  @Autowired
  AttachmentService attachmentService;
  @Autowired
  RegionService regionService;
  @Autowired
  private SysMemberService sysMemberService;
  @Value("${base.admin.registry-user-search-days-limit:30}")
  private Integer registryUserSearchDaysLimit;

  /**
   * 跳转到用户管理页面
   *
   * @param request
   * @param response
   * @param modelMap
   *
   * @return
   */
  @GetMapping(value = {"/user/manager/index"})
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    modelMap.put("registTimeStart", DateTime.now().minusDays(registryUserSearchDaysLimit).withMillisOfDay(0)
                                            .toString(Dates.DATE_TIME_FORMATTER_PATTERN));
    modelMap.put("registTimeEnd",
                 DateTime.now().millisOfDay().withMaximumValue().toString(Dates.DATE_TIME_FORMATTER_PATTERN)
    );
    return "user/manager/index";
  }

  /**
   * 跳转到用户管理页面
   *
   * @param request
   * @param response
   * @param modelMap
   *
   * @return
   */
  @GetMapping(value = {"/user/manager/detail"})
  public String userDetail(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    String id = request.getParameter("id");
    modelMap.put("id", id);
    modelMap.put("user", userBaseInfoService.findById(id));
    return "user/manager/detail";
  }

  /**
   * 分页查询
   *
   * @param params
   *
   * @return
   */
  @GetMapping(value = {"/user/manager/listpage"})
  @ResponseBody
  public ResponseEntity listPage(@RequestParam Map<String, String> params) {
    return new ResponseEntity<>(userBaseInfoService.listPage(params), HttpStatus.OK);
  }


  /**
   * ajax返回用户基本详情页面
   *
   * @param userId
   * @param modelMap
   *
   * @return
   */
  @GetMapping(value = {"/user/manager/detail/base"})
  public String userDetail(String userId, ModelMap modelMap) {
    Assert.notNull(userId, "用户id不能为空");
    UserBaseInfo userBaseInfo = userBaseInfoService.findById(userId);
    userBaseInfo = ObjectSetPropsUtil
      .setOtherPropsNull(userBaseInfo, true, "avatar", "userNickName", "gender", "birth", "phone", "userEmail", "wxImg",
                         "wxName"
      );
    userBaseInfo.setAvatar(attachmentService.displayAtta(userBaseInfo.getAvatar()));
    UserCompanyInfo userCompanyInfo = userCompanyInfoService
      .findOne(ConditionGroup.build().addCondition("userId", ConditionEnum.OPERATE_EQUAL, userId));
    if (userCompanyInfo != null) {
      userCompanyInfo.setLogo(attachmentService.displayAtta(userCompanyInfo.getLogo()));
    }
    modelMap.put("userBaseInfo", userBaseInfo);
    modelMap.put("userCompanyInfo", userCompanyInfo);
    return "/user/manager/baseinfo";
  }

  /**
   * ajax返回用户服务页面
   *
   * @return
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping(value = {"/user/manager/detail/service"})
  public String serviceDetail() {
    return "user/manager/serviceDetail";
  }



  /**
   * ajax返回用户基本详情页面
   *
   * @return
   */
  @GetMapping(value = {"/user/manager/detail/order"})
  public String order(String userId, ModelMap modelMap) {
    Assert.notNull(userId, "用户id不能为空");
    modelMap.put("userId", userId);
    return "user/manager/order";
  }


  @GetMapping(value = {"/user/region/tree"})
  @ResponseBody
  public ResponseEntity tree(HttpServletRequest request, HttpServletResponse response) {
    List<TreeNodeData<Region>> treeNodeData = regionService
      .loadTreeNodes(new TreeParam(request), RegionService.CountType.NORMAL_USER);
    return ResponseEntity.ok(treeNodeData);
  }


  @RequireToken(UserMemberToken.class)
  @GetMapping(value = "/user/auth/members",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  @ResponseBody
  public ResponseEntity queryOwnAuth(@RequestParam Map<String, String> params) {
    UserMemberToken tokenObj = TokenThreadLocal.getTokenObj(UserMemberToken.class);
    List<SysMember> members = sysMemberService.queryAuthMembersById(tokenObj.getId());
    return ResponseEntity.ok(JsonResult.success(members));
  }

  @RequireToken(UserMemberToken.class)
  @GetMapping(value = "/user/auth/members/regions",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  @ResponseBody
  public ResponseEntity queryOwnAuthMemberRegions(@RequestParam Map<String, String> params) {
    UserMemberToken tokenObj = TokenThreadLocal.getTokenObj(UserMemberToken.class);
    List<Region> members = sysMemberService.queryAuthMemberRegionsById(tokenObj.getId());

    return ResponseEntity.ok(JsonResult.success(members));
  }

  /**
   * 获取当前用户权限对象
   * @return
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping(value = "/user/auth/info",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  @ResponseBody
  public ResponseEntity queryCurrentAuthInfo() {
    AdminAuth auth = sysMemberService.getCurrentAdminAuth();
    return ResponseEntity.ok(JsonResult.success(auth));
  }
}
