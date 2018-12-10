package com.drakelee.demo.database.dao.user.impl;

import com.base.components.common.constants.Valid;
import com.base.components.common.constants.sys.Dates;
import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.CaseConvert;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.database.dao.base.AbstractExtendDao;
import com.base.components.database.dao.base.NativeSQLBuilder;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.drakelee.demo.common.constants.UserType;
import com.drakelee.demo.database.dao.user.UserBaseInfoExtendDao;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;

import javax.persistence.Query;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * UserBaseInfoDaoImpl
 *
 * @author <a href= " morse.jiang@foxmail.com " >JiangWen</a>
 * @version 1.0.0, 2018/3/21 0021 15:41
 */
@RefreshScope
public class UserBaseInfoDaoImpl extends AbstractExtendDao<Map> implements UserBaseInfoExtendDao {


  /**
   * 服务人员服务订单的上限
   */
  @Value("${base.servicer.service.limit:1000}")
  private int servicerServiceLimit;

  /**
   * 后台分页查询注册用户列表
   *
   * @param params
   *
   * @return
   */
  @Override
  public DataPage<Map> listPage(Map<String, String> params) {
    int pageNum = Pages.Helper.pageNum(params.get("pageNum"));
    int pageSize = Pages.Helper.pageSize(params.get("pageSize"));
    String userNickName = ConvertUtil.convertNullable(params.get("searchUserNickName"), String.class);
    String companyName = ConvertUtil.convertNullable(params.get("searchCompanyName"), String.class);
    String phone = ConvertUtil.convertNullable(params.get("searchPhone"), String.class);
    Integer status = ConvertUtil.convertNullable(params.get("searchStatus"), Integer.class);
    String regionId = ConvertUtil.convertNullable(params.get("regionId"), String.class);
    String hand = ConvertUtil.convertNullable(params.get("hand"), String.class);
    Integer dataSource = ConvertUtil.convertNullable(params.get("dataSource"), Integer.class);
    String sortName = params.get("sortName");
    DateTime registTimeStart = ConvertUtil
      .dateNullable(params.get("registTimeStart"), "注册开始时间", Dates.DATE_TIME_FORMATTER);
    DateTime registTimeEnd = ConvertUtil.dateNullable(params.get("registTimeEnd"), "注册截止时间", Dates.DATE_TIME_FORMATTER);
    if (registTimeEnd == null) {
      registTimeEnd = DateTime.now().millisOfDay().withMaximumValue();
    }
    String querySql = "select "
      + "a.id,a.avatar,a.wx_img as wxImg,a.wx_name as wxName,a.phone,a.user_nick_name as userNickName,b.name as "
      + "companyName,b.address,a.user_qq as userQq,a.status,a.regist_time as registTime "
      + ",a.regist_region as registRegion,a.last_login_time as lastLoginTime,a.data_source as dataSource from base_user_base_info a "
      + "left join base_user_company_info b " + "on a.id = b.user_id " + "where 1=1 ";
    String countSql = "select count(*) from base_user_base_info a " + "left join base_user_company_info b "
      + "on a.id = b.user_id " + "where 1=1 ";
    NativeSQLBuilder sqlBuilder = new NativeSQLBuilder();
    //拼接条件
    if (StringUtils.isNotEmpty(userNickName)) {
      sqlBuilder.and().addWhere("a", "user_nick_name", userNickName, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if (StringUtils.isNotEmpty(companyName)) {
      sqlBuilder.and().addWhere("b", "name", companyName, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if (StringUtils.isNotEmpty(phone)) {
      sqlBuilder.and().addWhere("a", "phone", phone, ConditionEnum.OPERATE_RIGHT_LIKE);
    }
    if (dataSource != null) {
      sqlBuilder.and().addWhere("a", "data_source", dataSource, ConditionEnum.OPERATE_EQUAL);
    }
    if (StringUtils.isNotBlank(regionId)) {
      if ("other".equals(regionId)) {
        sqlBuilder.and().addWhere("a", "region_id", null, ConditionEnum.OPERATE_IS_NULL);
      } else {
        String regionIds = params.get("regionIds");
        List<String> list = Lists.newArrayList();
        try {
          list = JsonUtils.reader(regionIds, List.class);
        } catch (IOException e) {
          e.printStackTrace();
        }
        sqlBuilder.and().addWhere("a", "region_id", list, ConditionEnum.OPERATE_IN);
      }
    }
    if (status != null) {
      if (Valid.parseVal(status) != null) {
        sqlBuilder.and().addWhere("a", "status", status, ConditionEnum.OPERATE_EQUAL);
      }
    }
    if (registTimeStart != null) {
      sqlBuilder.and().addWhere("a", "regist_time", registTimeStart.toDate(), ConditionEnum.OPERATE_GREATER_EQUAL,
                                "registTimeStart"
      );
    }
    if (StringUtils.isNotBlank(hand)) {
      sqlBuilder.and().addWhere("a", "remark", "CRM",
                                "0".equals(hand) ? ConditionEnum.OPERATE_UNEQUAL : ConditionEnum.OPERATE_EQUAL
      );
    }
    sqlBuilder.and()
              .addWhere("a", "regist_time", registTimeEnd.toDate(), ConditionEnum.OPERATE_LESS_EQUAL, "registTimeEnd");
    sqlBuilder.and().addWhere("a", "user_type", UserType.USER.getCode(), ConditionEnum.OPERATE_EQUAL);
    sqlBuilder.bindQuerySql(querySql);
    //超过90天的不排序
    if (registTimeStart != null && StringUtils.isNotBlank(sortName)) {
      Days days = Days.daysBetween(registTimeStart, registTimeEnd);
      if (days.getDays() <= 90) {
        sqlBuilder.orderBy(
          "a." + CaseConvert.toUnderline(sortName) + " " + Pages.Helper.sortDirection(params.get("sortOrder"))
                                                                       .toString());
      }
    }
    Query listQuery = setMapResult(sqlBuilder.build(entityManager));
    sqlBuilder.bindQuerySql(countSql).orderBy("");
    Query countQuery = sqlBuilder.build(entityManager);
    return pageByQuery(countQuery, listQuery, pageNum, pageSize);

  }


}
