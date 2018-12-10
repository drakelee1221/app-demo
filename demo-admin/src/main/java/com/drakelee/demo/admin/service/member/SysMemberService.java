

package com.drakelee.demo.admin.service.member;

import com.base.components.cache.Cache;
import com.base.components.cache.CacheManager;
import com.base.components.common.constants.Valid;
import com.base.components.common.exception.auth.AuthException;
import com.base.components.common.exception.business.PasswordErrorException;
import com.base.components.common.token.TokenManager;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.NestedSetModel;
import com.base.components.common.util.PasswordUtil;
import com.base.components.common.util.Relationship;
import com.base.components.common.util.SqlLikeHelper;
import com.base.components.common.util.UUIDUtils;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.base.components.database.service.AbstractJpaService;
import com.codingapi.tx.annotation.TxTransaction;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.AdminAuth;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.admin.service.region.RegionService;
import com.drakelee.demo.admin.service.tree.NodeBuilder;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.admin.MemberAttrType;
import com.drakelee.demo.common.constants.admin.MemberType;
import com.drakelee.demo.common.domain.admin.SysMember;
import com.drakelee.demo.common.domain.admin.SysRole;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.common.dto.admin.SysAppInfoDto;
import com.drakelee.demo.common.token.user.UserMemberToken;
import com.drakelee.demo.database.dao.admin.SysAppInfoDao;
import com.drakelee.demo.database.dao.admin.SysMemberAttrDao;
import com.drakelee.demo.database.dao.admin.SysMemberDao;
import com.drakelee.demo.database.dao.admin.SysRoleDao;
import com.google.common.collect.LinkedListMultimap;
import com.google.common.collect.ListMultimap;
import com.google.common.collect.Lists;
import com.google.common.collect.Multimap;
import com.google.common.collect.Sets;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.data.domain.Sort;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * SysMember Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-17
 */
@Service
@ConfigurationProperties("base.admin")
public class SysMemberService extends AbstractJpaService<SysMember, String, SysMemberDao> {
  private static final ThreadLocal<AdminAuth> CURRENT_ADMIN_AUTH = new ThreadLocal<>();
  @Autowired
  private TokenManager tokenManager;
  @Autowired
  private CacheManager cacheManager;
  @Autowired
  private SysAppInfoDao sysAppInfoDao;
  @Autowired
  private SysRoleDao sysRoleDao;

  private Set<String> superRoleIds = Sets.newHashSet();
  @Autowired
  private RegionService regionService;
  @Autowired
  private SysMemberDao memberDao;
  @Autowired
  private SysMemberAttrDao sysMemberAttrDao;
  /**
   * 懒加载树
   *
   * @param treeParam
   * @param nodeBuilder
   * @param treeKind
   *
   * @return
   */
  public List<TreeNodeData<SysMember>> loadTreeNodes(TreeParam treeParam, NodeBuilder<SysMember> nodeBuilder,
                                                     String treeKind) {
    return loadTreeNodes(treeParam, nodeBuilder, treeKind, null, CountType.NONE);
  }

  /**
   * 懒加载树
   *
   * @param treeParam
   * @param nodeBuilder
   * @param treeKind
   * @param selectIds
   *
   * @return
   */
  public List<TreeNodeData<SysMember>> loadTreeNodes(TreeParam treeParam, NodeBuilder<SysMember> nodeBuilder,
                                                     String treeKind, List<String> selectIds, CountType countType) {
    List<TreeNodeData<SysMember>> nodes = Lists.newArrayList();
    boolean isRoot = true;
    if (StringUtils.isNotBlank(treeParam.getNodeId()) || treeParam.getRoots().length > 0) {
      isRoot = false;
    }
    addNodes(nodes, isRoot, treeParam, new MemberNodeBuilder(), treeKind, selectIds, countType);
    return nodes;
  }


  /**
   * 加载整颗树
   *
   * @param treeParam
   * @param nodeBuilder
   * @param treeKind
   * @param selectIds
   *
   * @return
   */
  public List<TreeNodeData<SysMember>> loadAllNodes(TreeParam treeParam, NodeBuilder<SysMember> nodeBuilder,
                                                    String treeKind, List<String> selectIds) {
    List<TreeNodeData<SysMember>> nodes = Lists.newArrayList();
    List<SysMember> all = getDao().findAllNode(treeKind);
    if (!all.isEmpty()) {
      Multimap<String, SysMember> parentIdMap = LinkedListMultimap.create();
      for (SysMember item : all) {
        parentIdMap.put(item.getParentId(), item);
      }
      TreeNodeData<SysMember> root = nodeBuilder.buildNode(all.get(0), selectIds, treeParam);
      buildAllNodes(root, treeParam, nodeBuilder, parentIdMap, selectIds);
      nodes.add(root);
    }
    return nodes;
  }

  private void buildAllNodes(TreeNodeData<SysMember> node, TreeParam treeParam, NodeBuilder<SysMember> nodeBuilder,
                             Multimap<String, SysMember> parentIdMap, List<String> selectIds) {
    Collection<SysMember> children = parentIdMap.get(node.getRefKey());
    List<TreeNodeData<SysMember>> childrenNodes = Lists.newArrayList();
    if (children != null && !children.isEmpty()) {
      for (SysMember child : children) {
        TreeNodeData<SysMember> childNode = nodeBuilder.buildNode(child, selectIds, treeParam);
        childrenNodes.add(childNode);
        buildAllNodes(childNode, treeParam, nodeBuilder, parentIdMap, selectIds);
      }
    }
    node.setChildren(childrenNodes);
  }

  @TxTransaction(rollbackFor = Exception.class)
  public UserMemberToken updateBaseInfoAndTokenObj(Map<String, String> param) {
    UserMemberToken memberToken = TokenThreadLocal.getTokenObjNonNull(UserMemberToken.class);
    SysMember member = findById(memberToken.getId());
    Assert.notNull(member, "未找到用户信息");
    member.setPwd(PasswordUtil.decryptPassword(member.getAccount(), member.getPwd()));
    String memberName = param.get("memberName");
    if (StringUtils.isNotBlank(memberName)) {
      member.setMemberName(memberName);
      memberToken.setMemberName(memberName);
    }
    String oldPwd = param.get("oldPwd");
    String pwd = param.get("pwd");
    if (StringUtils.isNoneBlank(oldPwd, pwd)) {
      Assert.isTrue(member.getPwd().equals(oldPwd), "旧密码不正确！");
      member.setPwd(pwd);
    }
    String account = param.get("account");
    if (StringUtils.isNotBlank(account)) {
      member.setAccount(account);
      memberToken.setAccount(account);
    }
    updateBaseInfo(member);
    tokenManager.cacheToken(memberToken);
    return memberToken;
  }

  @TxTransaction(rollbackFor = Exception.class)
  public SysMember updateBaseInfo(SysMember member) {
    Assert.isTrue(member != null && StringUtils.isNotBlank(member.getId()), "未找到帐号信息！");
    SysMember exists = findById(member.getId());
    Assert.notNull(exists, "未找到帐号信息！");
    member.setLeftVal(exists.getLeftVal());
    member.setRightVal(exists.getRightVal());
    member.setTreeKind(exists.getTreeKind());
    member.setParentId(exists.getParentId());
    member.setMemberType(exists.getMemberType());
    member.setCreateTime(exists.getCreateTime());
    member.setMemberCode(exists.getMemberCode());
    checkMemberType(member, exists.getAccount());
    member = getDao().saveAndFlush(member);
    return member;
  }

  @Transactional(rollbackFor = Exception.class)
  public SysMember addMember(SysMember member) {
    SysMember parent = findById(member.getParentId());
    Assert.notNull(parent, "未找到父节点！");
    Assert.isTrue(MemberType.DEPT.getType() == parent.getMemberType(), "只能在部门节点添加人员");
    checkMemberType(member, null);
    int[] val = NestedSetModel.insert(parent.getLeftVal(), parent.getRightVal(), Relationship.ChildLast);
    getEntityManager().createQuery(
      "update SysMember m set m.leftVal = m.leftVal + 2 WHERE m.treeKind=:treeKind and m.leftVal > :leftVal")
                      .setParameter("treeKind", parent.getTreeKind()).setParameter("leftVal", val[0]).executeUpdate();
    getEntityManager().createQuery(
      "update SysMember m set m.rightVal = m.rightVal + 2 WHERE m.treeKind=:treeKind and  m.rightVal > :rightVal")
                      .setParameter("treeKind", parent.getTreeKind()).setParameter("rightVal", val[0]).executeUpdate();
    member.setLeftVal(val[1]);
    member.setRightVal(val[1] + 1);
    member.setTreeKind(parent.getTreeKind());
    member.setStatus(Valid.TRUE.getVal());
    member.setCreateTime(new Date());
    member.setId(null);
    member.setRegionId(parent.getRegionId());
    member = getDao().saveAndFlush(member);
    return member;
  }
  @Transactional(rollbackFor = Exception.class)
  public SysMember addRootMember(Map<String,String> params) {
    SysMember member = new SysMember();
    String treeKind = ConvertUtil.convert(params.get("treeKind"),"");
    String memberName = ConvertUtil.convert(params.get("memberName"), "");
    Date date = new Date();
    Assert.hasText(treeKind,"树的类型不能为空");
    member.setTreeKind(treeKind);
    member.setMemberType(MemberType.DEPT.getType());
    member.setMemberName(memberName);
    member.setPwd(null);
    member.setAccount(null);
    member.setLeftVal(1);
    member.setRightVal(2);
    member.setStatus(Valid.TRUE.getVal());
    member.setCreateTime(date);
    member.setParentId("");
    member.setRegionId(treeKind);
    member = getDao().saveAndFlush(member);
    member.setTreeKind(treeKind+member.getId());
    getDao().saveAndFlush(member);
    return member;
  }

  @Transactional(rollbackFor = Exception.class)
  public void delete(String id) {
    SysMember member = findById(id);
    Assert.isTrue(member.getLeftVal() > 1, "can not delete root member !");
    int[] val = NestedSetModel.delete(member.getLeftVal(), member.getRightVal());
    getEntityManager().createQuery(
      "delete from SysMember m WHERE m.treeKind=:treeKind and m.leftVal >= :leftVal and m.rightVal <= :rightVal")
                      .setParameter("treeKind", member.getTreeKind()).setParameter("leftVal", val[0])
                      .setParameter("rightVal", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "update SysMember m set m.leftVal = m.leftVal - :VAL1  WHERE m.treeKind=:treeKind and m.leftVal > :VAL2")
                      .setParameter("treeKind", member.getTreeKind()).setParameter("VAL1", val[1] - val[0] + 1)
                      .setParameter("VAL2", val[0]).executeUpdate();
    getEntityManager().createQuery(
      "update SysMember m set m.rightVal = m.rightVal - :VAL1 WHERE m.treeKind=:treeKind and m.rightVal > :VAL2")
                      .setParameter("treeKind", member.getTreeKind()).setParameter("VAL1", val[1] - val[0] + 1)
                      .setParameter("VAL2", val[1]).executeUpdate();
    //删除关联
    //成员-角色
    getEntityManager().createNativeQuery("delete from admin_sys_member_role where member_id = :mId")
                      .setParameter("mId", member.getId()).executeUpdate();
    //成员-属性
    getEntityManager().createNativeQuery("delete from admin_sys_member_attr where member_id = :mId")
                      .setParameter("mId", member.getId()).executeUpdate();
//    //成员-业务用户
//    getEntityManager().createNativeQuery("delete from he_profession_mapping where member_id = :mId")
//                      .setParameter("mId", member.getId()).executeUpdate();
  }


  @Transactional(rollbackFor = Exception.class)
  public void updateToMove(String srcId, String targetId, String hitMode) throws IllegalArgumentException {
    SysMember src = findById(srcId);
    Assert.notNull(src, "源节点信息未找到");
    SysMember target = findById(targetId);
    Assert.notNull(src, "目标节点信息未找到");
    Assert.isTrue(src.getLeftVal() > 1 && target.getLeftVal() > 1, "root element can not be move !");
    Assert.isTrue(target.getTreeKind().equals(src.getTreeKind()),
                  "TreeKind(" + src.getTreeKind() + "," + target.getTreeKind() + ") is not equal !"
    );
    int[] val;
    boolean moveToChild = false;
    if (Relationship.After.toString().equalsIgnoreCase(hitMode)) {
      val = NestedSetModel
        .update(target.getLeftVal(), target.getRightVal(), src.getLeftVal(), src.getRightVal(), Relationship.After);
    } else if (Relationship.Before.toString().equalsIgnoreCase(hitMode)) {
      val = NestedSetModel
        .update(target.getLeftVal(), target.getRightVal(), src.getLeftVal(), src.getRightVal(), Relationship.Before);
    }
    //over
    else {
      moveToChild = true;
      val = NestedSetModel
        .update(target.getLeftVal(), target.getRightVal(), src.getLeftVal(), src.getRightVal(), Relationship.ChildLast);
    }
    getEntityManager().createQuery(
      "UPDATE SysMember m SET m.leftVal = m.leftVal * -1, m.rightVal = m.rightVal * -1 WHERE m.treeKind = :treeKind and m.leftVal >= :VAL1 and m.leftVal <= :VAL2")
                      .setParameter("treeKind", src.getTreeKind()).setParameter("VAL1", src.getLeftVal())
                      .setParameter("VAL2", src.getRightVal()).executeUpdate();
    getEntityManager().createQuery(
      "UPDATE SysMember m SET m.leftVal = m.leftVal + :VAL1 WHERE m.treeKind = :treeKind and m.leftVal > :VAL2 and m.leftVal < :VAL3")
                      .setParameter("treeKind", src.getTreeKind()).setParameter("VAL1", val[3])
                      .setParameter("VAL2", val[0]).setParameter("VAL3", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "UPDATE SysMember m SET m.rightVal = m.rightVal + :VAL1 WHERE m.treeKind = :treeKind and m.rightVal > :VAL2 and m.rightVal < :VAL3")
                      .setParameter("treeKind", src.getTreeKind()).setParameter("VAL1", val[3])
                      .setParameter("VAL2", val[0]).setParameter("VAL3", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "UPDATE SysMember m SET m.leftVal = (m.leftVal * -1 + :VAL1), m.rightVal = (m.rightVal * -1 + :VAL2) WHERE m.treeKind = :treeKind and m.leftVal <= (:VAL3 * -1) and m.rightVal >= (:VAL4 * -1)")
                      .setParameter("treeKind", src.getTreeKind()).setParameter("VAL1", val[2])
                      .setParameter("VAL2", val[2]).setParameter("VAL3", src.getLeftVal())
                      .setParameter("VAL4", src.getRightVal()).executeUpdate();
    String parentId = moveToChild ? target.getId() : target.getParentId();
    getEntityManager().createQuery("UPDATE SysMember m set m.parentId = :parentId where m.id = :id")
                      .setParameter("parentId", parentId).setParameter("id", src.getId()).executeUpdate();
  }



  @Transactional(rollbackFor = Exception.class)
  public UserMemberToken login(@NonNull String username, @NonNull String password, String loginIp) {
    SysMember exists = getDao().findByAccount(username);
    if (exists == null) {
      throw new AuthException("用户不存在");
    }
    if (!exists.getPwd().equals(PasswordUtil.encryptPassword(username, password))) {
      throw new PasswordErrorException("密码错误");
    }
    getDao().updateLoginInfo(exists.getId(), loginIp);
    UserMemberToken userMemberToken = new UserMemberToken();
    userMemberToken.setAccount(username);
    userMemberToken.setMemberName(exists.getMemberName());
    userMemberToken.setId(exists.getId());
    userMemberToken.setMemberType(exists.getMemberType());
    userMemberToken.setToken(UUIDUtils.generateKey());
    tokenManager.cacheToken(userMemberToken);
    Set<String> roleIds = Sets.newHashSet();
    Set<String> roleCodes = Sets.newHashSet();
    boolean superRole = buildRoleIdsAndCodes(sysRoleDao.findByMemberId(exists.getId()), roleIds, roleCodes);
    List<SysAppInfoDto> appInfoList;
    if (superRole) {
      appInfoList = sysAppInfoDao.findAllAppInfoDto();
    } else {
      appInfoList = sysAppInfoDao.findAuthAppInfoDtoByMemberId(exists.getId());
    }
    if (!CollectionUtils.isEmpty(appInfoList)) {
      List<SysAppInfoDto> roots = Lists.newArrayList();
      ListMultimap<String, SysAppInfoDto> parentIdMap = LinkedListMultimap.create();
      Set<String> ids = Sets.newHashSet();
      for (SysAppInfoDto dto : appInfoList) {
        ids.add(dto.getId());
        parentIdMap.put(dto.getParentId(), dto);
        //先将自己的 id 一定会先放入 ids 中，
        //因为是左值排序，自己的 ParentId 一定会先放入 ids 中，
        //如果自己的ParentId不在 ids 中，则为根节点
        if (!ids.contains(dto.getParentId())) {
          roots.add(dto);
        }
      }
      for (SysAppInfoDto root : roots) {
        buildAuthAppInfoDto(root, parentIdMap);
      }
      AdminAuth adminAuth = new AdminAuth();
      adminAuth.setRoleCodes(roleCodes);
      adminAuth.setRoleIds(roleIds);
      adminAuth.setSuperRole(superRole);
      adminAuth.setTokenObjId(exists.getId());
      adminAuth.setAppInfoDtoList(roots);
      Cache cache = cacheManager.getCache(CacheName.ADMIN_AUTH_INFO);
      cache.put(exists.getId(), adminAuth);
    }
    return userMemberToken;
  }

  /**
   * 获取当前登录对象的授权信息
   */
  @Transactional(rollbackFor = Exception.class)
  public AdminAuth getCurrentAdminAuth() {
    Cache cache = cacheManager.getCache(CacheName.ADMIN_AUTH_INFO);
    AdminAuth auth = CURRENT_ADMIN_AUTH.get();
    if (auth == null) {
      UserMemberToken tokenObj = TokenThreadLocal.getTokenObj(UserMemberToken.class);
      if (tokenObj == null) {
        return null;
      }
      auth = cache.get(tokenObj.getId(), AdminAuth.class);
      CURRENT_ADMIN_AUTH.set(auth);
    }
    if (auth != null) {
      cache.expire(auth.getTokenObjId(), cache.getDefaultExpiresSecond(), TimeUnit.SECONDS);
    }
    return auth;
  }

  /**
   * 机构部门
   * @param regionId
   * @return
   */
  public List<Map> memberTree(String regionId){
    if(regionId==null){
      regionId="";
    }
    return getDao().memberTree(regionId+"%");
  }

  /**
   * 地区
   *
   * @return
   */
  public List<Map> regionTree(){
    return getDao().regionTree();
  }


  public void cleanCurrentAdminAuth() {
    CURRENT_ADMIN_AUTH.remove();
  }

  @Transactional(rollbackFor = Exception.class)
  public void logout(Serializable token) {
    if (token != null && StringUtils.isNotBlank(token.toString())) {
      tokenManager.removeToken(token.toString());
    }
  }

  private void buildAuthAppInfoDto(SysAppInfoDto node, ListMultimap<String, SysAppInfoDto> parentIdMap) {
    List<SysAppInfoDto> children = Lists.newArrayList(parentIdMap.get(node.getId()));
    if (!CollectionUtils.isEmpty(children)) {
      for (SysAppInfoDto child : children) {
        buildAuthAppInfoDto(child, parentIdMap);
      }
    }
    node.setChildren(children);
  }

  private void checkMemberType(SysMember member, String existsAccount) {
    if (MemberType.PERSON.getType() == member.getMemberType()) {
      Assert.isTrue(StringUtils.isNotBlank(member.getPwd()) && StringUtils.isNotBlank(member.getAccount()),
                    "人员类型需设置帐号或密码！"
      );
      Assert
        .isTrue(member.getAccount().equals(existsAccount) || getDao().findByAccount(member.getAccount()) == null,
                "账号：" + member.getAccount() + "，已经存在！"
        );
      member.setPwd(PasswordUtil.encryptPassword(member.getAccount(), member.getPwd()));
    } else {
      member.setPwd(null);
      member.setAccount(null);
    }
  }


  private void addNodes(List<TreeNodeData<SysMember>> nodes, boolean isRoot, TreeParam params,
                        NodeBuilder<SysMember> builder, String treeKind, List<String> selectIds, CountType countType) {
    List<SysMember> list;
    if (isRoot) {
      list = findByParentId(treeKind, countType, "", true);
      for (SysMember entity : list) {
        if (StringUtils.isNotBlank(params.getTreeKind()) && !entity.getTreeKind().startsWith(params.getTreeKind())) {
          continue;
        }
        TreeNodeData<SysMember> node = builder.buildNode(entity, selectIds, params);
        List<TreeNodeData<SysMember>> children = Lists.newArrayList();
        for (SysMember child : findByParentId(entity.getTreeKind(), countType, entity.getId(), false)) {
          children.add(builder.buildNode(child, selectIds, params));
        }
        node.setChildren(children);
        nodes.add(node);
      }
    } else {
      String[] roots = params.getRoots();
      if (roots.length > 0) {
        for (String root : roots) {
          SysMember parent = findById(root);
          TreeNodeData<SysMember> parentNode = builder.buildNode(parent, selectIds, params);
          addChildren(parentNode, parent, params, builder, selectIds);
          nodes.add(parentNode);
        }
      } else {
        list = findByParentId(params.getTreeKind(), countType, params.getNodeId(), false);
        for (SysMember entity : list) {
          TreeNodeData<SysMember> node = builder.buildNode(entity, selectIds, params);
          nodes.add(node);
        }
      }
    }
  }

  private List<SysMember> findByParentId(String treeKind, CountType countType, String parentId, boolean isRoot) {
    switch (countType) {
      default:
        if (isRoot) {
          return getDao().findRoots(SqlLikeHelper.right(treeKind));
        } else {
          return getDao().findByParentIdOrderByLeftVal(parentId);
        }
    }
  }

  private void addChildren(TreeNodeData<SysMember> parentNode, SysMember parent, TreeParam params,
                           NodeBuilder<SysMember> builder, List<String> selectIds) {
    List<TreeNodeData<SysMember>> children = Lists.newArrayList();
    for (SysMember child : getDao().findByParentIdOrderByLeftVal(parent.getId())) {
      children.add(builder.buildNode(child, selectIds, params));
    }
    parentNode.setChildren(children);
  }

  /**
   * 将role对象集合，放入 roleIds 集合和 roleCodes 集合中
   * @param roles
   * @param roleIds
   * @param roleCodes
   *
   * @return 是否含有超级管理员
   */
  private boolean buildRoleIdsAndCodes(List<SysRole> roles, Set<String> roleIds, Set<String> roleCodes) {
    boolean isSuperRole = false;
    Set<String> superRoleIds = getSuperRoleIds();
    for (SysRole r : roles) {
      roleIds.add(r.getId());
      if(StringUtils.isNotBlank(r.getCode())){
        roleCodes.add(r.getCode());
      }
      if (!isSuperRole && superRoleIds.contains(r.getId())) {
        isSuperRole = true;
      }
    }
    return isSuperRole;
  }

  public Set<String> getSuperRoleIds() {
    return superRoleIds;
  }

  public void setSuperRoleIds(Set<String> superRoleIds) {
    this.superRoleIds = superRoleIds;
  }

  public int countRegionMembers(Set<String> allChildren) {
    ArrayList<String> regionIds = new ArrayList<>(allChildren);
    ConditionGroup<SysMember> build = ConditionGroup.build()
      .addCondition("regionId", ConditionEnum.OPERATE_IN,regionIds)
      .addCondition("leftVal",ConditionEnum.OPERATE_EQUAL,1)
      .addCondition("memberType",ConditionEnum.OPERATE_EQUAL,MemberType.DEPT.getType());
    return Integer.valueOf(String.valueOf(getDao().count(build)));
  }


  /**
   * 获取地区下的默认组织机构，没有则创建
   * @param region
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public SysMember getDefaultOrg(String region) {
    ConditionGroup<SysMember> build = ConditionGroup.build()
      .addCondition("regionId",ConditionEnum.OPERATE_EQUAL,region)
      .addCondition("defaultOrg",ConditionEnum.OPERATE_EQUAL,Valid.TRUE.getVal());
    SysMember member = getDao().findOne(build).orElse(null);
    if(member == null){
      member = new SysMember();
      Date date = new Date();
      member.setTreeKind(region);
      Region regionObj = regionService.getOne(region);
      Assert.notNull(regionObj,region+"地区不存在");
      member.setMemberType(MemberType.DEPT.getType());
      member.setMemberName("默认机构("+regionObj.getNamePath().replace("-","")+")");
      member.setPwd(null);
      member.setAccount(null);
      member.setLeftVal(1);
      member.setRightVal(2);
      member.setStatus(Valid.TRUE.getVal());
      member.setCreateTime(date);
      member.setParentId("");
      member.setRegionId(region);
      member = getDao().saveAndFlush(member);
      member.setTreeKind(region+member.getId());
      getDao().saveAndFlush(member);
    }
    return member;
  }

  public List<SysMember> queryAuthMembersById(String memberId) {
    List<String> values = sysMemberAttrDao.findParentValue(memberId, MemberAttrType.organization.getAttrKey());
    if(values!=null&&values.size()>0){
      ConditionGroup<SysMember> build = ConditionGroup.build();
      build.addCondition("id", ConditionEnum.OPERATE_IN, (Serializable) values);
      return getDao().findAll(build, Sort.by(Sort.Direction.ASC,"memberName"));
    }
    return Lists.newArrayList();
  }

  public List<Region> queryAuthMemberRegionsById(String id) {
    List<SysMember> members = queryAuthMembersById(id);
    Set<String> collect = members.stream().map(sysMember -> sysMember.getRegionId()).collect(Collectors.toSet());
    return regionService.findAllById(collect);
  }

  public enum CountType {
    NONE
  }
}