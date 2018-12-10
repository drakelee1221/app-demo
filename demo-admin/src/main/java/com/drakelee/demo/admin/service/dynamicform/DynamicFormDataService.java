package com.drakelee.demo.admin.service.dynamicform;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.base.components.common.constants.Valid;
import com.base.components.common.constants.sys.Dates;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.admin.DynamicDataChild;
import com.drakelee.demo.common.domain.admin.DynamicDataCode;
import com.drakelee.demo.common.domain.admin.DynamicDataColumns;
import com.drakelee.demo.common.domain.admin.DynamicFormData;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.database.dao.admin.DynamicDataChildDao;
import com.drakelee.demo.database.dao.admin.DynamicDataCodeDao;
import com.drakelee.demo.database.dao.admin.DynamicDataColumnsDao;
import com.drakelee.demo.database.dao.admin.DynamicFormDataDao;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * DynamicFormData Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-09
 */
@Service
public class DynamicFormDataService extends AbstractJpaService<DynamicFormData, String, DynamicFormDataDao> {
  @Autowired
  private DynamicDataColumnsDao dynamicDataColumnsDao;

  @Autowired
  private DynamicDataChildDao dynamicDataChildDao;

  @Autowired
  private DynamicDataCodeDao dynamicDataCodeDao;

  public DataPage page(Map<String, String> params) {
    String code = params.get("code");
    String title = params.get("title");
    List<String> types = dynamicDataChildDao.groupTypeByCode(code);
    DataPage<Map> dataPage = getDao().page(code, title, params, types);
    List<Map> list = dataPage.getList();
    Optional<DynamicDataColumns> columns = dynamicDataColumnsDao
      .findOne(ConditionGroup.build().addCondition("code", ConditionEnum.OPERATE_EQUAL, code));
    DynamicDataColumns dataColumns = columns.orElseThrow(() -> new IllegalArgumentException("未找到数据结构！"));
    ArrayNode nodes;
    try {
      nodes = JsonUtils.reader(dataColumns.getJsonData(), ArrayNode.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("json数据异常");
    }
    List<Map> collect = list.stream().map(val -> {
      Map<String, Object> map = Maps.newHashMap();
      map.put("id", val.get("id"));
      map.put("title", val.get("title"));
      map.put("createTime", val.get("createTime"));
      // count统计放入map
      Set set = val.keySet();
      for (Object key : set) {
        if(key.toString().startsWith("count_")){
          map.put(key.toString(), val.get(key));
        }
      }
      try {
        ObjectNode data = JsonUtils.reader((String) val.get("jsonData"), ObjectNode.class);
        for (JsonNode column : nodes) {
          String field = column.get("field").textValue();
          map.put(field, data.get(field));
        }
      } catch (IOException e) {
        throw new IllegalArgumentException("json数据异常");
      }
      return map;
    }).collect(Collectors.toList());
    DataPage<Map> page = new DataPage<>();
    page.setList(collect);
    page.setPageSize(dataPage.getPageSize());
    page.setPages(dataPage.getPages());
    page.setPageNum(dataPage.getPageNum());
    page.setTotal(dataPage.getTotal());
    return page;
  }

  /**
   * DynamicFormData新增和修改
   *
   * @param dynamicFormData -
   *
   * @return -
   */
  @Transactional(rollbackFor = Exception.class)
  public DynamicFormData saveOrUpdate(DynamicFormData dynamicFormData) {
    return getDao().saveAndFlush(dynamicFormData);
  }

  public List<Map> listCode() {
    return dynamicDataCodeDao.listCode();
  }

  public ArrayNode columns(String code) {
    Optional<DynamicDataColumns> one = dynamicDataColumnsDao
      .findOne(ConditionGroup.build().addCondition("code", ConditionEnum.OPERATE_EQUAL, code));
    DynamicDataColumns dynamicDataColumns = one.orElseThrow(() -> new IllegalArgumentException("未找到对应的数据结构！"));
    ArrayNode result = JsonUtils.createArrayNode();
    try {
      result.add(JsonUtils.createObjectNode().put("field", "title").put("title", "标题"));
      ArrayNode reader = JsonUtils.reader(dynamicDataColumns.getJsonData(), ArrayNode.class);
      result.addAll(reader);
      result.add(JsonUtils.createObjectNode().put("field", "createTime").put("title", "创建时间"));
    } catch (IOException e) {
      throw new IllegalArgumentException("json数据异常");
    }
    return result;
  }

  public List<String> type(String code) {
    return dynamicDataChildDao.groupTypeByCode(code);
  }

  public List<Map> child(String id, String type) {
    List<DynamicDataChild> childs = dynamicDataChildDao.findAll(
      ConditionGroup.build().addCondition("refId", ConditionEnum.OPERATE_EQUAL, id)
                    .addCondition("type", ConditionEnum.OPERATE_EQUAL, type));
    List<Map> list = Lists.newArrayList();
    for (DynamicDataChild child : childs) {
      try {
        ObjectNode reader = JsonUtils.reader(child.getJsonData(), ObjectNode.class);
        Iterator<String> iterator = reader.fieldNames();
        Map<String, Object> map = Maps.newHashMap();
        while (iterator.hasNext()) {
          String key = iterator.next();
          map.put(key, reader.get(key).textValue());
        }
        map.put("id", child.getId());
        list.add(map);
      } catch (IOException e) {
        throw new IllegalArgumentException("json数据异常");
      }
    }
    return list;
  }

  public ArrayNode childColumns(String code, String type) {
    DynamicDataChild child = dynamicDataChildDao.findFirstByCodeAndType(code, type)
                                                .orElseThrow(() -> new IllegalArgumentException("为找到数据！"));
    ArrayNode arr = JsonUtils.mapper.createArrayNode();
    try {
      ObjectNode reader = JsonUtils.reader(child.getJsonData(), ObjectNode.class);
      Iterator<String> iterator = reader.fieldNames();
      while (iterator.hasNext()) {
        ObjectNode node = JsonUtils.mapper.createObjectNode();
        String key = iterator.next();
        node.put("field", key);
        node.put("title", key);
        arr.add(node);
      }
    } catch (IOException e) {
      throw new IllegalArgumentException("json数据异常");
    }
    return arr;
  }

  public DataPage pageCode(Map<String, String> params) {
    Page<Map> codes = dynamicDataCodeDao.pageCode(Pages.Helper.pageable(params, null));
    return DataPage.from(codes);
  }

  @Transactional(rollbackFor = Exception.class)
  public JsonResult saveOrUpdataCode(String id, String code, String title, String beginTime, String endTime, String remark) {
    if(StringUtils.isBlank(id)) {
      if (!exists(code)) {
        DynamicDataCode dataCode = new DynamicDataCode();
        dataCode.setId(id);
        dataCode.setCode(code);
        dataCode.setTitle(title);
        dataCode.setBeginTime(DateTime.parse(beginTime, Dates.DATE_TIME_FORMATTER).toDate());
        dataCode.setEndTime(DateTime.parse(endTime, Dates.DATE_TIME_FORMATTER).toDate());
        dataCode.setRemark(remark);
        dataCode.setStatus(Valid.TRUE.getVal());
        dynamicDataCodeDao.saveAndFlush(dataCode);
      } else {
        return JsonResult.fail("code已存在！");
      }
    } else {
      DynamicDataCode dataCode = dynamicDataCodeDao.findById(id)
                                                   .orElseThrow(() -> new IllegalArgumentException("未找到数据!"));
      dataCode.setTitle(title);
      dataCode.setBeginTime(DateTime.parse(beginTime, Dates.DATE_TIME_FORMATTER).toDate());
      dataCode.setEndTime(DateTime.parse(endTime, Dates.DATE_TIME_FORMATTER).toDate());
      dataCode.setRemark(remark);
    }
    return JsonResult.success();
  }

  private boolean exists(String code){
    DynamicDataCode example = new DynamicDataCode();
    example.setCode(code);
    return dynamicDataCodeDao.exists(Example.of(example));
  }

  public DataPage pageColumns(Map<String, String> params) {
    return DataPage.from(dynamicDataColumnsDao.findAll(Pages.Helper.pageable(params, null)));
  }

  @Transactional(rollbackFor = Exception.class)
  public JsonResult saveOrUpdataColumns(String id, String code, String jsonData) {
    if(StringUtils.isBlank(id)){
      if (exists(code)) {
        DynamicDataColumns columns = new DynamicDataColumns();
        columns.setCode(code);
        columns.setJsonData(jsonData);
        columns.setStatus(Valid.TRUE.getVal());
        dynamicDataColumnsDao.save(columns);
      } else {
        return JsonResult.fail("未找到表单编号！");
      }
    } else {
      DynamicDataColumns columns = dynamicDataColumnsDao.findById(id)
                                                        .orElseThrow(() -> new IllegalArgumentException("未找到数据！"));
      columns.setJsonData(jsonData);
      dynamicDataColumnsDao.save(columns);
    }
    return JsonResult.success();
  }
}