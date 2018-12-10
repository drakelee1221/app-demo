package com.drakelee.demo.admin.service.operation.sms;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.domain.sys.SmsTemplate;
import com.drakelee.demo.common.domain.sys.SmsTemplateParam;
import com.base.components.common.util.ConvertUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.sys.SmsTemplateDao;
import com.drakelee.demo.database.dao.sys.SmsTemplateParamDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * SmsTemplate Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-09
 */
@RefreshScope
@ConfigurationProperties("base.admin.sms.template")
@Service
public class SmsTemplateService extends AbstractJpaService<SmsTemplate, String, SmsTemplateDao> {
  @Autowired
  private SmsTemplateParamDao smsTemplateParamDao;

  @Autowired
  private SmsTemplateParamDao paramDao;

  private List<String> type = Lists.newArrayList();


  /**
   * SmsTemplate新增和修改
   *
   * @param params
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public SmsTemplate saveOrUpdate(Map<String, String> params) {
    SmsTemplate smsTemplate = ConvertUtil.populate(new SmsTemplate(), params);
    if (StringUtils.isEmpty(smsTemplate.getId())) {
      smsTemplate.setCreateTime(new Date());
    } else {
      Optional<SmsTemplate> op = getDao().findById(smsTemplate.getId());
      Assert.isTrue(op.isPresent(), "未查到模板信息");
      smsTemplate.setCreateTime(op.get().getCreateTime());
      //删除参数信息
      List<SmsTemplateParam> list = smsTemplateParamDao
        .findAll(ConditionGroup.build().addCondition("templateId", ConditionEnum.OPERATE_EQUAL, op.get().getId()));
      smsTemplateParamDao.deleteInBatch(list);
    }
    smsTemplate = getDao().saveAndFlush(smsTemplate);
    String paramArrayStr = params.get("paramArray");
    JSONArray array = JSON.parseArray(paramArrayStr);
    List<SmsTemplateParam> list = Lists.newArrayList();
    if (array != null && array.size() != 0) {
      int n = array.size();
      for (int i = 0; i < n; i++) {
        JSONObject o = (JSONObject) array.get(i);
        SmsTemplateParam smsTemplateParam = new SmsTemplateParam();
        smsTemplateParam.setTemplateId(smsTemplate.getId());
        smsTemplateParam.setParamCode(o.getString("paramCode"));
        smsTemplateParam.setParamName(o.getString("paramName"));
        smsTemplateParam.setType(o.getInteger("type"));
        smsTemplateParam.setSysParamType(o.getString("sysParamType"));
        list.add(smsTemplateParam);
      }
      smsTemplateParamDao.saveAll(list);
    }

    return smsTemplate;
  }

  /**
   * SmsTemplate删除
   *
   * @param ids
   */
  @Transactional(rollbackFor = Exception.class)
  public void delete(Iterable<String> ids) {
    List<SmsTemplate> list = getDao().findAllById(ids);
    if (!CollectionUtils.isEmpty(list)) {
      getDao().deleteInBatch(list);
    }
  }

  /**
   * 查询开启的短信模板
   *
   * @return
   */
  public List<Map<String, Object>> queryOpenSmsTemplate() {
    ConditionGroup<SmsTemplate> build = ConditionGroup.build().addCondition("status", ConditionEnum.OPERATE_EQUAL,
                                                                            Valid.TRUE.getVal()
    );
    List<SmsTemplate> templates = getDao().findAll(build);
    if (templates.size() == 0) {
      return new ArrayList<>();
    }
    //获取自定义参数
    List<String> tplIds = templates.stream().map(SmsTemplate::getId).collect(Collectors.toList());
    ConditionGroup<SmsTemplateParam> paramConditionGroup = ConditionGroup.build().addCondition("templateId",
                                                                                               ConditionEnum.OPERATE_IN,
                                                                                               new ArrayList<>(tplIds)
    ).addCondition("type", ConditionEnum.OPERATE_EQUAL, Valid.TRUE.getVal());
    List<SmsTemplateParam> params = paramDao.findAll(paramConditionGroup);
    //组装返回结果
    Map<String, Collection<SmsTemplateParam>> paramMap = ConvertUtil
      .transformMultiMap(params, SmsTemplateParam::getTemplateId).asMap();

    List<Map<String, Object>> resultList = new LinkedList<>();
    templates.forEach(smsTemplate -> {
      Map<String, Object> t = new HashMap<>(4);
      t.put("templateId", smsTemplate.getId());
      t.put("content", smsTemplate.getContent());
      t.put("title", smsTemplate.getTplName());

      Collection<SmsTemplateParam> smsTemplateParams = paramMap.get(smsTemplate.getId());
      if (smsTemplateParams != null) {
        List<String> codes = smsTemplateParams.stream().map(SmsTemplateParam::getParamCode)
                                              .collect(Collectors.toList());
        t.put("params", StringUtils.join(codes, ","));
      }
      resultList.add(t);
    });
    return resultList;
  }

  public List<String> getTemplateTypes() {
    return type;
  }

  public void setType(List<String> type) {
    this.type = type;
  }
}