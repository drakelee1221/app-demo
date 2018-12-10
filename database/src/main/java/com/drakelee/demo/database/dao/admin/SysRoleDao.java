

package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.SysRole;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * SysRole DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-03
 */
@Repository
public interface SysRoleDao extends GenericJpaDao<SysRole, String> {

  @Query(value = "SELECT r.* FROM admin_sys_role r LEFT JOIN admin_sys_member_role mr ON mr.role_id = r.id "
    + "WHERE mr.member_id = :memberId ORDER BY r.order_no", nativeQuery = true)
  List<SysRole> findByMemberId(@Param("memberId") String memberId);

  @Query(value = "SELECT r.id FROM admin_sys_role r LEFT JOIN admin_sys_member_role mr ON mr.role_id = r.id "
    + "WHERE mr.member_id = :memberId ORDER BY r.order_no", nativeQuery = true)
  List<String> findIdByMemberId(@Param("memberId") String memberId);
}

