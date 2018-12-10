package com.drakelee.demo.admin.controller.dynamicform;

import com.fasterxml.jackson.databind.node.ArrayNode;
import com.drakelee.demo.admin.service.dynamicform.DynamicFormDataService;
import com.drakelee.demo.admin.service.dynamicform.DynamicFormDataService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.token.RequireToken;
import com.drakelee.demo.common.token.user.UserMemberToken;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * DynamicFormData Controller
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-15
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class DynamicFormDataController {

  @Autowired
  private DynamicFormDataService dynamicFormDataService;

  @GetMapping("/dynamicform/index")
  public String indexPage(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    List<Map> codes = dynamicFormDataService.listCode();
    modelMap.put("codes", codes);
    return "dynamicform/index";
  }

  @GetMapping("/dynamicform/codeindex")
  public String codeIndex(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "dynamicform/codeindex";
  }

  @GetMapping("/dynamicform/columnsindex")
  public String columnsindex(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    return "dynamicform/columnsindex";
  }

  /**
   * 分页
   *
   * @param params -
   * <p> pageNum        - Nullable   - Int - 当前页
   * <p> pageSize       - Nullable   - Int - 每页记录数
   *
   * @return DataPage
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/page")
  public ResponseEntity page(@RequestParam Map<String, String> params) {
    DataPage dataPage = DataPage.getEmpty();
    if(StringUtils.isNotBlank(params.get("code"))) {
      dataPage = dynamicFormDataService.page(params);
    }
    return ResponseEntity.ok(dataPage);
  }

  /**
   * 查询列
   *
   * @param params -
   *
   * @return DataPage
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/columns")
  public ResponseEntity columns(@RequestParam Map<String, String> params) {
    ArrayNode result = JsonUtils.mapper.createArrayNode();
    if(StringUtils.isNotBlank(params.get("code"))){
      result = dynamicFormDataService.columns(params.get("code"));
    }
    return ResponseEntity.ok(result);
  }

  /**
   * 查询列
   *
   * @param params -
   *
   * @return DataPage
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/columns/page")
  public ResponseEntity pageColumns(@RequestParam Map<String, String> params) {
    DataPage page = dynamicFormDataService.pageColumns(params);
    return ResponseEntity.ok(page);
  }

  /**
   * 查询type
   *
   * @param params -
   *
   * @return DataPage
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/type")
  public ResponseEntity type(@RequestParam Map<String, String> params) {
      List<String> arr = dynamicFormDataService.type(ConvertUtil.checkNotNull(params, "code", String.class));
    return ResponseEntity.ok(arr);
  }

  /**
   * 查询child columns
   *
   * @param params -
   *
   * @return DataPage
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/child/columns")
  public ResponseEntity childColumns(@RequestParam Map<String, String> params) {
    ArrayNode arr = dynamicFormDataService.childColumns(ConvertUtil.checkNotNull(params, "code", String.class),
                                                        ConvertUtil.checkNotNull(params, "type", String.class));
    return ResponseEntity.ok(arr);
  }

  /**
   * 查询附属信息
   *
   * @param params -
   *
   * @return DataPage
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/child")
  public ResponseEntity child(@RequestParam Map<String, String> params) {
      List<Map> arr = dynamicFormDataService.child(ConvertUtil.checkNotNull(params, "id", String.class),
                                                      ConvertUtil.checkNotNull(params, "type", String.class));
    return ResponseEntity.ok(arr);
  }

  /**
   * code列表
   *
   * @param params -
   *
   * @return dynamicFormData
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/dynamicform/code")
  public ResponseEntity code(@RequestParam Map<String, String> params) {
    DataPage page = dynamicFormDataService.pageCode(params);
    return ResponseEntity.ok(page);
  }

  /**
   * code新增修改
   *
   * @param params -
   *
   * @return dynamicFormData
   */
  @RequireToken(UserMemberToken.class)
  @PostMapping("/dynamicform/code")
  public ResponseEntity codeSaveOrUpdate(@RequestParam Map<String, String> params) {
    return ResponseEntity.ok(dynamicFormDataService.saveOrUpdataCode(params.get("id"), ConvertUtil.checkNotNull(params, "code", String.class),
                                                                     ConvertUtil.checkNotNull(params, "title", String.class),
                                                                     ConvertUtil.checkNotNull(params, "beginTime", String.class),
                                                                     ConvertUtil.checkNotNull(params, "endTime", String.class),
                                                                     params.get("remark")));
  }

  /**
   * columns新增修改
   *
   * @param params -
   *
   * @return -
   */
  @RequireToken(UserMemberToken.class)
  @PostMapping("/dynamicform/columns")
  public ResponseEntity columnsSaveOrUpdate(@RequestParam Map<String, String> params) {
    try {
      JsonUtils.reader(ConvertUtil.checkNotNull(params, "jsonData", String.class), ArrayNode.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("json数据格式错误！");
    }
    return ResponseEntity.ok(dynamicFormDataService.saveOrUpdataColumns(params.get("id"), ConvertUtil.checkNotNull(params, "code", String.class),
                                                                        ConvertUtil.checkNotNull(params, "jsonData", String.class)));
  }
}
