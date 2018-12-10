

package com.drakelee.demo.admin.service.auth;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.constants.admin.MemberType;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.database.dao.admin.SysMemberDao;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * @author DLee
 */
public class MemberMapBuilder {

  @SuppressWarnings({"rawtypes", "unchecked"})
  public static TreeNodeData<Map<String, Object>> buildNode(Map<String, Object> entity, List<String> selectIds) {
    TreeNodeData node = new TreeNodeData();
    node.setFolder(false);
    node.setLazy(false);
    boolean isRoot = SysMemberDao.ROOT_PARENT.equals(ConvertUtil.convert(entity.get("parentId"), String.class));
    if(isRoot){
      node.setHideCheckbox(true);
      node.setUnselectable(true);
    }
    if ((ConvertUtil.convert(entity.get("rightVal"), Integer.class)
      - ConvertUtil.convert(entity.get("leftVal"), Integer.class) - 1) / 2 > 0) {
      node.setFolder(true);
      node.setExpanded(true);
    }
    node.setExtraClasses(isRoot ? "root item":"item");
    node.setIconclass("fa fa-user");
    if (MemberType.DEPT.getType() == ConvertUtil.convert(entity.get("memberType"), Integer.class)) {
      node.setIconclass("fa fa-group");
      node.setExtraClasses(node.getExtraClasses() + " directory");
      node.setHideCheckbox(true);
      node.setUnselectable(true);
    }
    if (ConvertUtil.convert(entity.get("status"), Integer.class) == Valid.FALSE.getVal()) {
      node.setExtraClasses(node.getExtraClasses() + " ui-state-disabled");
    }
    node.setRefKey(ConvertUtil.convert(entity.get("id"), String.class));
    node.setKey(node.getRefKey());
    ObjectNode data = JsonUtils.convert(entity, ObjectNode.class);
    node.setData(data);
    node.setTitle(ConvertUtil.convert(entity.get("memberName"), String.class));
    if(StringUtils.isNotBlank(ConvertUtil.convert(entity.get("roleId"), String.class))){
      node.setSelected(true);
    }
    return node;
  }
}
