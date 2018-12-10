package com.drakelee.demo.admin.service.sys;

import com.base.components.common.constants.sys.Dates;
import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.common.domain.msgqueue.SysMessageEvent;
import com.drakelee.demo.common.domain.msgqueue.SysMessageEventError;
import com.drakelee.demo.database.dao.msgqueue.SysMessageEventDao;
import com.drakelee.demo.database.dao.msgqueue.SysMessageEventErrorDao;
import com.drakelee.demo.database.dao.sys.SysMessageEventHandleDao;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * MessageEventService
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-05-23 14:45
 */
@Service
public class MessageEventService {
  @Autowired
  private SysMessageEventDao messageEventDao;
  @Autowired
  private SysMessageEventHandleDao sysMessageEventHandleDao;
  @Autowired
  private SysMessageEventErrorDao eventErrorDao;
  public DataPage queryMessageEvent(Map<String, String> params) {
    DateTime startDate = ConvertUtil.dateNullable(params.get("startDate"), "开始日期", Dates.DATE_FORMATTER);
    DateTime endDate = ConvertUtil.dateNullable(params.get("endDate"), "结束日期", Dates.DATE_FORMATTER);
    Integer hasDone = ConvertUtil.convert(params.get("hasDone"), Integer.class);
    String channel = ConvertUtil.convert(params.get("channel"), String.class);
    ConditionGroup<SysMessageEvent> build = ConditionGroup.build();
    if(startDate != null){
      build.addCondition("createTime", ConditionEnum.OPERATE_GREATER_EQUAL, startDate.toDate());
    }
    if(endDate != null){
      build.addCondition("createTime", ConditionEnum.OPERATE_LESS_EQUAL, endDate.toDate());
    }
    if(hasDone != null){
      build.addCondition("hasDone", ConditionEnum.OPERATE_EQUAL, hasDone);
    }
    if(StringUtils.isNotBlank(channel)){
      build.addCondition("channel", ConditionEnum.OPERATE_RIGHT_LIKE, channel);
    }
    Page<SysMessageEvent> pages = messageEventDao
      .findAll(build, Pages.Helper.pageable(params, Sort.by(Sort.Direction.DESC, "createTime")));
    return DataPage.from(pages);
  }

  public SysMessageEventError getErrorInfo(String messageId) {
    ConditionGroup<SysMessageEventError> build = ConditionGroup.build()
      .addCondition("messageId",ConditionEnum.OPERATE_EQUAL,messageId);
    return eventErrorDao.findOne(build).orElse(null);
  }

  public DataPage pageHandle(String eventId, Map<String, String> params) {
    return DataPage.from(sysMessageEventHandleDao.findAll(
      ConditionGroup.build().addCondition("eventId", ConditionEnum.OPERATE_EQUAL, eventId),
      Pages.Helper.pageable(params, null)
    ));
  }
}
