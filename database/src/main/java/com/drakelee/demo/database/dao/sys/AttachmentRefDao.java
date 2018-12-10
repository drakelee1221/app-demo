package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.AttachmentRef;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * AttachmentRef DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-05-09
 */
@Repository
public interface AttachmentRefDao extends GenericJpaDao<AttachmentRef, String> {


  @Query(value = "delete from base_attachment_ref where attachment_id = :id and ref_id = :refid", nativeQuery = true)
  @Modifying
  void delRef(@Param("id") String id, @Param("refid") String refid);


  @Query(value = "select a.id,a.name,a.url from base_attachment_ref ar left join base_attachment a on ar.attachment_id = a.id where ar.ref_id = :refId", nativeQuery = true)
  List<Map> listAttachmentByRefId(@Param("refId") String refId);
}

