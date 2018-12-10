

package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.SysMemberRole;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * SysMemberRole DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-03
 */
@Repository
public interface SysMemberRoleDao extends GenericJpaDao<SysMemberRole, String> {

  @Query(value = "SELECT mr.role_id roleId, m.id id, m.account account, m.member_code memberCode, m.member_name memberName, m.gender gender, m.email_address emailAddress, m.member_type memberType, m.`status` `status`, m.parent_id parentId, m.left_val leftVal, m.right_val rightVal "
    + "FROM admin_sys_member m LEFT JOIN admin_sys_member_role mr ON mr.member_id = m.id AND mr.role_id IN (:roleIds) "
    + "WHERE m.tree_kind = '"+SysMemberDao.ADMIN_TREE_KIND+"' ORDER BY m.left_val", nativeQuery = true)
  List<Map<String,Object>> findAllMemberJoinRole(@Param("roleIds")Collection<String> roleIds);

  int deleteByRoleId(String roleId);
}

