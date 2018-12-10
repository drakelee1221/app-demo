

package com.drakelee.demo.admin.service.auth;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.constants.auth.ReadOrWrite;
import com.drakelee.demo.admin.constants.auth.ReadOrWrite;
import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.base.components.common.constants.Valid;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.database.dao.admin.SysAppInfoDao;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * @author DLee
 */
public class AppInfoMapBuilder {

  @SuppressWarnings({"rawtypes", "unchecked"})
  public static TreeNodeData<Map<String, Object>> buildNode(Map<String, Object> entity, List<String> selectIds) {
    TreeNodeData node = new TreeNodeData();
    ReadOrWrite rw = EnumUtil.parse(ReadOrWrite.class, "value",
                                    ConvertUtil.convert(entity.get("readWriteType"), Integer.class));
    node.setTooltip((rw == null ? "": rw.getName()+" - ") + ConvertUtil.convert(entity.get("description"), ""));
    node.setFolder(false);
    node.setLazy(false);
    if ((ConvertUtil.convert(entity.get("rightVal"), Integer.class)
      - ConvertUtil.convert(entity.get("leftVal"), Integer.class) - 1) / 2 > 0) {
      node.setFolder(true);
      node.setExpanded(true);
    }
    node.setIconclass(ConvertUtil.convert(entity.get("iconClass"), String.class));
    boolean isRoot = SysAppInfoDao.ROOT_PARENT.equals(ConvertUtil.convert(entity.get("parentId"), String.class));
    if(isRoot){
      node.setHideCheckbox(true);
      node.setUnselectable(true);
    }
    node.setExtraClasses(isRoot ? "root":"");
    if (Valid.TRUE.getVal() == ConvertUtil.convert(entity.get("directory"), Integer.class)) {
      node.setExtraClasses(node.getExtraClasses() + " directory");
    }else{
      node.setExtraClasses(node.getExtraClasses() + " item");
    }
    if (ConvertUtil.convert(entity.get("status"), Integer.class) == Valid.FALSE.getVal()) {
      node.setExtraClasses(node.getExtraClasses() + " ui-state-disabled");
    }
    node.setRefKey(ConvertUtil.convert(entity.get("id"), String.class));
    node.setKey(node.getRefKey());
    ObjectNode data = JsonUtils.convert(entity, ObjectNode.class);
    node.setData(data);
    node.setTitle(ConvertUtil.convert(entity.get("name"), String.class));
    if(StringUtils.isNotBlank(ConvertUtil.convert(entity.get("roleId"), String.class))){
      node.setSelected(true);
    }
    return node;
  }
}
