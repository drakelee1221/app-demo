package com.drakelee.demo.admin.service.operation.sms;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.constants.sms.SmsSendStatus;
import com.drakelee.demo.common.constants.sms.SmsStatus;
import com.drakelee.demo.common.constants.sms.SmsType;
import com.drakelee.demo.common.domain.sys.Mailbox;
import com.drakelee.demo.common.domain.sys.Sms;
import com.drakelee.demo.common.domain.sys.SmsSendRecord;
import com.drakelee.demo.common.domain.sys.SmsTemplate;
import com.drakelee.demo.common.domain.sys.SmsTemplateParam;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.base.components.common.dto.page.DataPage;
import com.drakelee.demo.common.service.sms.SmsService;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.sys.MailboxDao;
import com.drakelee.demo.database.dao.sys.SmsDao;
import com.drakelee.demo.database.dao.sys.SmsSendRecordDao;
import com.drakelee.demo.database.dao.sys.SmsTemplateDao;
import com.drakelee.demo.database.dao.sys.SmsTemplateParamDao;
import com.drakelee.demo.database.dao.user.UserBaseInfoDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * MailService
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-02 16:17
 */
@Service
public class SysSmsService extends AbstractJpaService<Sms, String, SmsDao> {
  @Autowired
  private MailboxDao mailboxDao;
  @Autowired
  private SmsService smsService;
  @Autowired
  private UserBaseInfoDao baseInfoDao;
  @Autowired
  private SmsSendRecordDao recordDao;
  @Autowired
  private SmsTemplateParamDao templateParamDao;
  @Autowired
  private SmsTemplateDao templateDao;
  @Autowired
  private SmsUsuallyParamService paramService;
  @Value("${base.admin.sms.send.max:1000}")
  private Integer maxSend;

  public DataPage querySysSms(Map<String, String> params) {
    return getDao().querySysSms(params);
  }

  /**
   * 保存短信
   *
   * @param userId 用户id
   * @param params <p>  id                      - Notnull   - Str - desc
   * <p>  content                      - Notnull   - Str - desc
   * <p>  users                      - Notnull   - Str - desc
   * <p>  remark                      - Notnull   - Str - desc
   * <p>  editorValue                      - Notnull   - Str - desc
   */
  @Transactional(rollbackFor = Exception.class)
  public String saveSysSms(String userId, Map<String, String> params, List<String> receive) {
    ConvertUtil.checkNotNull(params, "templateId", "模板不能为空", String.class);
    String id = ConvertUtil.convert(params.get("id"), "");
    Sms sms;
    if (StringUtils.isBlank(id)) {
      sms = new Sms();
      sms.setCreateTime(new Date());
      sms.setStatus(Valid.FALSE.getVal());
    } else {
      Optional<Sms> emailOptional = getDao().findById(id);
      Assert.isTrue(emailOptional.isPresent(), "sms is not present");
      sms = emailOptional.get();
      Assert.isTrue(sms.getStatus().equals(SmsStatus.UN_SEND.getVal()), "只能修改处于未发送状态的数据");
      ConditionGroup<SmsSendRecord> build = ConditionGroup.build()
                                                          .addCondition("smsId", ConditionEnum.OPERATE_EQUAL, id);
      List<SmsSendRecord> records = recordDao.findAll(build);
      if (records.size() > 0) {
        recordDao.deleteInBatch(records);
      }
    }
    sms.setAuthorId(userId);
    sms.setRemarks(params.get("remarks"));
    sms.setType(SmsType.ADMINSMS.getVal());
    sms.setTemplateId(params.get("templateId"));
    sms.setBatch(params.get("batch"));
    sms.setParamJson(params.get("paramJson"));
    sms.setSmsChannel(Integer.valueOf(params.get("smsChannel")));
    String filter = params.get("filter");
    ObjectNode filterObj;
    //如果没有过滤条件，保存时默认加上批次号和模板
    if(StringUtils.isNotBlank(filter)){
      try {
        filterObj = JsonUtils.reader(filter,ObjectNode.class);
        if(!filterObj.has("batch") || StringUtils.isBlank(filterObj.get("batch").asText())){
          filterObj.put("batch",sms.getBatch());
        }
        if(!filterObj.has("templateId") || StringUtils.isBlank(filterObj.get("templateId").asText())){
          filterObj.put("templateId",sms.getTemplateId());
        }
        filter = filterObj.toString();
      } catch (IOException e) {
        e.printStackTrace();
      }

    }
    sms.setUserFilter(filter);
    Integer smsSendMode = Integer.valueOf(params.get("smsSendMode"));
    sms.setSmsSendMode(smsSendMode);
    getDao().saveAndFlush(sms);

    List<SmsTemplate> templates = templateDao.findAll();
    Map<String, SmsTemplate> templateMap = ConvertUtil.transformMap(templates, SmsTemplate::getId);
    List<SmsSendRecord> records = new ArrayList<>();
    if (smsSendMode.equals(Valid.FALSE.getVal())) {
      //用户id
      ConditionGroup<UserBaseInfo> build = ConditionGroup.build().addCondition("id", ConditionEnum.OPERATE_IN,
                                                                               (Serializable) receive
      ).addCondition("status", ConditionEnum.OPERATE_EQUAL, Valid.TRUE.getVal());
      List<UserBaseInfo> user = baseInfoDao.findAll(build);
      user.forEach(userBaseInfo -> {
        SmsSendRecord smsSendRecord = new SmsSendRecord();
        smsSendRecord.setBatch(sms.getBatch());
        smsSendRecord.setCreateTime(new Date());
        smsSendRecord.setPhone(userBaseInfo.getPhone());
        smsSendRecord.setStatus(Valid.FALSE.getVal());
        smsSendRecord.setSmsId(sms.getId());
        smsSendRecord.setTemplateId(sms.getTemplateId());
        smsSendRecord.setTemplateName(templateMap.get(sms.getTemplateId()).getTplName());
        smsSendRecord.setUserId(userBaseInfo.getId());
        smsSendRecord.setUserName(userBaseInfo.getUserNickName());
        records.add(smsSendRecord);
      });
    } else {
      for (String s : receive) {
        SmsSendRecord smsSendRecord = new SmsSendRecord();
        smsSendRecord.setBatch(sms.getBatch());
        smsSendRecord.setCreateTime(new Date());
        smsSendRecord.setPhone(s);
        smsSendRecord.setStatus(Valid.FALSE.getVal());
        smsSendRecord.setSmsId(sms.getId());
        smsSendRecord.setTemplateId(sms.getTemplateId());
        smsSendRecord.setTemplateName(templateMap.get(sms.getTemplateId()).getTplName());
        records.add(smsSendRecord);
      }
    }
    recordDao.saveAll(records);
    return sms.getId();
  }

  public Mailbox getMailServer() {
    List<Mailbox> all = mailboxDao.findAll();
    return all.size() > 0 ? all.get(0) : null;
  }

  @SuppressWarnings("unchecked")
  @Transactional(rollbackFor = Exception.class)
  public void sendSms(String id) {
    Sms sms = getDao().findById(id).orElse(null);
    if (sms == null) {
      return;
    }
    Assert.isTrue(!sms.getStatus().equals(SmsStatus.COMPLETE.getVal()), "该批次短信已发送完成，不能再次发送");
    SmsTemplate template = templateDao.getOne(sms.getTemplateId());
    //获取系统参数
    ConditionGroup<SmsTemplateParam> sysParamCondition = ConditionGroup.build().addCondition("templateId",
                                                                                             ConditionEnum.OPERATE_EQUAL,
                                                                                             template.getId()
    ).addCondition("type", ConditionEnum.OPERATE_EQUAL, Valid.FALSE.getVal());
    List<SmsTemplateParam> sysParam = templateParamDao.findAll(sysParamCondition);
    //自定义参数值
    Map params = new HashMap();
    ConditionGroup<SmsSendRecord> build = ConditionGroup.build()
                                                        .addCondition("smsId", ConditionEnum.OPERATE_EQUAL, sms.getId())
                                                        .addCondition("status", ConditionEnum.OPERATE_UNEQUAL,
                                                                      SmsSendStatus.UN_SEND.getVal()
                                                        );
    List<SmsSendRecord> records = recordDao.findAll(build);
    Map<String, Collection<SmsTemplateParam>> sysParamMap = new HashMap<>();
    if (sysParam.size() > 0) {
      sysParamMap = ConvertUtil.transformMultiMap(sysParam, SmsTemplateParam::getSysParamType).asMap();
    }
    Map<String, Collection<SmsTemplateParam>> finalSysParamMap = sysParamMap;
    records.forEach(smsSendRecord -> {
      finalSysParamMap.forEach((s, smsTemplateParams) -> {
        List<String> codes = smsTemplateParams.stream().map(SmsTemplateParam::getParamCode)
                                              .collect(Collectors.toList());
        Map sParam = paramService.execute(smsSendRecord, s, codes, null);
        if (sParam != null) {
          params.putAll(sParam);
        }
      });

      if (StringUtils.isNotBlank(sms.getParamJson())) {
        try {
          params.putAll(JsonUtils.reader(sms.getParamJson(), Map.class));
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
      try {
        boolean b = smsService.sendSmsSync(smsSendRecord.getPhone(), "", template.getAliSmsId(), params);
        if (b) {
          smsSendRecord.setStatus(SmsSendStatus.SEND.getVal());
        } else {
          smsSendRecord.setStatus(SmsSendStatus.SEND_FAIL.getVal());
        }
      } catch (Exception e) {
        e.printStackTrace();
        smsSendRecord.setStatus(SmsSendStatus.SEND_FAIL.getVal());
        smsSendRecord.setRemarks(e.getMessage());
      }
      smsSendRecord.setSendTime(new Date());
      recordDao.saveAndFlush(smsSendRecord);
    });
    //统计发送记录状态
    long unSend = recordDao.countUnSendRecord(sms.getId());
    ConditionGroup<SmsSendRecord> countCondition = ConditionGroup.build()
                                                                 .addCondition("smsId", ConditionEnum.OPERATE_EQUAL,
                                                                               sms.getId()
                                                                 );
    long count = recordDao.count(countCondition);
    if (unSend == 0) {
      sms.setStatus(SmsStatus.COMPLETE.getVal());
    } else if (unSend > 0 && unSend <= count) {
      sms.setStatus(SmsStatus.UN_COMPLETE.getVal());
    }
    sms.setSendTime(new Date());
    getDao().saveAndFlush(sms);
  }

  public DataPage querySmsUser(Map<String, String> params) {
    return getDao().querySmsUser(params, null);
  }

  public String saveFilterSms(String userId, Map<String, String> params) throws IOException {
    Integer smsSendMode = Integer.valueOf(params.get("smsSendMode"));
    List<String> receiveIds;
    if (smsSendMode.equals(Valid.FALSE.getVal())) {
      String filter = params.get("filter");
      Map filterMap = JsonUtils.reader(filter, Map.class);
      DataPage<Map<String, Object>> dataPage = getDao().querySmsUser(filterMap, maxSend);

      List<Map<String, Object>> list = dataPage.getList();
      receiveIds = list.stream().map(userMap -> userMap.get("id").toString()).collect(Collectors.toList());
    } else {
      String phones = params.get("phones");
      Assert.hasText(phones, "电话号码不能为空");
      String[] receivePhones = StringUtils.split(phones, "\n");
      receiveIds = Arrays.asList(receivePhones);
    }
    return saveSysSms(userId, params, receiveIds);

  }

  @Transactional(rollbackFor = Exception.class)
  public void deleteSms(String smsId) {
    getDao().deleteById(smsId);
    recordDao.deleteRecords(smsId);
  }
}
