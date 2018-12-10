

package com.drakelee.demo.database.dao.sys;

import com.base.components.database.dao.base.GenericJpaDao;
import com.base.components.database.dao.base.annotation.ReturnMapKeys;
import com.drakelee.demo.database.dao.admin.SysMemberDao;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.common.dto.sys.RegionCountDto;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Region DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface RegionDao extends GenericJpaDao<Region, String> {

  String ROOT_PARENTID = "ROOT";

  /**
   * 查询根节点集合
   *
   * @return roots
   */
  @Query("from Region where parentId='" + ROOT_PARENTID + "' order by orderNo asc")
  List<Region> findRoots();

  /**
   * 查询下一层子节点集
   *
   * @param parentId 父节点ID
   *
   * @return
   */
  @Query("from Region where parentId=:parentId order by orderNo asc")
  List<Region> findByParentId(@Param("parentId") String parentId);

  @Query(value =
    "select r.id id, r.name `name`, r.name_path namePath, r.order_no orderNo, r.parent_id parentId, r.leaf leaf, r.remark remark, r.create_time createTime, r.status `status`, "
      + "( " + "select count(m.id) from admin_sys_member m "
      + "left join admin_sys_member c on m.left_val < c.left_val and m.tree_kind = c.tree_kind "
      + "where m.left_val = 1 and m.tree_kind like concat(r.id,'%')) `count` from base_region r where r.parent_id is null or r.parent_id = '' order by r.order_no asc", nativeQuery = true)
  @ReturnMapKeys(value = {"id", "name", "namePath", "orderNo", "parentId", "leaf", "remark", "createTime", "status",
    "count"}, returnType = RegionCountDto.class)
  <R> List<R> findRootsWithUserCount();

  @Query(value = "select id,leaf from base_region where parent_id in :parentIds", nativeQuery = true)
  List<Map<String, Object>> findChildrens(@Param("parentIds") List parentIds);


  @Query(value =
    "select r.id id, r.name `name`, r.name_path namePath, r.order_no orderNo, r.parent_id parentId, r.leaf leaf, "
      + "r.remark remark, r.create_time createTime, r.status `status`, (SELECT count(1) FROM admin_sys_member sm "
      + " WHERE sm.region_id IN (SELECT re.id FROM base_region re WHERE re.left_val>=r.left_val AND re.right_val<=r"
      + ".right_val ) AND sm.left_val = 1 AND tree_kind != '" + SysMemberDao.ADMIN_TREE_KIND
      + "') `count` from base_region r where r.parent_id = :parentId ", nativeQuery = true)
  @ReturnMapKeys(value = {"id", "name", "namePath", "orderNo", "parentId", "leaf", "remark", "createTime", "status",
    "count"}, returnType = RegionCountDto.class)
  <R> List<R> findByParentIdWithMemberCount(@Param("parentId") String parentId);

  @Query(value = "SELECT p.* FROM base_region p, (SELECT left_val, right_val FROM base_region WHERE id = :id) c "
    + "WHERE p.left_val < c.left_val AND p.right_val > c.right_val AND p.id <> '" + ROOT_PARENTID
    + "' ORDER BY p.left_val ", nativeQuery = true)
  List<Region> findParents(@Param("id") String id);

  @Query(value = "SELECT p.* FROM base_region p, (SELECT left_val, right_val FROM base_region WHERE id = :id) c "
    + "WHERE p.left_val <= c.left_val AND p.right_val >= c.right_val AND p.id <> '" + ROOT_PARENTID
    + "' ORDER BY p.left_val ", nativeQuery = true)
  List<Region> findParentsAndSelf(@Param("id") String id);

  @Query(value = "select id, `name`, (CASE WHEN id = :selfId THEN 1 ELSE 0 END) selected from base_region WHERE parent_id = :parentId ORDER BY left_val", nativeQuery = true)
  List<Map<String, Object>> findSelected(@Param("parentId") String parentId, @Param("selfId") String selfId);

  @Query(value =
    "  SELECT   r.id id,   r.NAME `name`,   r.name_path namePath,   r.order_no orderNo, "
      + " r.parent_id parentId,   r.leaf leaf,   r.remark remark,   r.create_time createTime, "
      + " r.STATUS `status`,   count(ui.id)  FROM   base_region r "
      + " LEFT JOIN base_region re ON (re.left_val >= r.left_val AND re.right_val <= r.right_val ) "
      + "  LEFT JOIN base_user_base_info ui ON ui.region_id = re.id  AND ui.user_type = :userType  WHERE "
      + " r.parent_id = :parentId  GROUP BY   r.id", nativeQuery = true)
  @ReturnMapKeys(value = {"id", "name", "namePath", "orderNo", "parentId", "leaf", "remark", "createTime", "status",
    "count"}, returnType = RegionCountDto.class)
  <R> List<R> findByParentIdWithNormalUserCount(@Param("userType") int userType, @Param("parentId") String parentId);

}


