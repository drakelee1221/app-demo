package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.DictionaryData;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * DictionaryData DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-07-02
 */
@Repository
public interface DictionaryDataDao extends GenericJpaDao<DictionaryData, String> {

  @Query(value = "select max(order_no) from base_dictionary_data where dict_id= :dictId", nativeQuery = true)
  Integer maxOrderNo(@Param("dictId") String dictId);

  @Query(value = "select count(1) from base_dictionary_data where id!= :id and dict_id= :dictId and data_key= :dataKey", nativeQuery = true)
  int countSameUpdate(@Param("id") String id, @Param("dictId") String dictId, @Param("dataKey") String dataKey);

  @Query(value = "select count(1) from base_dictionary_data where dict_id= :dictId and data_key= :dataKey", nativeQuery = true)
  int countSameInsert(@Param("dictId") String dictId, @Param("dataKey") String dataKey);

  @Query(value =
    "select a.id,a.data_value as dataValue,a.data_key as dataKey,a.data_name as dataName,a.order_no as orderNo,a.remarks as dataRemark,a.status, "
      + "b.id as dictId,b.dict_code as dictCode,b.dict_name as dictName,b.data_type as dataType,b.remarks as dictRemark  "
      + "from base_dictionary_data a left join base_dictionary b on a.dict_id = b.id  "
      + "where a.status=1 and b.status=1 and b.dict_code= :dictCode " + "order by a.order_no asc ", nativeQuery = true)
  List<Map> dictionaryData(@Param("dictCode") String dictCode);


}

