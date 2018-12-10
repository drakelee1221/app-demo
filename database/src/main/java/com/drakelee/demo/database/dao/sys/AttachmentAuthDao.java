package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.AttachmentAuth;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * AttachmentAuth DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-27
 */
@Repository
public interface AttachmentAuthDao extends GenericJpaDao<AttachmentAuth, java.lang.String>, AttachmentAuthExtendDao {

  @Query(value = "select user_id as userId, url from base_attachment_auth where attachment_id = :attachmentId",
    nativeQuery = true)
  List<Map<String, String>> findAuthList(@Param("attachmentId") String attachmentId);

  List<String> findUserIdById(String id);
}

