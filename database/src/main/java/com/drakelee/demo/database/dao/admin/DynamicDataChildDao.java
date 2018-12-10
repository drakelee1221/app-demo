package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.DynamicDataChild;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * DynamicDataChild DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-20
 */
@Repository
public interface DynamicDataChildDao extends GenericJpaDao<DynamicDataChild, String> {

  @Query(value = "select type from base_dynamic_data_child where code = :code group by type", nativeQuery = true)
  List<String> groupTypeByCode(@Param("code") String code);

  Optional<DynamicDataChild> findFirstByCodeAndType(@Param("code") String code, @Param("type") String type);
}

