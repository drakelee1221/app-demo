package com.drakelee.demo.database.dao.sys;


import com.drakelee.demo.common.domain.sys.SmsSendRecord;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * SmsSendRecord DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-22
 */
@Repository
public interface SmsSendRecordDao extends GenericJpaDao<SmsSendRecord, String>,SmsSendRecordExtendDao {

  /**
   * 统计未发送的短信记录
   * @param id
   * @return
   */
  @Query(value = "select count(1) from base_sms_send_record where sms_id=:smsId and status in  (0,2)",nativeQuery = true)
  long countUnSendRecord(@Param("smsId") String id);

  @Query(value="delete from base_sms_send_record where sms_id =:smsId",nativeQuery = true)
  @Modifying
  void deleteRecords(@Param("smsId") String smsId);
}

