package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.DynamicDataCode;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * DynamicDataCode DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-21
 */
@Repository
public interface DynamicDataCodeDao extends GenericJpaDao<DynamicDataCode, String>{

  @Query(value = "select c.id, c.code, c.title, c.begin_time beginTime, c.end_time endTime, (select count(1) from "
    + "base_dynamic_form_data d where d.code = c.code) count from base_dynamic_data_code c", nativeQuery = true)
  Page<Map> pageCode(Pageable pageable);

  @Query(value = "from DynamicDataCode where code=:code and beginTime<:date and endTime>:date")
  Optional<DynamicDataCode> existsCode(@Param("code") String code, @Param("date")  Date date);

  @Query(value = "select code,concat(code, '-', title) title from base_dynamic_data_code", nativeQuery = true)
  List<Map> listCode();
}

