

package com.drakelee.demo.admin.service.auth;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.constants.auth.ReadOrWrite;
import com.drakelee.demo.admin.constants.auth.ReadOrWrite;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.domain.admin.SysAppInfo;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.database.dao.admin.SysAppInfoDao;

import java.util.List;

/**
 * @author DLee
 */
public class AppInfoNodeBuilder {

  @SuppressWarnings({"rawtypes", "unchecked"})
  public static TreeNodeData<SysAppInfo> buildNode(SysAppInfo entity, List<String> selectIds) {
    TreeNodeData node = new TreeNodeData();
    if (SysAppInfoDao.ROOT_PARENT.equals(entity.getParentId()) || SysAppInfoDao.ROOT.equals(entity.getParentId())) {
      node.setFolder(false);
      if ((entity.getRightVal() - entity.getLeftVal() - 1) / 2 > 0) {
        node.setFolder(true);
        node.setLazy(true);
        node.setExpanded(true);
      }
    } else {
      node.setFolder(false);
      if ((entity.getRightVal() - entity.getLeftVal() - 1) / 2 > 0) {
        node.setFolder(true);
        node.setLazy(true);
      }
    }
    ReadOrWrite rw = EnumUtil.parse(ReadOrWrite.class, "value", entity.getReadWriteType());
    node.setTooltip((rw == null ? "": rw.getName()+" - ") + entity.getDescription());
    node.setIconclass(entity.getIconClass());
    node.setExtraClasses(SysAppInfoDao.ROOT_PARENT.equals(entity.getParentId()) ? "root":"");
    if (Valid.TRUE.getVal() == entity.getDirectory()) {
      node.setExtraClasses(node.getExtraClasses() + " directory");
    }else{
      node.setExtraClasses(node.getExtraClasses() + " item");
    }
    if (entity.getStatus() == Valid.FALSE.getVal()) {
      node.setExtraClasses(node.getExtraClasses() + " ui-state-disabled");
    }
    node.setRefKey(entity.getId());
    node.setKey(entity.getId());
    String parentId = null;
    if (entity.getParentId() != null) {
      parentId = entity.getParentId();
    }
    ObjectNode data = JsonUtils.convert(entity, ObjectNode.class);
    if (entity.getParentId() != null) {
      data.put("parentId", parentId);
    }
    node.setData(data);
    node.setTitle(entity.getName());
    if (selectIds != null && selectIds.contains(entity.getId())) {
      node.setSelected(true);
    }
    return node;
  }
}
