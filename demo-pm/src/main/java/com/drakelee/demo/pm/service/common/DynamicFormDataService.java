package com.drakelee.demo.pm.service.common;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Lists;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.domain.admin.DynamicDataChild;
import com.drakelee.demo.common.domain.admin.DynamicFormData;
import com.base.components.common.exception.business.BusinessException;
import com.base.components.common.util.ConvertUtil;
import com.drakelee.demo.database.dao.admin.DynamicDataChildDao;
import com.drakelee.demo.database.dao.admin.DynamicDataCodeDao;
import com.drakelee.demo.database.dao.admin.DynamicFormDataDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * DynamicFormData Service
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-09
 */
@Service
public class DynamicFormDataService extends AbstractJpaService<DynamicFormData, String, DynamicFormDataDao> {

  @Autowired
  private DynamicDataChildDao dynamicDataChildDao;

  @Autowired
  private DynamicDataCodeDao dynamicDataCodeDao;

  /**
   * DynamicFormData新增和修改
   *
   * @param dynamicFormData
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public DynamicFormData saveOrUpdate(DynamicFormData dynamicFormData) {
    return getDao().saveAndFlush(dynamicFormData);
  }

  @Transactional(rollbackFor = Exception.class)
  public void save(Map<String, String> params, ObjectNode jsonData) {
    DynamicFormData dynamicFormData = ConvertUtil.populate(new DynamicFormData(), params);
    dynamicDataCodeDao.existsCode(dynamicFormData.getCode(), new Date()).orElseThrow(() -> new BusinessException("没有该活动！"));
    dynamicFormData.setCreateTime(new Date());
    DynamicFormData formData = getDao().save(dynamicFormData);
    ArrayNode arr = (ArrayNode) jsonData.get("arr");
    for (JsonNode jsonNode : arr) {
      List list = Lists.newArrayList();
      String name = jsonNode.get("name").textValue();
      ArrayNode data = (ArrayNode) jsonNode.get("data");
      for (JsonNode node : data) {
        DynamicDataChild child = new DynamicDataChild();
        child.setJsonData(node.toString());
        child.setRefId(formData.getId());
        child.setStatus(Valid.TRUE.getVal());
        child.setType(name);
        child.setCode(formData.getCode());
        list.add(child);
      }
      dynamicDataChildDao.saveAll(list);
    }
  }


}