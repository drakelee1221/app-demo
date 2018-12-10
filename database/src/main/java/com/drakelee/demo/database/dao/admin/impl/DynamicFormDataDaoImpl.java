package com.drakelee.demo.database.dao.admin.impl;

import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.SqlLikeHelper;
import com.drakelee.demo.database.dao.admin.DynamicFormDataExtendDao;
import com.drakelee.demo.database.dao.admin.DynamicFormDataExtendDao;
import com.base.components.database.dao.base.AbstractExtendDao;
import com.base.components.database.dao.base.NativeSQLBuilder;
import com.base.components.database.dao.base.condition.ConditionEnum;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.Query;
import java.util.List;
import java.util.Map;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/6/19 0019 13:57
 */
public class DynamicFormDataDaoImpl extends AbstractExtendDao<Map> implements DynamicFormDataExtendDao {

  @Override
  public DataPage<Map> page(String code, String title, Map<String, String> params, List<String> types) {
    int pageNum = Pages.Helper.pageNum(params.get("pageNum"));
    int pageSize = Pages.Helper.pageSize(params.get("pageSize"));
    String colm = "";
    String maxCol = "";
    for (String type : types) {
      colm += ",ifnull(ch.`" + type + "`,0) `count_"+type+"`";
      maxCol += " ,MAX( CASE t.type WHEN '"+type+"' THEN t.count ELSE 0 END ) '"+type+"'";
    }
    String querySql = "SELECT d.id, d.`code`, d.title, d.json_data jsonData,d.create_time createTime"
      + colm
      + " FROM  base_dynamic_form_data d left join  ( SELECT t.ref_id"
      + maxCol
      + " FROM ( SELECT c.ref_id,c.type, count( 1 ) count FROM base_dynamic_data_child c  GROUP BY c.ref_id,c.type ) t  "
      + " GROUP BY  t.ref_id) ch  ON d.id=ch.ref_id WHERE  1 = 1";
    String countSql = "select count(1) from base_dynamic_form_data d where 1=1";

    NativeSQLBuilder nativeSQLBuilder = new NativeSQLBuilder();
    nativeSQLBuilder.and().addWhere("d", "code", StringUtils.isBlank(code) ? "" : code, ConditionEnum.OPERATE_EQUAL);
    if (StringUtils.isNotBlank(title)) {
      nativeSQLBuilder.and().addWhere("d", "title", SqlLikeHelper.right(title), ConditionEnum.OPERATE_RIGHT_LIKE);
    }

    params.remove("code");
    params.remove("title");
    params.remove("pageNum");
    params.remove("pageSize");

    params.forEach((key, val) -> {
      if (StringUtils.isNotBlank(val)) {
        nativeSQLBuilder.and()
                        .addWhere("d", "json_data->'$." + key + "'", val, ConditionEnum.OPERATE_EQUAL, "json_" + key);
      }
    });

    nativeSQLBuilder.bindQuerySql(querySql).orderBy(" d.create_time desc");
    Query listQuery = setMapResult(nativeSQLBuilder.build(entityManager));
    nativeSQLBuilder.bindQuerySql(countSql);
    Query countQuery = nativeSQLBuilder.build(entityManager);
    return pageByQuery(countQuery, listQuery, pageNum, pageSize);
  }
}
