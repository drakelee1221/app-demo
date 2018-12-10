package com.drakelee.demo.database.dao.sys.impl;

import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.sys.Sms;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.database.dao.base.AbstractExtendDao;
import com.base.components.database.dao.base.NativeSQLBuilder;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.drakelee.demo.database.dao.sys.SmsExtendDao;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.Query;
import java.util.Map;

/**
 * EmailDaoImpl
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-19 15:39
 */
public class SmsDaoImpl extends AbstractExtendDao<Sms> implements SmsExtendDao {

  @Override
  public DataPage querySysSms(Map<String, String> params) {
    int pageNum = Pages.Helper.pageNum(params.get("pageNum"));
    int pageSize = Pages.Helper.pageSize(params.get("pageSize"));
    String keywords = params.get("keywords") == null ? "" : params.get("keywords");
    String startDate = ConvertUtil.convert(params.get("startDate"),"");
    String endDate = ConvertUtil.convert(params.get("endDate"),"");
    String status = ConvertUtil.convert(params.get("status"),"");

    String querySql = "select tpl.tpl_name as templateName,tpl.content as tplContent,e.id,param_json as content,batch,remarks,e.create_time as createTime,author_id as authorId"
      + ",e.status,send_time as sendTime,e.sms_send_mode as smsSendMode from base_sms e"
      + " left join base_sms_template tpl on tpl.id = e.template_id where 1=1 and type=1";
    String countSql = "select count(1) from base_sms e"
      + " left join base_sms_template tpl on tpl.id = e.template_id where 1=1 and type=1";

    NativeSQLBuilder sqlBuilder = new NativeSQLBuilder();

    if(StringUtils.isNotBlank(keywords)){
      sqlBuilder.and().addWhere("e", "content", keywords, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if(StringUtils.isNotBlank(status)){
      sqlBuilder.and().addWhere("e", "status", status, ConditionEnum.OPERATE_EQUAL);
    }
    if(StringUtils.isNotBlank(startDate)){
      sqlBuilder.and().addWhere("e","create_time",startDate,ConditionEnum.OPERATE_GREATER_EQUAL,"startDate");
    }
    if(StringUtils.isNotBlank(endDate)){
      sqlBuilder.and().addWhere("e","create_time",endDate,ConditionEnum.OPERATE_LESS_EQUAL,"endDate");
    }
    sqlBuilder.bindQuerySql(querySql).orderBy("e.create_time desc");
    Query listQuery = setMapResult(sqlBuilder.build(entityManager));
    sqlBuilder.bindQuerySql(countSql);
    Query countQuery = sqlBuilder.build(entityManager);

    return pageByQuery(countQuery, listQuery, pageNum, pageSize);
  }

  @Override
  public DataPage querySmsUser(Map<String, String> params,Integer max) {
    int pageNum = Pages.Helper.pageNum(params.get("pageNum"));
    int pageSize = max ==null?Pages.Helper.pageSize(params.get("pageSize")):max;
    String batch = ConvertUtil.convert(params.get("batch"), "");
    String templateId = ConvertUtil.convert(params.get("templateId"), "");
    String region = ConvertUtil.convert(params.get("region"), "");
    Integer receiveCount = ConvertUtil.convert(params.get("receiveCount"),Integer.class);
    String queryFields = "select u.id,u.phone,u.user_nick_name as userNickName,u.last_login_time as lastLoginTime"
      + ",ifnull(t.sendNum,0) as sendNum,u.region_id from  base_user_base_info u ";

    String querySql = "select * from ("+queryFields+" left join (select phone,count(1) as sendNum from base_sms_send_record"
      + "  group by phone ) as t on t.phone = u.phone) as s where 1=1";
    String countSql = "select count(1) from ("+querySql+") as s where 1=1";

    if(StringUtils.isNotBlank(batch)||StringUtils.isNotBlank(templateId)){
      queryFields = "select u.id,u.phone,u.user_nick_name as userNickName,u.last_login_time as lastLoginTime"
        + ",ifnull(t.sendNum,0) as sendNum,u.region_id,t.template_id,t.batch from  base_user_base_info u ";
      querySql = "select * from ("+queryFields+" left join (select phone,count(1) as sendNum,template_id,batch from base_sms_send_record group by phone,template_id,batch ) as t on t.phone = u.phone) as s where 1=1";

      countSql = "select count(1) from ("+querySql+") as s where 1=1";
    }
    if(receiveCount!=null && receiveCount == 0){
      return queryNoReceiveSmsUser(params,max);
    }
    NativeSQLBuilder sqlBuilder = new NativeSQLBuilder();
    if(StringUtils.isNotBlank(batch)){
      sqlBuilder.and().addWhere("s","batch",batch,ConditionEnum.OPERATE_EQUAL);
    }
    if(StringUtils.isNotBlank(templateId)){
      sqlBuilder.and().addWhere("s","template_id",templateId,ConditionEnum.OPERATE_EQUAL);
    }
    if(receiveCount!=null){
      sqlBuilder.and().addWhere("s","sendNum",receiveCount,ConditionEnum.OPERATE_EQUAL);
    }
    if(StringUtils.isNotBlank(region)){
      sqlBuilder.and().addWhere("s","region_id",region,ConditionEnum.OPERATE_EQUAL);
    }
    sqlBuilder.bindQuerySql(querySql).orderBy(" s.lastLoginTime,s.sendNum,s.phone asc");
    Query listQuery = setMapResult(sqlBuilder.build(entityManager));
    sqlBuilder.bindQuerySql(countSql);
    Query countQuery = sqlBuilder.build(entityManager);
    return pageByQueryNoHelper(countQuery, listQuery, pageNum, pageSize);
  }

  private DataPage queryNoReceiveSmsUser(Map<String, String> params, Integer max) {
    int pageNum = Pages.Helper.pageNum(params.get("pageNum"));
    int pageSize = max ==null?Pages.Helper.pageSize(params.get("pageSize")):max;
    String templateId = ConvertUtil.convert(params.get("templateId"), "");
    String region = ConvertUtil.convert(params.get("region"), "");

    String queryFields = "select u.id,u.phone,u.user_nick_name as userNickName,u.last_login_time as lastLoginTime"
      + ",0 as sendNum,u.region_id from  base_user_base_info u ";

    String querySql = "select * from ("+queryFields+" where u.phone not in (select phone from base_sms_send_record)) as s where 1=1";
    String countSql = "select count(1) from ("+querySql+") as s where 1=1";

    NativeSQLBuilder sqlBuilder = new NativeSQLBuilder();
    if(StringUtils.isNotBlank(templateId)){
      querySql = "select * from ("+queryFields+" where u.phone not in (select phone from base_sms_send_record where template_id='"+templateId+"')) as s where 1=1";
    }
    if(StringUtils.isNotBlank(region)){
      sqlBuilder.and().addWhere("s","region_id",region,ConditionEnum.OPERATE_EQUAL);
    }
    sqlBuilder.bindQuerySql(querySql).orderBy(" s.lastLoginTime,s.sendNum,s.phone asc");
    Query listQuery = setMapResult(sqlBuilder.build(entityManager));
    sqlBuilder.bindQuerySql(countSql);
    Query countQuery = sqlBuilder.build(entityManager);
    return pageByQueryNoHelper(countQuery, listQuery, pageNum, pageSize);
  }
}
