package com.drakelee.demo.admin.controller.user;

import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.user.BaseUserTypeService;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.user.BaseUserTypeService;
import com.drakelee.demo.common.constants.UserType;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.user.UserBaseType;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.token.RequireToken;
import com.drakelee.demo.common.token.user.UserMemberToken;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/4/9 0009 14:02
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class UserTypeController {

  @Autowired
  private BaseUserTypeService baseUserTypeService;

  /**
   * 跳转到类型管理页面
   *
   * @param request
   * @param response
   * @param modelMap
   *
   * @return
   */
  @GetMapping({"/userType/index"})
  public String typeIndex(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    return "userType/index";
  }

  /**
   * 获取用户类型
   *
   * @param params -
   * <p>  pageSize                  - Notnull   - Str - desc
   * <p>  pageNum                   - Notnull   - Str - desc
   *
   * @return
   */
  @RequireToken(UserMemberToken.class)
  @GetMapping("/userType/page")
  public ResponseEntity page(@RequestParam Map<String, String> params) {
    DataPage dataPage = baseUserTypeService.page(params);
    return ResponseEntity.ok(dataPage);
  }

  /**
   * 增加用户类型
   *
   * @param -
   *
   * @return
   */
  @RequireToken(UserMemberToken.class)
  @PostMapping("/userType/save")
  public ResponseEntity saveOrUpdate(UserBaseType userBaseType) {
    boolean boo = true;
    if (StringUtils.isBlank(userBaseType.getId())) {
      boo = baseUserTypeService.addUserType(userBaseType);
    } else {
      baseUserTypeService.updateUserType(userBaseType);
    }
    return ResponseEntity.ok(boo ? JsonResult.success() : JsonResult.fail("只能拥有一位类型编号为1的用户类型！"));
  }

  /**
   * 删除用户类型
   *
   * @param -
   *
   * @return
   */
  @RequireToken(UserMemberToken.class)
  @PostMapping("/userType/delete")
  public ResponseEntity deleteUserType(@RequestParam String id) {
    baseUserTypeService.deleteUserType(id);
    return ResponseEntity.ok(JsonResult.success());
  }


  @GetMapping("/userType/register")
  @ResponseBody
  public ResponseEntity page() {
    List<Integer> types = new ArrayList<>();
    types.add(UserType.MANAGER.getCode());
    types.add(UserType.SERVICE.getCode());
    ConditionGroup<UserBaseType> build = ConditionGroup.build()
      .addCondition("userType", ConditionEnum.OPERATE_IN, (Serializable) types);
    List<UserBaseType> userBaseTypes = baseUserTypeService.findAll(build);
    return new ResponseEntity<>(JsonResult.success(userBaseTypes), HttpStatus.OK);
  }
}
