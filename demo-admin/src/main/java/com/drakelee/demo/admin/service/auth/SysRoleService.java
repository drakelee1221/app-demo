

package com.drakelee.demo.admin.service.auth;

import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.google.common.collect.LinkedListMultimap;
import com.google.common.collect.ListMultimap;
import com.google.common.collect.Lists;
import com.google.common.collect.Multimap;
import com.google.common.collect.Sets;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.domain.admin.SysAppInfo;
import com.drakelee.demo.common.domain.admin.SysAppInfoRole;
import com.drakelee.demo.common.domain.admin.SysMemberRole;
import com.drakelee.demo.common.domain.admin.SysRole;
import com.drakelee.demo.database.dao.admin.SysAppInfoDao;
import com.drakelee.demo.database.dao.admin.SysAppInfoRoleDao;
import com.drakelee.demo.database.dao.admin.SysMemberRoleDao;
import com.drakelee.demo.database.dao.admin.SysRoleDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

/**
 * SysRole Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-03
 */
@Service
public class SysRoleService extends AbstractJpaService<SysRole, String, SysRoleDao> {
  @Autowired
  private SysAppInfoDao sysAppInfoDao;
  @Autowired
  private SysAppInfoRoleDao sysAppInfoRoleDao;
  @Autowired
  private SysMemberRoleDao sysMemberRoleDao;

  public List<SysRole> findRoleByMemberId(@NonNull String memberId){
    return getDao().findByMemberId(memberId);
  }

  @Transactional(rollbackFor = Exception.class)
  public SysRole saveAndFlush(SysRole sysRole){
    if (StringUtils.isNotEmpty(sysRole.getCode())) {
      Optional<SysRole> role = getDao()
        .findOne(ConditionGroup.build().addCondition("code", ConditionEnum.OPERATE_EQUAL, sysRole.getCode()));
      Assert.isTrue(!role.isPresent(), "该编码已存在");
    }

    if(StringUtils.isNotBlank(sysRole.getId())){
      SysRole exists = findById(sysRole.getId());
      Assert.notNull(exists, "未找到记录");
      sysRole.setStatus(exists.getStatus());
    }else{
      sysRole.setStatus(Valid.TRUE.getVal());
    }
    return getDao().saveAndFlush(sysRole);
  }

  @Transactional(rollbackFor = Exception.class)
  public SysRole changeStatus(String id, Integer status){
    SysRole exists = findById(id);
    Assert.notNull(exists, "未找到记录");
    exists.setStatus(status);
    return getDao().saveAndFlush(exists);
  }

  @Transactional(rollbackFor = Exception.class)
  public void addAppInfoJoin(String roleId, Set<String> appInfoIds){
    if(StringUtils.isNoneBlank(roleId)){
      sysAppInfoRoleDao.deleteByRoleId(roleId);
      if(!CollectionUtils.isEmpty(appInfoIds)){
        for (String appInfoId : appInfoIds) {
          SysAppInfoRole ar = new SysAppInfoRole();
          ar.setAppInfoId(appInfoId);
          ar.setRoleId(roleId);
          sysAppInfoRoleDao.save(ar);
        }
      }
    }
  }

  @Transactional(rollbackFor = Exception.class)
  public void addMemberJoin(String roleId, Set<String> memberIds){
    if(StringUtils.isNoneBlank(roleId)){
      sysMemberRoleDao.deleteByRoleId(roleId);
      if(!CollectionUtils.isEmpty(memberIds)){
        for (String memberId : memberIds) {
          SysMemberRole mr = new SysMemberRole();
          mr.setMemberId(memberId);
          mr.setRoleId(roleId);
          sysMemberRoleDao.save(mr);
        }
      }
    }
  }

  public List<TreeNodeData<SysAppInfo>> findAuthAppInfoByMemberId(String memberId){
    List<TreeNodeData<SysAppInfo>> nodes = Lists.newArrayList();
    if(StringUtils.isNotBlank(memberId)){
      List<SysAppInfo> all = sysAppInfoDao.findAuthAppInfoByMemberId(memberId);
      if(!CollectionUtils.isEmpty(all)){
        List<SysAppInfo> roots = Lists.newArrayList();
        ListMultimap<String, SysAppInfo> parentIdMap = LinkedListMultimap.create();
        Set<String> ids = Sets.newHashSet();
        for (SysAppInfo app : all) {
          ids.add(app.getId());
          parentIdMap.put(app.getParentId(), app);
          //先将自己的 id 一定会先放入 ids 中，
          //因为是左值排序，自己的 ParentId 一定会先放入 ids 中，
          //如果自己的ParentId不在 ids 中，则为根节点
          if(!ids.contains(app.getParentId())){
            roots.add(app);
          }
        }
        for (SysAppInfo root : roots) {
          TreeNodeData<SysAppInfo> rootNode = AppInfoNodeBuilder.buildNode(root, null);
          buildAuthAppInfoTree(rootNode, parentIdMap);
          nodes.add(rootNode);
        }
      }
    }
    return nodes;
  }

  public List<TreeNodeData<Map<String, Object>>> loadRoleCheckedMemberTree(Set<String> roleIds){
    List<TreeNodeData<Map<String, Object>>> nodes = Lists.newArrayList();
    if(!CollectionUtils.isEmpty(roleIds)){
      List<Map<String, Object>> all = sysMemberRoleDao.findAllMemberJoinRole(roleIds);
      if(!all.isEmpty()){
        Multimap<String, Map<String, Object>> parentIdMap = LinkedListMultimap.create();
        for (Map<String, Object> item : all) {
          parentIdMap.put(item.get("parentId").toString(), item);
        }
        TreeNodeData<Map<String, Object>> root = MemberMapBuilder.buildNode(all.get(0), null);
        buildMemberTree(root, parentIdMap);
        nodes.add(root);
      }
    }
    return nodes;
  }


  public List<TreeNodeData<Map<String, Object>>> loadRoleCheckedAppInfoTree(Set<String> roleIds){
    List<TreeNodeData<Map<String, Object>>> nodes = Lists.newArrayList();
    if(!CollectionUtils.isEmpty(roleIds)){
      List<Map<String, Object>> all = sysAppInfoRoleDao.findAllAppInfoJoinRole(roleIds);
      if(!all.isEmpty()){
        Multimap<String, Map<String, Object>> parentIdMap = LinkedListMultimap.create();
        for (Map<String, Object> item : all) {
          parentIdMap.put(item.get("parentId").toString(), item);
        }
        TreeNodeData<Map<String, Object>> root = AppInfoMapBuilder.buildNode(all.get(0), null);
        buildAppInfoTree(root, parentIdMap);
        nodes.add(root);
      }
    }
    return nodes;
  }

  private void buildAppInfoTree(TreeNodeData<Map<String, Object>> node, Multimap<String, Map<String, Object>> parentIdMap){
    Collection<Map<String, Object>> children = parentIdMap.get(node.getRefKey());
    List<TreeNodeData<Map<String, Object>>> childrenNodes = Lists.newArrayList();
    if(children != null && !children.isEmpty()){
      for (Map<String, Object> child : children) {
        TreeNodeData<Map<String, Object>> childNode = AppInfoMapBuilder.buildNode(child, null);
        childrenNodes.add(childNode);
        buildAppInfoTree(childNode, parentIdMap);
      }
    }
    node.setChildren(childrenNodes);
  }

  private void buildMemberTree(TreeNodeData<Map<String, Object>> node, Multimap<String, Map<String, Object>> parentIdMap){
    Collection<Map<String, Object>> children = parentIdMap.get(node.getRefKey());
    List<TreeNodeData<Map<String, Object>>> childrenNodes = Lists.newArrayList();
    if(children != null && !children.isEmpty()){
      for (Map<String, Object> child : children) {
        TreeNodeData<Map<String, Object>> childNode = MemberMapBuilder.buildNode(child, null);
        childrenNodes.add(childNode);
        buildMemberTree(childNode, parentIdMap);
      }
    }
    node.setChildren(childrenNodes);
  }

  private void buildAuthAppInfoTree(TreeNodeData<SysAppInfo> node, Multimap<String, SysAppInfo> parentIdMap){
    Collection<SysAppInfo> children = parentIdMap.get(node.getRefKey());
    List<TreeNodeData<SysAppInfo>> childrenNodes = Lists.newArrayList();
    if(children != null && !children.isEmpty()){
      for (SysAppInfo child : children) {
        TreeNodeData<SysAppInfo> childNode = AppInfoNodeBuilder.buildNode(child, null);
        childrenNodes.add(childNode);
        buildAuthAppInfoTree(childNode, parentIdMap);
      }
    }
    node.setChildren(childrenNodes);
  }
}