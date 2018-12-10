

package com.drakelee.demo.database.dao.sys.impl;

import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.database.dao.base.AbstractExtendDao;
import com.base.components.database.dao.base.NativeSQLBuilder;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.drakelee.demo.database.dao.sys.SysMessageExtendDao;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.Query;
import java.util.Map;

/**
 * SysMessageDaoImpl
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-19 16:33
 */
public class SysMessageDaoImpl extends AbstractExtendDao<Map<String,Object>> implements SysMessageExtendDao {

  @Override
  public DataPage<Map<String,Object>> findDetailPage(Map<String,String> searchParam){
    int pageNum = Pages.Helper.pageNum(searchParam.get("pageNum"));
    int pageSize = Pages.Helper.pageSize(searchParam.get("pageSize"));
    String userNickName = searchParam.get("userNickName");
    String phone = searchParam.get("phone");
    String status = searchParam.get("status");
    String userTypeId = searchParam.get("userTypeId");
    String content = searchParam.get("content");
    String sql = "SELECT me.id, me.content, me.create_time createTime, me.know_time knowTime, me.`status`,me.del_flag delFlag, ui.user_nick_name userNickName, ui.phone, ut.user_type_name userTypeName FROM base_sys_message me "
      + "LEFT JOIN base_user_base_info ui ON ui.id = me.user_id "
      + "LEFT JOIN base_user_base_type ut ON ut.id = ui.user_type_id WHERE 1=1 ";
    String countSql = "SELECT COUNT(1) FROM base_sys_message me "
      + "LEFT JOIN base_user_base_info ui ON ui.id = me.user_id "
      + "LEFT JOIN base_user_base_type ut ON ut.id = ui.user_type_id WHERE 1=1 ";
    NativeSQLBuilder builder = new NativeSQLBuilder();
    if(StringUtils.isNotBlank(userNickName)){
      builder.and().addWhere("ui", "user_nick_name", userNickName, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if(StringUtils.isNotBlank(phone)){
      builder.and().addWhere("ui", "phone", phone, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if(StringUtils.isNotBlank(status)){
      builder.and().addWhere("me", "status", status, ConditionEnum.OPERATE_EQUAL);
    }
    if(StringUtils.isNotBlank(userTypeId)){
      builder.and().addWhere("ui", "user_type_id", userTypeId, ConditionEnum.OPERATE_EQUAL);
    }
    if(StringUtils.isNotBlank(content)){
      builder.and().addWhere("me", "content", content, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    builder.bindQuerySql(sql).orderBy("me.create_time desc");
    Query listQuery = setMapResult(builder.build(entityManager));
    builder.bindQuerySql(countSql).orderBy("");
    Query countQuery = builder.build(entityManager);
    return pageByQuery(countQuery, listQuery, pageNum, pageSize);
  }
}
