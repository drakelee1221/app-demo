

package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.SysAppInfo;
import com.drakelee.demo.common.dto.admin.SysAppInfoDto;
import com.base.components.database.dao.base.GenericJpaDao;
import com.base.components.database.dao.base.annotation.ReturnMapKeys;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * SysAppInfo DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-02
 */
@Repository
public interface SysAppInfoDao extends GenericJpaDao<SysAppInfo, String> {
  /**
   * 根节点ID
   */
  String ROOT = "ROOT";
  /**
   * 根节点的 PARENT_ID
   */
  String ROOT_PARENT = "";

  /**
   * 查询根节点集合
   * @return roots
   */
  @Query("FROM SysAppInfo WHERE parentId = '"+ROOT_PARENT+"' ORDER BY leftVal")
  List<SysAppInfo> findRoots();

  /**
   * 查询第一层子节点
   * @param parentId  父节点ID
   *
   * @return
   */
  List<SysAppInfo> findByParentIdOrderByLeftVal(String parentId);

  @Query(value =
    "SELECT DISTINCT a.* "
      + "FROM admin_sys_app_info a LEFT JOIN admin_sys_app_info_role ar ON ar.app_info_id = a.id "
      + "LEFT JOIN admin_sys_member_role mr ON mr.role_id = ar.role_id "
      + "LEFT JOIN admin_sys_role r ON r.id = mr.role_id "
      + "WHERE mr.member_id = :memberId AND a.`status` = 1 AND r.`status` = 1 ORDER BY a.left_val", nativeQuery = true)
  List<SysAppInfo> findAuthAppInfoByMemberId(@Param("memberId") String memberId);

  @Query(value =
    "SELECT DISTINCT a.id id, a.`name` `name`, a.description description, a.target_url targetUrl, a.params_json paramsJson, a.auth_url_prefix authUrlPrefix, a.icon_class iconClass, a.`directory` `directory`, a.read_write_type readWriteType, a.parent_id parentId, a.left_val "
      + "FROM admin_sys_app_info a LEFT JOIN admin_sys_app_info_role ar ON ar.app_info_id = a.id "
      + "LEFT JOIN admin_sys_member_role mr ON mr.role_id = ar.role_id "
      + "LEFT JOIN admin_sys_role r ON r.id = mr.role_id "
      + "WHERE mr.member_id = :memberId AND a.`status` = 1 AND r.`status` = 1 ORDER BY a.left_val", nativeQuery = true)
  @ReturnMapKeys(
    value = {"id","name","description","targetUrl","paramsJson","authUrlPrefix","iconClass","directory","readWriteType","parentId"},
    returnType = SysAppInfoDto.class)
  <R> List<R> findAuthAppInfoDtoByMemberId(@Param("memberId") String memberId);

  @Query(value =
    "SELECT DISTINCT a.id id, a.`name` `name`, a.description description, a.target_url targetUrl, a.params_json paramsJson, a.auth_url_prefix authUrlPrefix, a.icon_class iconClass, a.`directory` `directory`, a.read_write_type readWriteType, a.parent_id parentId, a.left_val "
      + "FROM admin_sys_app_info a WHERE a.`status` = 1 AND a.id <> '"+ROOT+"' ORDER BY a.left_val", nativeQuery = true)
  @ReturnMapKeys(
    value = {"id","name","description","targetUrl","paramsJson","authUrlPrefix","iconClass","directory","readWriteType","parentId"},
    returnType = SysAppInfoDto.class)
  <R> List<R> findAllAppInfoDto();
}

