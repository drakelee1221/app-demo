package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.Dictionary;

import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * Dictionary DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-07-02
 */
@Repository
public interface DictionaryDao extends GenericJpaDao<Dictionary, String> {

  @Query(value = "select max(order_no) from base_dictionary",nativeQuery = true)
  Integer maxOrderNo();


  @Query(value = "select count(1) from base_dictionary where id!= :id and (dict_code= :dictCode or dict_name= :dictName)", nativeQuery = true)
  int countSameUpdate(@Param("id") String id, @Param("dictCode") String dictCode, @Param("dictName") String dictName);

  @Query(value = "select count(1) from base_dictionary where dict_code= :dictCode or dict_name= :dictName", nativeQuery = true)
  int countSameInsert(@Param("dictCode") String dictCode, @Param("dictName") String dictName);

}

