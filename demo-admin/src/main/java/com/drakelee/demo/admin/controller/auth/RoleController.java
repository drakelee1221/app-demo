

package com.drakelee.demo.admin.controller.auth;

import com.google.common.collect.Sets;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.auth.SysRoleService;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.auth.SysRoleService;
import com.drakelee.demo.common.constants.admin.AuthCode;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.admin.SysRole;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.Logs;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.util.Map;

/**
 * RoleController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-03 11:03
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class RoleController {
  @Autowired
  private SysRoleService sysRoleService;

  @GetMapping(value = {"/role/index"})
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    modelMap.put("authCode", AuthCode.getCodes());
    try {
      modelMap.put("authCodeStr", JsonUtils.toString(AuthCode.getCodes()));
    } catch (Exception e) {
      Logs.get().error("", e);
    }
    return "role/index";
  }

  @PostMapping(value = {"/role/saveOrUpdate"})
  @ResponseBody
  public ResponseEntity roleSaveOrUpdate(HttpServletRequest request, HttpServletResponse response,
                                               @RequestParam Map<String, String> param) {
    ConvertUtil.checkNotNull(param, "name", String.class);
    ConvertUtil.checkNotNull(param, "orderNo", Integer.class);
    return ResponseEntity
      .ok(JsonResult.success(sysRoleService.saveAndFlush(ConvertUtil.populate(new SysRole(), param))));
  }

  @PostMapping(value = {"/role/changeStatus"})
  @ResponseBody
  public ResponseEntity roleChangeStatus(HttpServletRequest request, HttpServletResponse response,
                                               @RequestParam Map<String, String> param) {
    sysRoleService.changeStatus(ConvertUtil.checkNotNull(param, "id", String.class),
                                ConvertUtil.checkNotNull(param, "status", Integer.class)
    );
    return ResponseEntity.ok(JsonResult.success());
  }

  @GetMapping(value = {"/role/page"})
  @ResponseBody
  public ResponseEntity rolePage(HttpServletRequest request, HttpServletResponse response) {
    return ResponseEntity.ok(DataPage.from(sysRoleService.findAll(
      Pages.Helper.pageable(request, new Sort(Sort.Direction.DESC, "orderNo", "id")))));
  }


  @GetMapping(value = {"/role/appInfo/tree"})
  @ResponseBody
  public ResponseEntity appInfoJoinTree(HttpServletRequest request, HttpServletResponse response) {
    String ids = request.getParameter("roleIds");
    String[] split = StringUtils.split(ids, ",");
    return ResponseEntity.ok(sysRoleService.loadRoleCheckedAppInfoTree(split == null ? null : Sets.newHashSet(split)));
  }

  @PostMapping(value = {"/role/appInfo/select"})
  @ResponseBody
  public ResponseEntity joinAppInfoSelect(HttpServletRequest request, HttpServletResponse response,
                                          @RequestParam Map<String, String> param) {
    String roleId = ConvertUtil.checkNotNull(param, "roleId", String.class);
    String appInfoIds = ConvertUtil.checkNotNull(param, "appInfoIds", String.class);
    String[] ids = StringUtils.split(appInfoIds, ",");
    sysRoleService.addAppInfoJoin(roleId, ids == null ? null : Sets.newHashSet(ids));
    return ResponseEntity.ok(JsonResult.success());
  }

  @GetMapping(value = {"/role/member/tree"})
  @ResponseBody
  public ResponseEntity memberJoinTree(HttpServletRequest request, HttpServletResponse response) {
    String ids = request.getParameter("roleIds");
    String[] split = StringUtils.split(ids, ",");
    return ResponseEntity.ok(sysRoleService.loadRoleCheckedMemberTree(split == null ? null : Sets.newHashSet(split)));
  }

  @PostMapping(value = {"/role/member/select"})
  @ResponseBody
  public ResponseEntity joinMemberSelect(HttpServletRequest request, HttpServletResponse response,
                                          @RequestParam Map<String, String> param) {
    String roleId = ConvertUtil.checkNotNull(param, "roleId", String.class);
    String memberIds = ConvertUtil.checkNotNull(param, "memberIds", String.class);
    String[] ids = StringUtils.split(memberIds, ",");
    sysRoleService.addMemberJoin(roleId, ids == null ? null : Sets.newHashSet(ids));
    return ResponseEntity.ok(JsonResult.success());
  }

  @GetMapping(value = {"/role/member"})
  @ResponseBody
  public ResponseEntity memberRoles(HttpServletRequest request, HttpServletResponse response,
                                    @RequestParam Map<String, String> param) {
    String id = ConvertUtil.checkNotNull(param, "memberId", String.class);
    return ResponseEntity.ok(sysRoleService.findRoleByMemberId(id));
  }

  @GetMapping(value = {"/role/member/auth/tree"})
  @ResponseBody
  public ResponseEntity memberAuthTree(HttpServletRequest request, HttpServletResponse response,
                                       @RequestParam Map<String, String> param) {
    String id = ConvertUtil.checkNotNull(param, "memberId", String.class);
    return ResponseEntity.ok(sysRoleService.findAuthAppInfoByMemberId(id));
  }
}
