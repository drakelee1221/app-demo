

package com.drakelee.demo.admin.service.member;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.constants.admin.MemberType;
import com.drakelee.demo.common.domain.admin.SysMember;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.PasswordUtil;
import com.drakelee.demo.database.dao.admin.SysMemberDao;
import org.apache.commons.lang3.StringUtils;

import java.util.List;

/**
 * @author DLee
 */
public class MemberAttrNodeBuilder {

  @SuppressWarnings({"rawtypes", "unchecked"})
  public static TreeNodeData<SysMember> buildNode(SysMember entity, List<String> selectIds) {
    TreeNodeData node = new TreeNodeData();
    node.setExpanded(true);
    if (SysMemberDao.ROOT_PARENT.equals(entity.getParentId())) {
      node.setFolder(false);
      if ((entity.getRightVal() - entity.getLeftVal() - 1) / 2 > 0) {
        node.setFolder(true);
        node.setLazy(true);
      }
    } else {
      node.setFolder(false);
      if ((entity.getRightVal() - entity.getLeftVal() - 1) / 2 > 0) {
        node.setFolder(true);
        node.setLazy(true);
      }
    }
    node.setIconclass("fa fa-user");
    if (MemberType.DEPT.getType() == entity.getMemberType()) {
      node.setIconclass("fa fa-group");
    }
    if (MemberType.PERSON.getType() == entity.getMemberType()
      && StringUtils.isNotBlank(entity.getPwd()) ) {
      entity.setPwd(PasswordUtil.decryptPassword(entity.getAccount(), entity.getPwd()));
      node.setHideCheckbox(true);
    }
    if (entity.getStatus() == Valid.FALSE.getVal()) {
      node.setExtraClasses("ui-state-disabled");
    }
    node.setRefKey(entity.getId());
    node.setKey(entity.getId());
    ObjectNode data = JsonUtils.convert(entity, ObjectNode.class);
    node.setData(data);
    node.setTitle(entity.getMemberName());
    if (selectIds != null && selectIds.contains(entity.getId())) {
      node.setSelected(true);
    }
    return node;
  }
}
