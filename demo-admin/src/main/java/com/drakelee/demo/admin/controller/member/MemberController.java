

package com.drakelee.demo.admin.controller.member;

import com.base.components.common.util.ConvertUtil;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.admin.service.auth.SysRoleService;
import com.drakelee.demo.admin.service.member.MemberNodeBuilder;
import com.drakelee.demo.admin.service.member.SysMemberAttrService;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.admin.SysMember;
import com.drakelee.demo.database.dao.admin.SysMemberDao;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.util.List;
import java.util.Map;

/**
 * MemberController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-17 10:33
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class MemberController {
  @Autowired
  private SysMemberService sysMemberService;
  @Autowired
  private SysMemberAttrService sysMemberAttrService;
  @Autowired
  private SysRoleService sysRoleService;

  @GetMapping(value = {"/member/index"})
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "member/index";
  }

  @GetMapping(value = {"/member/tree"})
  @ResponseBody
  public ResponseEntity tree(HttpServletRequest request, HttpServletResponse response) {
    List<TreeNodeData<SysMember>> treeNodeData =
      sysMemberService.loadTreeNodes(new TreeParam(request), new MemberNodeBuilder(), SysMemberDao.ADMIN_TREE_KIND);
    return ResponseEntity.ok(treeNodeData);
  }

  @GetMapping(value = {"/member/attr/tree"})
  @ResponseBody
  public ResponseEntity selectedTree(HttpServletRequest request, HttpServletResponse response,
                                     @RequestParam Map<String, String> params) {
    return ResponseEntity.ok(
      sysMemberAttrService.loadMemberAttrTree(new TreeParam(request),
                                              ConvertUtil.checkNotNull(params, "memberId", String.class)));
  }

  @PostMapping(value = {"/member/attr/tree/select"})
  @ResponseBody
  public ResponseEntity updateMemberTree(HttpServletRequest request, HttpServletResponse response,
                                         @RequestParam Map<String, String> params) {
    String selectIds = params.get("selectIds");
    String[] ids = StringUtils.split(selectIds, ",");
    sysMemberAttrService
      .updateMemberTree(ids, ConvertUtil.checkNotNull(params, "memberId", String.class));
    return ResponseEntity.ok(JsonResult.success());
  }

  @GetMapping(value = {"/member/attr/tree/select"})
  @ResponseBody
  public ResponseEntity getMemberTree(HttpServletRequest request, HttpServletResponse response,
                                         @RequestParam Map<String, String> params) {
    List data = sysMemberAttrService
      .getMemberTree(ConvertUtil.checkNotNull(params, "memberId", String.class));
    return ResponseEntity.ok(JsonResult.success(data));
  }

  @PostMapping("/member/saveOrUpdate")
  @ResponseBody
  public ResponseEntity saveOrUpdate(SysMember member) {
    member.setTreeKind(SysMemberDao.ADMIN_TREE_KIND);
    SysMember rs;
    if (StringUtils.isNotBlank(member.getId())) {
      rs = sysMemberService.updateBaseInfo(member);
    } else {
      rs = sysMemberService.addMember(member);
    }
    return ResponseEntity.ok(JsonResult.success(new MemberNodeBuilder().buildNode(rs, null, null)));
  }

  @PostMapping("/member/delete")
  @ResponseBody
  public ResponseEntity deleteMember(String id) {
    sysMemberService.delete(id);
    return ResponseEntity.ok(JsonResult.success());
  }

  @PostMapping("/member/doMove")
  @ResponseBody
  public ResponseEntity doMove(String srcId, String targetId, String hitMode) {
    sysMemberService.updateToMove(srcId, targetId, hitMode);
    return ResponseEntity.ok(JsonResult.success());
  }

  @GetMapping(value = {"/member/role"})
  @ResponseBody
  public ResponseEntity memberRoles(HttpServletRequest request, HttpServletResponse response,
                                    @RequestParam Map<String, String> param) {
    String id = ConvertUtil.checkNotNull(param, "memberId", String.class);
    return ResponseEntity.ok(sysRoleService.findRoleByMemberId(id));
  }

  @GetMapping(value = {"/member/auth/tree"})
  @ResponseBody
  public ResponseEntity memberAuthTree(HttpServletRequest request, HttpServletResponse response,
                                       @RequestParam Map<String, String> param) {
    String id = ConvertUtil.checkNotNull(param, "memberId", String.class);
    return ResponseEntity.ok(sysRoleService.findAuthAppInfoByMemberId(id));
  }

}
