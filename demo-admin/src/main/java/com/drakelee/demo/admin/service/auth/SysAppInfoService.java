

package com.drakelee.demo.admin.service.auth;

import com.codingapi.tx.annotation.TxTransaction;
import com.google.common.collect.Lists;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.domain.admin.SysAppInfo;
import com.base.components.common.util.NestedSetModel;
import com.base.components.common.util.Relationship;
import com.drakelee.demo.database.dao.admin.SysAppInfoDao;
import com.base.components.database.dao.base.GenericJpaDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

/**
 * SysAppInfoService
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-17
 */
@Service
public class SysAppInfoService extends AbstractJpaService<SysAppInfo, String, SysAppInfoDao> {

  public List<TreeNodeData<SysAppInfo>> loadTreeNodes(TreeParam treeParam){
    List<TreeNodeData<SysAppInfo>> nodes = Lists.newArrayList();
    boolean isRoot = true;
    if(StringUtils.isNotBlank(treeParam.getNodeId()) || treeParam.getRoots().length>0){
      isRoot = false;
    }
    addNodes(nodes, isRoot, treeParam);
    return nodes;
  }

  @TxTransaction(rollbackFor = Exception.class)
  public SysAppInfo updateAppInfo(SysAppInfo appInfo) throws IllegalArgumentException{
    Assert.isTrue(appInfo != null && StringUtils.isNotBlank(appInfo.getId()), "未找到应用信息！");
    SysAppInfo exists = findById(appInfo.getId());
    Assert.notNull(exists, "未找到应用信息！");
    checkDirectory(appInfo);
    appInfo.setLeftVal(exists.getLeftVal());
    appInfo.setRightVal(exists.getRightVal());
    appInfo.setParentId(exists.getParentId());
    appInfo = getDao().saveAndFlush(appInfo);
    return appInfo;
  }

  @Transactional(rollbackFor = Exception.class)
  public SysAppInfo addAppInfo(SysAppInfo appInfo){
    SysAppInfo parent = findById(appInfo.getParentId());
    Assert.notNull(parent, "未找到父节点！");
    Assert.isTrue(Valid.TRUE.getVal() == parent.getDirectory(), "只能在目录节点添加应用");
    checkDirectory(appInfo);
    int[] val = NestedSetModel.insert(parent.getLeftVal(), parent.getRightVal(), Relationship.ChildLast);
    getEntityManager().createQuery(
      "update SysAppInfo m set m.leftVal = m.leftVal + 2 WHERE m.leftVal > :leftVal")
                 .setParameter("leftVal", val[0]).executeUpdate();
    getEntityManager().createQuery(
      "update SysAppInfo m set m.rightVal = m.rightVal + 2 WHERE m.rightVal > :rightVal")
                 .setParameter("rightVal", val[0]).executeUpdate();
    appInfo.setLeftVal(val[1]);
    appInfo.setRightVal(val[1] + 1);
    appInfo.setStatus(Valid.TRUE.getVal());
    appInfo.setId(null);
    appInfo = getDao().saveAndFlush(appInfo);
    return appInfo;
  }

  private void checkDirectory(SysAppInfo appInfo){
    if(appInfo.getDirectory() == Valid.FALSE.getVal()){
      if(StringUtils.isBlank(appInfo.getTargetUrl()) || "/".equals(appInfo.getTargetUrl())
        || StringUtils.isBlank(appInfo.getAuthUrlPrefix()) || "/".equals(appInfo.getAuthUrlPrefix())){
        throw new IllegalArgumentException("跳转路径和授权uri前缀，不能为空且不等于“/” !");
      }
    }
    else{
      appInfo.setTargetUrl(null);
      appInfo.setAuthUrlPrefix(null);
    }
  }

  @Transactional(rollbackFor = Exception.class)
  public void delete(String id) throws IllegalArgumentException{
    SysAppInfo appInfo = findById(id);
    Assert.isTrue(appInfo.getLeftVal() > 1, "can not delete root member !");
    int[] val = NestedSetModel.delete(appInfo.getLeftVal(), appInfo.getRightVal());
    getEntityManager().createQuery(
      "delete from SysAppInfo m WHERE m.leftVal >= :leftVal and m.rightVal <= :rightVal")
                 .setParameter("leftVal", val[0])
                 .setParameter("rightVal", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "update SysAppInfo m set m.leftVal = m.leftVal - :VAL1  WHERE m.leftVal > :VAL2")
                 .setParameter("VAL1", val[1] - val[0] + 1)
                 .setParameter("VAL2", val[0]).executeUpdate();
    getEntityManager().createQuery(
      "update SysAppInfo m set m.rightVal = m.rightVal - :VAL1 WHERE m.rightVal > :VAL2")
                 .setParameter("VAL1", val[1] - val[0] + 1)
                 .setParameter("VAL2", val[1]).executeUpdate();
  }


  @Transactional(rollbackFor = Exception.class)
  public void updateToMove(String srcId, String targetId, String hitMode) throws IllegalArgumentException{
    SysAppInfo src = findById(srcId);
    Assert.notNull(src, "源节点信息未找到");
    SysAppInfo target = findById(targetId);
    Assert.notNull(src, "目标节点信息未找到");
    Assert.isTrue(src.getLeftVal() > 1 && target.getLeftVal() > 1, "root element can not be move !");
    int[] val;
    boolean moveToChild = false;
    if (Relationship.After.toString().equalsIgnoreCase(hitMode)) {
      val = NestedSetModel.update(target.getLeftVal(),
                                   target.getRightVal(), src.getLeftVal(), src.getRightVal(),
                                   Relationship.After);
    }
    else if (Relationship.Before.toString().equalsIgnoreCase(hitMode)) {
      val = NestedSetModel.update(target.getLeftVal(),
                                   target.getRightVal(), src.getLeftVal(), src.getRightVal(),
                                   Relationship.Before);
    }
    //over
    else {
      moveToChild = true;
      val = NestedSetModel.update(target.getLeftVal(),
                                   target.getRightVal(), src.getLeftVal(), src.getRightVal(),
                                   Relationship.ChildLast);
    }
    getEntityManager().createQuery(
      "UPDATE SysAppInfo m SET m.leftVal = m.leftVal * -1, m.rightVal = m.rightVal * -1 WHERE m.leftVal >= :VAL1 and m.leftVal <= :VAL2")
                 .setParameter("VAL1", src.getLeftVal())
                 .setParameter("VAL2", src.getRightVal()).executeUpdate();
    getEntityManager().createQuery(
      "UPDATE SysAppInfo m SET m.leftVal = m.leftVal + :VAL1 WHERE m.leftVal > :VAL2 and m.leftVal < :VAL3")
                 .setParameter("VAL1", val[3]).setParameter("VAL2", val[0])
                 .setParameter("VAL3", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "UPDATE SysAppInfo m SET m.rightVal = m.rightVal + :VAL1 WHERE m.rightVal > :VAL2 and m.rightVal < :VAL3")
                 .setParameter("VAL1", val[3]).setParameter("VAL2", val[0])
                 .setParameter("VAL3", val[1]).executeUpdate();
    getEntityManager().createQuery(
      "UPDATE SysAppInfo m SET m.leftVal = (m.leftVal * -1 + :VAL1), m.rightVal = (m.rightVal * -1 + :VAL2) WHERE m.leftVal <= (:VAL3 * -1) and m.rightVal >= (:VAL4 * -1)")
                 .setParameter("VAL1", val[2]).setParameter("VAL2", val[2])
                 .setParameter("VAL3", src.getLeftVal())
                 .setParameter("VAL4", src.getRightVal()).executeUpdate();
    String parentId = moveToChild ? target.getId() : target.getParentId();
    getEntityManager().createQuery("UPDATE SysAppInfo m set m.parentId = :parentId where m.id = :id")
                      .setParameter("parentId", parentId).setParameter("id", src.getId()).executeUpdate();
  }








  private void addNodes(List<TreeNodeData<SysAppInfo>> nodes , boolean isRoot , TreeParam params){
    List<SysAppInfo> list;
    if(isRoot){
      list = getDao().findRoots();
      for(SysAppInfo entity : list){
        TreeNodeData<SysAppInfo> node = AppInfoNodeBuilder.buildNode(entity, null);
        List<TreeNodeData<SysAppInfo>> children = Lists.newArrayList();
        for(SysAppInfo child : getDao().findByParentIdOrderByLeftVal(entity.getId())){
          TreeNodeData<SysAppInfo> first = AppInfoNodeBuilder.buildNode(child, null);
          //直接展开第三级
          List<TreeNodeData<SysAppInfo>> firstChildren = Lists.newArrayList();
          for(SysAppInfo firstChild : getDao().findByParentIdOrderByLeftVal(child.getId())){
            firstChildren.add(AppInfoNodeBuilder.buildNode(firstChild, null));
          }
          first.setChildren(firstChildren);
          children.add(first);
        }
        node.setChildren(children);
        nodes.add(node);
      }
    }else{
      String[] roots = params.getRoots();
      if(roots.length > 0 ){
        for(String root : roots){
          SysAppInfo parent = findById(root);
          TreeNodeData<SysAppInfo> parentNode = AppInfoNodeBuilder.buildNode(parent, null);
          addChildren(parentNode,parent,params);
          nodes.add(parentNode);
        }
      }else{
        list = getDao().findByParentIdOrderByLeftVal(params.getNodeId());
        for(SysAppInfo entity : list){
          TreeNodeData<SysAppInfo> node = AppInfoNodeBuilder.buildNode(entity, null);
          nodes.add(node);
        }
      }
    }
  }

  private void addChildren(TreeNodeData<SysAppInfo> parentNode, SysAppInfo parent, TreeParam params){
    List<TreeNodeData<SysAppInfo>> children = Lists.newArrayList();
    for(SysAppInfo child : getDao().findByParentIdOrderByLeftVal(parent.getId())){
      children.add(AppInfoNodeBuilder.buildNode(child, null));
    }
    parentNode.setChildren(children);
  }
}