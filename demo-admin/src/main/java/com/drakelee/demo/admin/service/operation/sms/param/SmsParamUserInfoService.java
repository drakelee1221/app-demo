package com.drakelee.demo.admin.service.operation.sms.param;

import com.drakelee.demo.admin.service.operation.sms.SmsUsuallyParamInterface;
import com.drakelee.demo.common.constants.sms.SmsTemplateUsuallyParam;
import com.drakelee.demo.common.constants.sys.Gender;
import com.drakelee.demo.common.domain.sys.SmsSendRecord;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.PasswordUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.user.UserBaseInfoDao;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户相关参数
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-06-25 11:52
 */
@Service
public class SmsParamUserInfoService implements SmsUsuallyParamInterface {
  @Autowired
  private UserBaseInfoDao baseInfoDao;
  @Override
  public Map<String, Object> loadParamValues(SmsSendRecord record, List<String> code,Map<String,Object> extraParam) {
    String userId = record.getUserId();
    UserBaseInfo user ;
    if(StringUtils.isBlank(userId)){
      ConditionGroup<UserBaseInfo> build = ConditionGroup.build()
        .addCondition("phone", ConditionEnum.OPERATE_EQUAL,record.getPhone());
      user = baseInfoDao.findOne(build).orElse(null);
    }else{
      user = baseInfoDao.getOne(userId);
    }
    if(user == null){
      return new HashMap<>();
    }
    Map<String, Object> paramMap = new HashMap<>(code.size());
    if(code.contains(SmsTemplateUsuallyParam.PASSWORD.getCode())){
      String password = PasswordUtil.decryptPassword(user.getPhone(), user.getPwd());
      paramMap.put(SmsTemplateUsuallyParam.PASSWORD.getCode(), password);
      code.remove(SmsTemplateUsuallyParam.PASSWORD.getCode());
    }
    if(code.contains(SmsTemplateUsuallyParam.GENDER.getCode())){
      Gender gender = EnumUtil.parse(Gender.class, "code", user.getGender());
      paramMap.put(SmsTemplateUsuallyParam.GENDER.getCode(), gender == null?"未知":gender.getDesc());
      code.remove(SmsTemplateUsuallyParam.GENDER.getCode());
    }
    for(String field:code){
      try {
        Method method = UserBaseInfo.class.getMethod("get" + field.substring(0, 1).toUpperCase() + field.substring(1));
        Object invoke = method.invoke(user);
        paramMap.put(field,invoke);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    return paramMap;
  }
}
