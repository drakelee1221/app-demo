package com.drakelee.demo.admin.service.region;

import com.base.components.common.constants.Valid;
import com.base.components.common.util.NestedSetModel;
import com.base.components.common.util.Relationship;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.base.components.database.service.AbstractJpaService;
import com.codingapi.tx.annotation.TxTransaction;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.common.constants.UserType;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.common.dto.sys.RegionCountDto;
import com.drakelee.demo.database.dao.admin.SysMemberAttrDao;
import com.drakelee.demo.database.dao.sys.RegionDao;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

/**
 * RegionService
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/22 0022 16:32
 */
@Service
public class RegionService extends AbstractJpaService<Region, String, RegionDao> {

  @Autowired
  private SysMemberAttrDao sysMemberAttrDao;

  public List<TreeNodeData<Region>> loadTreeNodes(TreeParam treeParam) {
    return loadTreeNodes(treeParam, CountType.NONE);
  }

  public List<TreeNodeData<Region>> loadTreeNodes(TreeParam treeParam, CountType countType) {
    List<TreeNodeData<Region>> nodes = Lists.newArrayList();
    boolean isRoot = true;
    if (StringUtils.isNotBlank(treeParam.getNodeId()) || treeParam.getRoots().length > 0) {
      isRoot = false;
    }
    addNodes(nodes, isRoot, treeParam, countType);
    return nodes;
  }

  /**
   * 修改
   *
   * @param region
   *
   * @return
   *
   * @throws IllegalArgumentException
   */
  @TxTransaction(rollbackFor = Exception.class)
  public Region updateBaseInfo(Region region) {
    Assert.isTrue(region != null && StringUtils.isNotBlank(region.getId()), "未找到帐号信息！");
    Region exists = findById(region.getId());
    Assert.notNull(exists, "未找到帐号信息！");
    region.setCreateTime(exists.getCreateTime());
    region.setNamePath(exists.getNamePath());
    region.setLeaf(exists.getLeaf());
    region.setLeftVal(exists.getLeftVal());
    region.setRightVal(exists.getRightVal());
    Assert.notNull(region.getOrderNo(), "修改排序号必填！");
    if (!region.getOrderNo().equals(exists.getOrderNo())) {
      region = updateOrderNo(region);
    }
    region = getDao().saveAndFlush(region);
    if (region.getStatus() == Valid.FALSE.getVal()) {
      List<Region> regions = treeForId(region.getId(), null);
      for (Region item : regions) {
        item.setStatus(Valid.FALSE.getVal());
      }
      getDao().saveAll(regions);
    } else {
      if (StringUtils.isNotEmpty(region.getParentId())) {
        List<Region> regions = listForParent(region.getParentId(), null);
        for (Region item : regions) {
          item.setStatus(Valid.TRUE.getVal());
        }
        getDao().saveAll(regions);
      }
    }
    return region;
  }

  /**
   * 新增
   *
   * @param region
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public Region addRegion(Region region) {
    if (StringUtils.isNotEmpty(region.getParentId())) {
      Region parent = findById(region.getParentId());
      parent.setLeaf(Valid.FALSE.getVal());
      Assert.notNull(parent, "未找到父节点！");
      getDao().saveAndFlush(parent);
      String namePath = parent.getNamePath() + "-" + region.getName();
      region.setNamePath(namePath);
      region.setCreateTime(new Date());
      region.setLeaf(Valid.TRUE.getVal());
      int[] val = NestedSetModel.insert(parent.getLeftVal(), parent.getRightVal(), Relationship.ChildLast);
      getEntityManager().createQuery(
        "update Region m set m.leftVal = m.leftVal + 2 WHERE  m.leftVal > :leftVal")
                        .setParameter("leftVal", val[0]).executeUpdate();
      getEntityManager().createQuery(
        "update Region m set m.rightVal = m.rightVal + 2 WHERE  m.rightVal > :rightVal")
                        .setParameter("rightVal", val[0]).executeUpdate();
      region.setLeftVal(val[1]);
      region.setRightVal(val[1] + 1);
    } else {
      region.setNamePath(region.getName());
      region.setCreateTime(new Date());
      region.setLeaf(Valid.TRUE.getVal());
    }


    region = updateOrderNo(region);
    region = getDao().saveAndFlush(region);
    return region;
  }


  /**
   * 更新排序号
   *
   * @param region
   */
  public Region updateOrderNo(Region region) {
    List<Region> regions;
    if (StringUtils.isEmpty(region.getParentId())) {
      regions = getDao().findRoots();
    } else {
      regions = getDao().findByParentId(region.getParentId());
    }
    if (region.getOrderNo() != null && region.getOrderNo() != 0) {
      for (Region item : regions) {
        if (item.getOrderNo() >= region.getOrderNo()) {
          item.setOrderNo(item.getOrderNo() + 1);
        }
      }
      getDao().saveAll(regions);
    } else {
      int i = 0;
      for (Region item : regions) {
        if (item.getOrderNo() > i) {
          i = item.getOrderNo();
        }
      }
      region.setOrderNo(i + 1);
    }
    return region;
  }

  /**
   * 删除
   *
   * @param id
   */
  @Transactional(rollbackFor = Exception.class)
  public void delete(String id) {
    Assert.notNull(id, "id 不能为空");
    Region region = getDao().findById(id).orElseThrow(() -> new IllegalArgumentException("未找到地区"));
    Assert.isTrue(region.getLeftVal() > 1, "can not delete root member !");
    int[] val = NestedSetModel.delete(region.getLeftVal(), region.getRightVal());
    getEntityManager().createQuery(
      "delete from Region m WHERE  m.leftVal >= :leftVal and m.rightVal <= :rightVal")
                      .setParameter("leftVal", val[0])
                      .setParameter("rightVal", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "update Region m set m.leftVal = m.leftVal - :VAL1  WHERE  m.leftVal > :VAL2")
                      .setParameter("VAL1", val[1] - val[0] + 1)
                      .setParameter("VAL2", val[0]).executeUpdate();
    getEntityManager().createQuery(
      "update Region m set m.rightVal = m.rightVal - :VAL1 WHERE  m.rightVal > :VAL2")
                      .setParameter("VAL1", val[1] - val[0] + 1)
                      .setParameter("VAL2", val[1]).executeUpdate();
    //    String parentId = region.getParentId();
    //    getDao().deleteInBatch(treeForId(id, null));
    //    if (StringUtils.isNotEmpty(parentId)) {
    //      Optional<Region> opt = getDao().findById(parentId);
    //      if (opt.isPresent()) {
    //        Region parent = opt.get();
    //        List<Region> list = getDao().findByParentId(parent.getId());
    //        if (list == null || list.isEmpty()) {
    //          parent.setLeaf(Valid.TRUE.getVal());
    //          getDao().saveAndFlush(parent);
    //        }
    //      }
    //    }
  }

  /**
   * 根据id查询这颗id对应的树
   *
   * @param id
   * @param regions
   *
   * @return
   */
  private List<Region> treeForId(String id, List<Region> regions) {
    if (regions == null) {
      regions = new ArrayList<>();
    }
    Region region = getDao().findById(id).orElseThrow(() -> new IllegalArgumentException("未找到地区"));
    regions.add(region);
    for (Region tmp : getDao().findByParentId(id)) {
      regions.add(tmp);
      treeForId(tmp.getId(), regions);
    }
    return regions;
  }

  /**
   * 根据parentId查询所有的上级集合
   *
   * @param parentId
   * @param regions
   *
   * @return
   */
  private List<Region> listForParent(String parentId, List<Region> regions) {
    if (regions == null) {
      regions = new ArrayList<>();
    }
    if(StringUtils.isNotEmpty(parentId)){
      Optional<Region> tmp = getDao().findById(parentId);
      if (tmp.isPresent()) {
        regions.add(tmp.get());
        listForParent(tmp.get().getParentId(), regions);
      }
    }
    return regions;
  }

  /**
   * 查找所有子节点（包括所有层级的和自己的id）
   *
   * @param parentId
   *
   * @return
   */
  public Set<String> findAllChildren(String parentId, List<Region> all) {
    Map<String, List<Region>> child = new LinkedHashMap<>();
    Map<String, Region> regionMap = new HashMap<>();
    for (Region region : all) {
      List<Region> regions = child.get(region.getParentId());
      regions = regions == null ? new ArrayList<>() : regions;
      regions.add(region);
      child.put(region.getParentId(), regions);
      regionMap.put(region.getId(), region);
    }
    Region curRegion = regionMap.get(parentId);
    if (curRegion == null) {
      return Sets.newHashSet();
    }
    HashSet<String> result = Sets.newHashSet();
    result.add(parentId);

    addChildrenId(Lists.newArrayList(parentId), result, child);
    return result;
  }

  /**
   * 根据parentId查询地区列表
   *
   * @param parentId
   *
   * @return
   */
  public List<Region> getRegionByParentId(String parentId) {
    List<Region> list;
    if (StringUtils.isNotEmpty(parentId)) {
      list = getDao().findByParentId(parentId);
    } else {
      list = getDao().findRoots();
    }
    return list;
  }

  private Set<String> addChildrenId(List<String> parentIds, HashSet<String> result, Map<String, List<Region>> child) {
    List<Region> childrens = new ArrayList<>();
    for (String s : parentIds) {
      List<Region> regions = child.get(s);
      if (regions != null && regions.size() > 0) {
        childrens.addAll(regions);
      }
    }
    List<String> childrensId = Lists.newArrayList();
    for (Region children : childrens) {
      result.add(children.getId());
      if (children.getLeaf() == Valid.FALSE.getVal()) {
        childrensId.add(children.getId());
      }
    }
    if (childrensId.size() > 0) {
      addChildrenId(childrensId, result, child);
    }
    return result;
  }



  private void addNodes(List<TreeNodeData<Region>> nodes, boolean isRoot, TreeParam params, CountType countType) {
    List<Region> list;
    if (isRoot) {
      list = findByParentId(RegionDao.ROOT_PARENTID, countType);
      for (Region entity : list) {
        TreeNodeData<Region> node = RegionNodeBuilder.buildNode(entity, null);
        //        List<TreeNodeData<Region>> children = Lists.newArrayList();
        //        for (Region child : findByParentId(entity.getId(), countType)) {
        //          children.add(RegionNodeBuilder.buildNode(child, null));
        //        }
        //        node.setChildren(children);
        nodes.add(node);
      }
    } else {
      String[] roots = params.getRoots();
      if (roots.length > 0) {
        for (String root : roots) {
          Region parent = findById(root);
          TreeNodeData<Region> parentNode = RegionNodeBuilder.buildNode(parent, null);
          addChildren(parentNode, parent, params, countType);
          nodes.add(parentNode);
        }
      } else {
        list = findByParentId(params.getNodeId(), countType);
        for (Region entity : list) {
          TreeNodeData<Region> node = RegionNodeBuilder.buildNode(entity, null);
          nodes.add(node);
        }
      }
    }
  }

  private void buildNode(List<TreeNodeData<Region>> nodes, List<Region> list, Map<String, Integer> countMap) {
    for (Region entity : list) {
      RegionCountDto regionCountDto = new RegionCountDto();
      BeanUtils.copyProperties(entity, regionCountDto);
      if (!countMap.isEmpty()) {
        regionCountDto.setCount(countMap.get(regionCountDto.getId()));
      }
      TreeNodeData<Region> node = RegionNodeBuilder.buildNode(regionCountDto, null);
      nodes.add(node);
    }
  }

  private List<Region> findByParentId(String parentId, CountType countType) {
    switch (countType) {
      case MEMBER:
        return getDao().findByParentIdWithMemberCount(parentId);
      case NORMAL_USER:
        return getDao().findByParentIdWithNormalUserCount(UserType.USER.getCode(), parentId);
      default:
        return getDao().findByParentId(parentId);
    }
  }

  private void addChildren(TreeNodeData<Region> parentNode, Region parent, TreeParam params, CountType countType) {
    List<TreeNodeData<Region>> children = Lists.newArrayList();
    for (Region child : findByParentId(parent.getId(), countType)) {
      children.add(RegionNodeBuilder.buildNode(child, null));
    }
    parentNode.setChildren(children);
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

  public enum CountType {
    NONE,
    MEMBER,
    /**
     * 一般用户
     */
    NORMAL_USER,
  }
}
