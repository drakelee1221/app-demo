

package com.drakelee.demo.admin.dto.member;

import com.drakelee.demo.admin.constants.auth.ReadOrWrite;
import com.drakelee.demo.admin.constants.auth.ReadOrWrite;
import com.drakelee.demo.common.dto.admin.SysAppInfoDto;
import com.base.components.common.util.EnumUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

/**
 * AdminAuth
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-04 9:53
 */
public class AdminAuth implements Serializable {
  private static final long serialVersionUID = 1L;
  private boolean superRole;
  private Serializable tokenObjId;
  private List<SysAppInfoDto> appInfoDtoList;
  private Set<String> roleIds;
  private Set<String> roleCodes;

  public List<SysAppInfoDto> getAppInfoDtoList() {
    return appInfoDtoList;
  }

  public void setAppInfoDtoList(List<SysAppInfoDto> appInfoDtoList) {
    this.appInfoDtoList = appInfoDtoList;
  }

  public Serializable getTokenObjId() {
    return tokenObjId;
  }

  public void setTokenObjId(Serializable tokenObjId) {
    this.tokenObjId = tokenObjId;
  }

  public boolean getSuperRole() {
    return superRole;
  }

  public void setSuperRole(boolean superRole) {
    this.superRole = superRole;
  }

  public Set<String> getRoleIds() {
    return roleIds;
  }

  public void setRoleIds(Set<String> roleIds) {
    this.roleIds = roleIds;
  }

  public Set<String> getRoleCodes() {
    return roleCodes;
  }

  public void setRoleCodes(Set<String> roleCodes) {
    this.roleCodes = roleCodes;
  }

  /**
   * 权限验证，返回非空时则有权限访问
   * @param uri
   * @param requestMethod
   *
   * @return
   */
  public SysAppInfoDto checkAuthPath(String uri, String requestMethod) {
    if (!CollectionUtils.isEmpty(appInfoDtoList)) {
      for (SysAppInfoDto dto : appInfoDtoList) {
        SysAppInfoDto checked = check(
          dto, uri, requestMethod, EnumUtil.parse(ReadOrWrite.class, "value", dto.getReadWriteType()));
        if (null != checked) {
          return checked;
        }
      }
    }
    return null;
  }

  /**
   * 检查权限，是否含有此角色ID
   * @param roleId   nonnull - str - 角色ID
   * @return 是否含有此角色权限
   */
  public boolean checkRoleId(String roleId) {
    return roleIds != null && roleIds.contains(roleId);
  }

  /**
   * 检查权限，是否含有此角色code
   * @param roleCode   nonnull - str - 角色code
   * @return 是否含有此角色权限
   */
  public boolean checkRoleCode(String roleCode) {
    return roleCodes != null && roleCodes.contains(roleCode);
  }

  private SysAppInfoDto check(SysAppInfoDto sysAppInfoDto, String uri, String requestMethod, ReadOrWrite rw) {
    String urlPrefix = sysAppInfoDto.getAuthUrlPrefix();
    if(StringUtils.isNotBlank(urlPrefix)){
      for (String prefix : StringUtils.split(urlPrefix, ",")) {
        if (StringUtils.isNotBlank(prefix) && !"/".equals(prefix) && uri.startsWith(prefix)) {
          if (rw == null || rw.checkRequestMethod(requestMethod)) {
            return sysAppInfoDto;
          }
        }
      }
    }
    if (!CollectionUtils.isEmpty(sysAppInfoDto.getChildren())) {
      for (SysAppInfoDto child : sysAppInfoDto.getChildren()) {
        SysAppInfoDto checked = check(
          child, uri, requestMethod, EnumUtil.parse(ReadOrWrite.class, "value", child.getReadWriteType()));
        if (null != checked) {
          return checked;
        }
      }
    }
    return null;
  }
}
