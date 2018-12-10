package com.drakelee.demo.database.dao.sys.impl;

import com.base.components.common.dto.page.DataPage;
import com.base.components.database.dao.base.AbstractExtendDao;
import com.base.components.database.dao.base.NativeSQLBuilder;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.drakelee.demo.database.dao.sys.AttachmentAuthExtendDao;

import javax.persistence.Query;
import java.util.Map;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/5/10 0010 09:18
 */
public class AttachmentAuthDaoImpl extends AbstractExtendDao<Map> implements AttachmentAuthExtendDao{

  @Override
  public DataPage<Map> searchCollectData(Integer fileType, String userId, int pageNum, int pageSize) {

    String querySql = "select a.id,a.file_type as fileType,a.url,a.remark from base_attachment a left join base_attachment_auth aa on a.id = "
        + " aa.attachment_id where 1=1 ";

    String countSql = "select count(1) from base_attachment a left join base_attachment_auth aa on a.id = aa.attachment_id where 1=1 ";

    NativeSQLBuilder sqlBuilder = new NativeSQLBuilder();
    if(fileType != null){
      sqlBuilder.and().addWhere("a", "file_type", fileType, ConditionEnum.OPERATE_EQUAL);
    }
    sqlBuilder.and().addWhere("aa", "user_id", userId, ConditionEnum.OPERATE_EQUAL);

    sqlBuilder.bindQuerySql(querySql).orderBy(" a.id");
    Query listQuery = setMapResult(sqlBuilder.build(entityManager));
    sqlBuilder.bindQuerySql(countSql);
    Query countQuery = sqlBuilder.build(entityManager);

    return pageByQuery(countQuery, listQuery, pageNum, pageSize);
  }
}
