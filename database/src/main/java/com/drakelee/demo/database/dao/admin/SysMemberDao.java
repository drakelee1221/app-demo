

package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.SysMember;
import com.drakelee.demo.common.dto.sys.SysMemberCountDto;
import com.base.components.database.dao.base.GenericJpaDao;
import com.base.components.database.dao.base.annotation.ReturnMapKeys;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * SysMember DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-17
 */
@Repository
public interface SysMemberDao extends GenericJpaDao<SysMember, String> {

  String ADMIN_TREE_KIND = "ADMIN";

  String PROFESSION_TREE_KIND = "PROFESSION";

  /**
   * 根节点的 PARENT_ID
   */
  String ROOT_PARENT = "";


  /**
   * 查询根节点集合
   * @return roots
   */
  @Query("from SysMember where parentId = '"+ROOT_PARENT+"' and treeKind like :treeKind order by leftVal")
  List<SysMember> findRoots(@Param("treeKind") String treeKind);

  /**
   * 查询所有节点集合
   * @return roots
   */
  @Query("from SysMember order by leftVal")
  List<SysMember> findAllNode();

  @Query("from SysMember where treeKind = :treeKind order by leftVal")
  List<SysMember> findAllNode(@Param("treeKind") String treeKind);

  /**
   * 查询第一层子节点
   * @param parentId  父节点ID
   *
   * @return
   */
  List<SysMember> findByParentIdOrderByLeftVal(String parentId);

  /**
   * 更加帐号查找
   * @param account 帐号
   *
   * @return
   */
  SysMember findByAccount(String account);

  @Query(value = "UPDATE admin_sys_member SET last_login_ip = :loginIp, last_login_time = NOW() WHERE id = :id",
    nativeQuery = true)
  @Modifying
  int updateLoginInfo(@Param("id") String memberId, @Param("loginIp") String loginIp);




  @Query(value = "select id,case when parent_id is null or parent_id='' then 0 else parent_id end as parentId,member_name as name,status from admin_sys_member "
    + "where tree_kind like :regionId",
    nativeQuery = true)
  List<Map> memberTree(@Param("regionId") String regionId);

  @Query(value = "select id,case when parent_id is null or parent_id='' then 0 else parent_id end as parentId,name,status from base_region where status=1",
    nativeQuery = true)
  List<Map> regionTree();

  @Query("from SysMember where memberName like ?1")
  List<SysMember> findByMemberName(String memberName);
}

