package com.drakelee.demo.pm.service.user;

import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.common.domain.user.UserCompanyInfo;
import com.base.components.common.util.JsonUtils;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.user.UserCompanyInfoDao;
import com.base.components.database.service.AbstractJpaService;
import com.drakelee.demo.pm.service.oss.QiniuOssService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Map;
import java.util.Optional;

/**
 * UserCompanyInfoService
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/16 0016 17:30
 */
@Service
public class UserCompanyInfoService extends AbstractJpaService<UserCompanyInfo, String, UserCompanyInfoDao> {

  @Autowired
  QiniuOssService qiniuOssService;

  /**
   * 完善企业信息
   *
   * @param userId
   * @param params -
   * <p>   name                     - Nullable  - Str - 企业名称
   * <p>   nature                   - Nullable  - Str - 企业性质
   * <p>   industry                 - Nullable  - Str - 行业
   * <p>   scale                    - Nullable  - Str - 规模
   * <p>   region                   - Nullable  - Str - 地址区域
   * <p>   address                  - Nullable  - Str - 地址
   * <p>   phone                    - Nullable  - Str - 电话
   * <p>   logo                     - Nullable  - Str - logo
   */
  @Transactional(rollbackFor = Exception.class)
  public void completeCompanyInfo(String userId, Map<String, String> params) {
    Assert.notNull(userId, "无用户信息");
    UserCompanyInfo userCompanyInfo = new UserCompanyInfo();
    userCompanyInfo.setUserId(userId);
    Example<UserCompanyInfo> example = Example.of(userCompanyInfo);
    Optional<UserCompanyInfo> optional = getDao().findOne(example);
    if (optional.isPresent()) {
      userCompanyInfo = optional.get();
    }
    String name = params.get("name");
    if (StringUtils.isNotEmpty(name)) {
      userCompanyInfo.setName(name);
    }
    String nature = params.get("nature");
    if (StringUtils.isNotEmpty(nature)) {
      userCompanyInfo.setNature(nature);
    }
    String industry = params.get("industry");
    if (StringUtils.isNotEmpty(industry)) {
      userCompanyInfo.setIndustry(industry);
    }
    String scale = params.get("scale");
    if (StringUtils.isNotEmpty(scale)) {
      userCompanyInfo.setScale(scale);
    }
    String region = params.get("region");
    if (StringUtils.isNotEmpty(region)) {
      userCompanyInfo.setRegion(region);
    }
    String regionName = params.get("regionName");
    if (StringUtils.isNotEmpty(regionName)) {
      userCompanyInfo.setRegionName(regionName);
    }
    String address = params.get("address");
    if (StringUtils.isNotEmpty(address)) {
      userCompanyInfo.setAddress(address);
    }
    String phone = params.get("phone");
    if (StringUtils.isNotEmpty(phone)) {
      userCompanyInfo.setPhone(phone);
    }
    String logo = params.get("logo");
    if (StringUtils.isNotEmpty(logo) && logo.indexOf("temp/") > 0) {
      //logo持久化
      ArrayNode arrayNode = JsonUtils.mapper.createArrayNode();
      ObjectNode objectNode = JsonUtils.mapper.createObjectNode();
      objectNode.put("name", userCompanyInfo.getName());
      objectNode.put("url", logo);
      arrayNode.add(objectNode);
      ArrayNode re = qiniuOssService.persistent("", "", arrayNode);
      if (re != null && re.size() != 0) {
        logo = re.get(0).get("url").asText();
      }
      userCompanyInfo.setLogo(logo);
    }

    getDao().saveAndFlush(userCompanyInfo);
  }


  /**
   * 根据userId查找企业信息
   *
   * @param userId 用户id
   *
   * @return
   */
  public UserCompanyInfo findByUserId(String userId) {
    Optional<UserCompanyInfo> optional = getDao()
      .findOne(ConditionGroup.build().addCondition("userId", ConditionEnum.OPERATE_EQUAL, userId));
    if (optional.isPresent()) {
      return optional.get();
    }
    return null;
  }

}
