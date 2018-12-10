package com.drakelee.demo.database.dao.sys.impl;

import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.database.dao.base.AbstractExtendDao;
import com.base.components.database.dao.base.NativeSQLBuilder;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.drakelee.demo.common.domain.sys.Email;
import com.drakelee.demo.database.dao.sys.EmailExtendDao;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.Query;
import java.util.Map;

/**
 * EmailDaoImpl
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-19 15:39
 */
public class EmailDaoImpl extends AbstractExtendDao<Email> implements EmailExtendDao {



  @Override
  public DataPage queryEmails(Map<String, String> params) {
    int pageNum = Pages.Helper.pageNum(params.get("pageNum"));
    int pageSize = Pages.Helper.pageSize(params.get("pageSize"));
    String keywords = params.get("keywords") == null ? "" : params.get("keywords");
    String startDate = ConvertUtil.convert(params.get("startDate"), "");
    String endDate = ConvertUtil.convert(params.get("endDate"), "");
    String status = ConvertUtil.convert(params.get("status"), "");

    String querySql = "select id,subject,addressee,remark,create_time as createTime,author_id as authorId"
      + ",status,mailbox_id,count,send_time as sendTime from base_email e where 1=1 ";
    String countSql = "select count(1) from base_email e where 1=1 ";

    NativeSQLBuilder sqlBuilder = new NativeSQLBuilder();

    if(StringUtils.isNotBlank(keywords)){
      sqlBuilder.and().addWhere("e", "subject", keywords, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if(StringUtils.isNotBlank(status)){
      sqlBuilder.and().addWhere("e", "status", status, ConditionEnum.OPERATE_EQUAL);
    }
    if(StringUtils.isNotBlank(startDate)){
      sqlBuilder.and().addWhere("e", "create_time", startDate, ConditionEnum.OPERATE_GREATER_EQUAL, "startDate");
    }
    if(StringUtils.isNotBlank(endDate)){
      sqlBuilder.and().addWhere("e", "create_time", endDate, ConditionEnum.OPERATE_LESS_EQUAL, "endDate");
    }
    sqlBuilder.bindQuerySql(querySql);
    Query listQuery = setMapResult(sqlBuilder.build(entityManager));
    sqlBuilder.bindQuerySql(countSql);
    Query countQuery = sqlBuilder.build(entityManager);

    return pageByQuery(countQuery, listQuery, pageNum, pageSize);
  }
}
