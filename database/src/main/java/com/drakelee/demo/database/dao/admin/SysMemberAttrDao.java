package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.SysMemberAttr;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * SysMemberAttr DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-08
 */
@Repository
public interface SysMemberAttrDao extends GenericJpaDao<SysMemberAttr, String> {

  @Query(value = "select attr_value from admin_sys_member_attr where member_id = :memberId", nativeQuery = true)
  List<String> findValue(@Param("memberId") String memberId);

  @Query(value = "select attr_value from admin_sys_member_attr where member_id = :memberId AND attr_key = :attrKey", nativeQuery = true)
  List<String> findValue(@Param("memberId") String memberId, @Param("attrKey") String attrKey);

  /**
   * 查询当前登录的后台用户父节点的属性
   * @param currentMemberId 当前登录的后台用户
   */
  @Query(value = "SELECT DISTINCT ma.attr_value FROM admin_sys_member m "
    + "LEFT JOIN admin_sys_member_attr ma ON m.parent_id = ma.member_id WHERE m.id = :currentMemberId AND ma.attr_key = :attrKey", nativeQuery = true)
  List<String> findParentValue(@Param("currentMemberId") String currentMemberId, @Param("attrKey") String attrKey);

  long deleteByMemberId(String memberId);

  @Query(value = "select sm.member_name name, sm.id,r.name_path namePath from admin_sys_member_attr sma left join admin_sys_member sm on sma.attr_value = sm.id left join base_region r on sm.region_id = r.id where sma.member_id = :memberId", nativeQuery = true)
  List<Map<String, Object>> getMemberTree(@Param("memberId") String memberId);
}

