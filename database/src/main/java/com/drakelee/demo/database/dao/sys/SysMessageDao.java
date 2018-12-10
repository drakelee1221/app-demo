

package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.SysMessage;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * SysMessage DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface SysMessageDao extends GenericJpaDao<SysMessage, String>, SysMessageExtendDao {

  /**
   * 设置所有消息已读
   *
   * @param userId
   */
  @Query(value = "update base_sys_message set status=1,know_time=sysdate() where user_id=:userId and status=0 ", nativeQuery = true)
  @Modifying
  void updateMessageReadStatus(@Param("userId") String userId);

  @Query(value = "select count(1) from base_sys_message where status = :status", nativeQuery = true)
  long countByUnread(@Param("status") int status);

  /**
   * 设置消息删除标记
   *
   * @param ids
   * @param delFlag
   */
  @Query(value = "update base_sys_message set del_flag=:delFlag where user_id= :userId and id in (:ids)", nativeQuery = true)
  @Modifying
  void updateDelFlag(@Param("userId") String userId, @Param("ids") List<String> ids, @Param("delFlag") Integer delFlag);

  /**
   * 设置全部消息删除标记
   *
   * @param delFlag
   */
  @Query(value = "update base_sys_message set del_flag=:delFlag where user_id= :userId", nativeQuery = true)
  @Modifying
  void updateDelFlag(@Param("userId") String userId, @Param("delFlag") Integer delFlag);
}

