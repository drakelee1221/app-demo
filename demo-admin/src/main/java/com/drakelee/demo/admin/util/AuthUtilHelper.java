

package com.drakelee.demo.admin.util;

import com.drakelee.demo.admin.service.member.SysMemberService;
import com.drakelee.demo.admin.dto.member.AdminAuth;
import com.drakelee.demo.admin.service.member.SysMemberService;
import com.base.components.common.boot.SpringContextUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.ui.ModelMap;

/**
 * AuthUtilHelper
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-05-22 11:00
 */
public abstract class AuthUtilHelper {

  /**
   * 设置 {@link AdminAuthWrapper} 对象到 view 中， 可以通过 varName.check(httpMethod, uri) 来判断是否含有此资源路径的权限
   * @param varName   nonnull - str - view中需要定义的变量名
   * @param modelMap  nonnull - obj - view对应的ModelMap
   */
  public static void setAuthToView(String varName, ModelMap modelMap){
    if(StringUtils.isNotBlank(varName)){
      modelMap.put(varName, getAuth());
    }
  }

  public static AdminAuthWrapper getAuth(){
    AdminAuth auth = null;
    try {
      auth = SpringContextUtil.getBean(SysMemberService.class).getCurrentAdminAuth();
    } catch (Exception ignore) {
    }
    return new AdminAuthWrapper(auth);
  }

  public static class AdminAuthWrapper{
    private final AdminAuth auth;
    AdminAuthWrapper(AdminAuth auth) {
      this.auth = auth;
    }

    /**
     * 验证是否含此资源路径的权限
     * @param httpMethod    nonnull - str - 资源路径，请求方式（get、post等）
     * @param uri           nonnull - str - 资源路径
     * @return 是否有权限访问，超级管理员始终为true
     */
    public boolean checkUri(String httpMethod, String uri){
      return auth != null && (auth.getSuperRole() || auth.checkAuthPath(uri, httpMethod) != null);
    }

    /**
     * 验证当前请求是否有权限，一般在“菜单管理”里面只设置了通用uri权限（如：/admin/模块名/），未具体制定每个uri权限的模块，
     * 需要控制某个角色是否可以访问时使用
     * @param roleId  nonnull - str - 角色ID
     * @return 是否含有此角色权限，超级管理员始终为true
     */
    public boolean checkRoleId(String roleId){
      return auth != null && (auth.getSuperRole() ||auth.checkRoleId(roleId));
    }

    /**
     * 验证当前请求是否有权限，一般在“菜单管理”里面只设置了通用uri权限（如：/admin/模块名/），未具体制定每个uri权限的模块，
     * 需要控制某个角色是否可以访问时使用
     * @param roleCode  nonnull - str - 角色code
     * @return 是否含有此角色权限，超级管理员始终为true
     */
    public boolean checkRoleCode(String roleCode){
      return auth != null && (auth.getSuperRole() ||auth.checkRoleCode(roleCode));
    }

    /**
     * 验证当前请求是否有权限，一般在“菜单管理”里面只设置了通用uri权限（如：/admin/模块名/），未具体制定每个uri权限的模块，
     * 需要控制某个角色是否可以访问时使用
     * @param roleCode  nonnull - str - 角色code
     * @return 是否含有此角色权限，超级管理员也需要验证
     */
    public boolean checkRoleCodeAll(String roleCode){
      return auth != null && auth.checkRoleCode(roleCode);
    }

    /**
     * 检查是否为超级管理员
     * @return boolean
     */
    public boolean checkSuperRole(){
      return auth != null && auth.getSuperRole();
    }
  }
}
