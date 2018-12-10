

package com.drakelee.demo.admin.service.tree;

import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;

import java.util.List;

/**
 * NodeBuilder
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-09 14:29
 */
public interface NodeBuilder<T> {

  TreeNodeData<T> buildNode(T entity, List<String> selectIds, TreeParam treeParam);
}
