package com.drakelee.demo.database.dao.user;

import com.drakelee.demo.common.domain.user.UserBaseType;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

/**
 * UserBaseType DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-09
 */
@Repository
public interface BaseUserTypeDao extends GenericJpaDao<UserBaseType, String> {

  @Query(value = "select user_type from base_user_base_type where id = :id", nativeQuery = true)
  Integer findUserTypeById(@Param("id") String id);

  @Query(value = "select * from base_user_base_type where user_type NOT IN (0, 1) order by user_type", nativeQuery = true)
  List<UserBaseType> findAllExceptBaseUserType();

  @Query(value = "select id from base_user_base_type where user_type NOT IN (0, 1)", nativeQuery = true)
  Set<String> findAllExceptBaseUserTypeIds();

  @Query(value = "select id from base_user_base_type where user_type = :userType", nativeQuery = true)
  String findIdByUserType(@Param("userType") Integer userType);

  @Query(value = "select user_type_name from base_user_base_type where user_type = :userType", nativeQuery = true)
  String findNameByUserType(@Param("userType") Integer userType);
}

