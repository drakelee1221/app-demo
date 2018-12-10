package com.drakelee.demo.admin.controller.region;

import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.admin.service.region.RegionNodeBuilder;
import com.drakelee.demo.admin.service.region.RegionService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.sys.Region;
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
 * RegionController
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/22 0022 16:31
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class RegionController {

  @Autowired
  RegionService regionService;

  @GetMapping(value = {"/region/index"})
  public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "region/index";
  }

  @GetMapping(value = {"/region/tree"})
  @ResponseBody
  public ResponseEntity tree(HttpServletRequest request, HttpServletResponse response) {
    List<TreeNodeData<Region>> treeNodeData = regionService.loadTreeNodes(new TreeParam(request));
    return ResponseEntity.ok(treeNodeData);
  }

  @GetMapping(value = {"/region/member/tree"})
  @ResponseBody
  public ResponseEntity memberCountTree(HttpServletRequest request, HttpServletResponse response) {
    List<TreeNodeData<Region>> treeNodeData = regionService.loadTreeNodes(new TreeParam(request),
                                                                          RegionService.CountType.MEMBER);
    return ResponseEntity.ok(treeNodeData);
  }
  @PostMapping("/region/saveOrUpdate")
  @ResponseBody
  public ResponseEntity saveOrUpdate(Region region) {
    Region rs;
    if (StringUtils.isNotBlank(region.getId())) {
      rs = regionService.updateBaseInfo(region);
    } else {
      rs = regionService.addRegion(region);
    }
    return ResponseEntity.ok(JsonResult.success(RegionNodeBuilder.buildNode(rs, null)));
  }

  @PostMapping("/region/delete")
  @ResponseBody
  public ResponseEntity delete(String id) {
    regionService.delete(id);
    return ResponseEntity.ok(JsonResult.success());
  }


}
