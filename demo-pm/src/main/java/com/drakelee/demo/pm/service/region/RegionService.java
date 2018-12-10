package com.drakelee.demo.pm.service.region;

import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.drakelee.demo.common.domain.sys.Region;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.sys.RegionDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * RegionService
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/30 0030 16:23
 */
@Service
public class RegionService extends AbstractJpaService<Region, String, RegionDao> {

  /**
   * 根据parentId查询地区列表
   *
   * @param parentId
   *
   * @return
   */
  public List<Region> getRegionByParentId(String parentId) {
    List<Region> list = new ArrayList<>();
    if (StringUtils.isNotEmpty(parentId)) {
      list = getDao().findByParentId(parentId);
    } else {
      list = getDao().findRoots();
    }
    return list;
  }


  /**
   * 获取全部地区树-三级
   *
   * @return
   */
  public ArrayNode getRegionTree() {
    //一级
    List<Region> list1 = getDao().findRoots();
    ArrayNode arr1 = JsonUtils.createArrayNode();
    list1.forEach(region1 -> {
      ObjectNode objectNode1 = JsonUtils.createObjectNode();
      objectNode1.put("id", region1.getId());
      objectNode1.put("name", region1.getName());
      //二级
      List<Region> list2 = getDao().findByParentId(region1.getId());
      ArrayNode arr2 = JsonUtils.createArrayNode();
      list2.forEach(region2 -> {
        ObjectNode objectNode2 = JsonUtils.createObjectNode();
        objectNode2.put("id", region2.getId());
        objectNode2.put("name", region2.getName());
        //三级
        List<Region> list3 = getDao().findByParentId(region2.getId());
        ArrayNode arr3 = JsonUtils.createArrayNode();
        list3.forEach(region3 -> {
          ObjectNode objectNode3 = JsonUtils.createObjectNode();
          objectNode3.put("id", region3.getId());
          objectNode3.put("name", region3.getName());
          arr3.addPOJO(objectNode3);
        });
        objectNode2.putPOJO("district", arr3);
        arr2.addPOJO(objectNode2);
      });
      objectNode1.putPOJO("city", arr2);
      arr1.addPOJO(objectNode1);
    });
    return arr1;
  }


  public String getRegionId(String[] address) {
    String queryAddress = "";
    for (int i = address.length - 1; i >= 0; i--) {
      if (StringUtils.isNotBlank(address[i])) {
        queryAddress = address[i];
        break;
      }
    }
    ConditionGroup<Region> build = ConditionGroup.build()
                                                 .addCondition("name", ConditionEnum.OPERATE_RIGHT_LIKE, queryAddress);
    List<Region> regions = getDao().findAll(build, Sort.by(Sort.Direction.DESC, "orderNo"));
    if (regions.size() > 0) {
      return regions.get(0).getId();
    }
    return null;
  }

  public List<List<Map<String, Object>>> fingSelected(String regionId) {
    List<Region> selectedList = getDao().findParentsAndSelf(regionId);
    List<List<Map<String, Object>>> list = Lists.newArrayList();
    for (Region region : selectedList) {
      list.add(getDao().findSelected(region.getParentId(), region.getId()));
    }
    return list;
  }



  /**
   * 通过地区名称获取regionId
   *
   * @param params
   *
   * @return
   */
  public Map<String, String> getRegionIdByName(Map<String, String> params) {
    String province = ConvertUtil.checkNotNull(params, "province", "省名称为空", String.class).trim();
    String city = ConvertUtil.checkNotNull(params, "city", "市名称为空", String.class).trim();
    String district = ConvertUtil.checkNotNull(params, "district", "区称为空", String.class).trim();
    if(province.lastIndexOf("省")==province.length()-1){
      province = province.substring(0,province.lastIndexOf("省"));
    }
    if(province.lastIndexOf("市")==province.length()-1){
      province = province.substring(0,province.lastIndexOf("市"));
    }
    if(province.lastIndexOf("区")==province.length()-1){
      province = province.substring(0,province.lastIndexOf("区"));
    }
    if(city.lastIndexOf("省")==city.length()-1){
      city = city.substring(0,city.lastIndexOf("省"));
    }
    if(city.lastIndexOf("市")==city.length()-1){
      city = city.substring(0,city.lastIndexOf("市"));
    }
    if(city.lastIndexOf("区")==city.length()-1){
      city = city.substring(0,city.lastIndexOf("区"));
    }
    if(district.lastIndexOf("省")==district.length()-1){
      district = district.substring(0,district.lastIndexOf("省"));
    }
    if(district.lastIndexOf("市")==district.length()-1){
      district = district.substring(0,district.lastIndexOf("市"));
    }
    if(district.lastIndexOf("区")==district.length()-1){
      district = district.substring(0,district.lastIndexOf("区"));
    }
    String namePath = province.trim() + "-" + city.trim() + "-" + district.trim();
    List<Region> regions = getDao()
      .findAll(ConditionGroup.build().addCondition("namePath", ConditionEnum.OPERATE_RIGHT_LIKE, namePath));
    Map<String,String> res = Maps.newHashMap();
    if (regions != null && regions.size() > 0) {
      res.put("regionId",regions.get(0).getId());
      res.put("regionName",regions.get(0).getName());
      res.put("namePath",regions.get(0).getNamePath());
    }
    return res;
  }

}
