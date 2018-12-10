

package com.drakelee.demo.admin.dto.member;

import com.base.components.common.constants.Valid;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;

/**
 * TreeParam
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-17 15:23
 */
public class TreeParam implements Serializable {
  private static final long serialVersionUID = -3393679912300351722L;
  private boolean isDisabled = false;
  private boolean isLazy = true;
  private boolean rootSelected = true;
  private boolean multiple = true;
  private String[] roots = new String[0];
  private String nodeId = "";
  private String showNodeId = "";
  private String treeKind = "";

  public TreeParam(HttpServletRequest request) {
    String roots = request.getParameter("roots");
    String disabled = request.getParameter("isDisabled");
    String selectRoot = request.getParameter("selectRoot");
    String nodeId = request.getParameter("nodeId");
    String showNodeId = request.getParameter("showNodeId");
    String treeKind = request.getParameter("treeKind");
    String isLazy = request.getParameter("isLazy");
    boolean tmpFreeze = false;
    if (disabled != null && (Boolean.TRUE.toString().equalsIgnoreCase(disabled) || String.valueOf(Valid.TRUE.getVal())
                                                                                         .equals(disabled) || "yes"
      .equalsIgnoreCase(disabled))) {
      tmpFreeze = true;
    }
    boolean tmpSelectRoot = false;
    if (selectRoot != null && (Boolean.TRUE.toString().equalsIgnoreCase(selectRoot) || String
      .valueOf(Valid.TRUE.getVal()).equals(selectRoot) || "yes".equalsIgnoreCase(selectRoot))) {
      tmpSelectRoot = true;
    }

    boolean tmpIsLazy = true;
    if (isLazy != null && (Boolean.FALSE.toString().equalsIgnoreCase(isLazy) || String
      .valueOf(Valid.FALSE.getVal()).equals(isLazy) || "no".equalsIgnoreCase(isLazy))) {
      tmpIsLazy = false;
    }

    this.isDisabled = tmpFreeze;
    this.rootSelected = tmpSelectRoot;
    this.isLazy = tmpIsLazy;
    this.nodeId = nodeId;
    this.showNodeId = showNodeId;
    this.treeKind = treeKind;
    if (StringUtils.isNotBlank(roots)) {
      this.roots = StringUtils.split(roots, ";");
    }
  }

  public boolean isDisabled() {
    return isDisabled;
  }

  public void setDisabled(boolean disabled) {
    isDisabled = disabled;
  }

  public boolean isRootSelected() {
    return rootSelected;
  }

  public void setRootSelected(boolean rootSelected) {
    this.rootSelected = rootSelected;
  }

  public boolean isMultiple() {
    return multiple;
  }

  public void setMultiple(boolean multiple) {
    this.multiple = multiple;
  }

  public String[] getRoots() {
    return roots;
  }

  public void setRoots(String[] roots) {
    this.roots = roots;
  }

  public String getNodeId() {
    return nodeId;
  }

  public void setNodeId(String nodeId) {
    this.nodeId = nodeId;
  }

  public String getShowNodeId() {
    return showNodeId;
  }

  public void setShowNodeId(String showNodeId) {
    this.showNodeId = showNodeId;
  }

  public String getTreeKind() {
    return treeKind;
  }

  public void setTreeKind(String treeKind) {
    this.treeKind = treeKind;
  }

  public boolean isLazy() {
    return isLazy;
  }

  public void setLazy(boolean lazy) {
    isLazy = lazy;
  }
}
