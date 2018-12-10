

package com.drakelee.demo.admin.controller.auth;

import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.admin.service.auth.AppInfoNodeBuilder;
import com.drakelee.demo.admin.service.auth.SysAppInfoService;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.admin.service.auth.AppInfoNodeBuilder;
import com.drakelee.demo.admin.service.auth.SysAppInfoService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.admin.SysAppInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * AppInfoController
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-17 10:33
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class AppInfoController {
  @Autowired
  private SysAppInfoService sysAppInfoService;

  @GetMapping("/appInfo/index")
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "app_info/index";
  }

  @GetMapping("/appInfo/tree")
  @ResponseBody
  public ResponseEntity tree(HttpServletRequest request, HttpServletResponse response) {
    List<TreeNodeData<SysAppInfo>> treeNodeData = sysAppInfoService.loadTreeNodes(new TreeParam(request));
    return ResponseEntity.ok(treeNodeData);
  }

  @PostMapping("/appInfo/saveOrUpdate")
  @ResponseBody
  public ResponseEntity saveOrUpdate(SysAppInfo appInfo){
    SysAppInfo rs;
    if(StringUtils.isNotBlank(appInfo.getId())){
      rs = sysAppInfoService.updateAppInfo(appInfo);
    }
    else{
      rs = sysAppInfoService.addAppInfo(appInfo);
    }
    return ResponseEntity.ok(JsonResult.success(AppInfoNodeBuilder.buildNode(rs, null)));
  }

  @PostMapping("/appInfo/delete")
  @ResponseBody
  public ResponseEntity deleteMember(String id){
    sysAppInfoService.delete(id);
    return ResponseEntity.ok(JsonResult.success());
  }

  @PostMapping("/appInfo/doMove")
  @ResponseBody
  public ResponseEntity doMove(String srcId, String targetId, String hitMode){
    sysAppInfoService.updateToMove(srcId, targetId, hitMode);
    return ResponseEntity.ok(JsonResult.success());
  }
}
