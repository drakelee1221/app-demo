package com.drakelee.demo.admin.dto.fancytree;

import com.base.components.common.util.JsonUtils;

import java.io.IOException;
import java.util.Collection;


/**
 * @Description FancyTree Node对象
 * @author DLee
 * @param <T>
 */
public class TreeNodeData<T> {
  private String title;
  private String key;
  private String refKey;
  private boolean expanded;
  private boolean folder;
  private boolean hideCheckbox;
  private boolean lazy;
  private boolean selected;
  private boolean unselectable;
  private Collection<TreeNodeData<T>> children;
  private String tooltip;
  private String extraClasses;
  private String icon;
  private String iconclass;
  private boolean checkbox;
  private boolean radiogroup;
  private T data;

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getKey() {
    return key;
  }

  public void setKey(String key) {
    this.key = key;
  }

  public String getRefKey() {
    return refKey;
  }

  public void setRefKey(String refKey) {
    this.refKey = refKey;
  }

  public boolean isExpanded() {
    return expanded;
  }

  public void setExpanded(boolean expanded) {
    this.expanded = expanded;
  }

  public boolean isFolder() {
    return folder;
  }

  public void setFolder(boolean folder) {
    this.folder = folder;
  }

  public boolean isHideCheckbox() {
    return hideCheckbox;
  }

  public void setHideCheckbox(boolean hideCheckbox) {
    this.hideCheckbox = hideCheckbox;
  }

  public boolean isLazy() {
    return lazy;
  }

  public void setLazy(boolean lazy) {
    this.lazy = lazy;
  }

  public boolean isSelected() {
    return selected;
  }

  public void setSelected(boolean selected) {
    this.selected = selected;
  }

  public boolean isUnselectable() {
    return unselectable;
  }

  public void setUnselectable(boolean unselectable) {
    this.unselectable = unselectable;
  }

  public Collection<TreeNodeData<T>> getChildren() {
    return children;
  }

  public void setChildren(Collection<TreeNodeData<T>> children) {
    this.children = children;
  }

  public String getTooltip() {
    return tooltip;
  }

  public void setTooltip(String tooltip) {
    this.tooltip = tooltip;
  }

  public String getExtraClasses() {
    return extraClasses;
  }

  public void setExtraClasses(String extraClasses) {
    this.extraClasses = extraClasses;
  }

  public String getIcon() {
    return icon;
  }

  public void setIcon(String icon) {
    this.icon = icon;
  }

  public String getIconclass() {
    return iconclass;
  }

  public void setIconclass(String iconclass) {
    this.iconclass = iconclass;
  }

  public T getData() {
    return data;
  }

  public void setData(T data) {
    this.data = data;
  }

  public String toJSON() {
    try {
      return JsonUtils.toString(this);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  public static String toJSON(Collection<TreeNodeData<?>> nodeDatas) {
    try {
      return JsonUtils.toString(nodeDatas);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  public boolean isCheckbox() {
    return checkbox;
  }

  public void setCheckbox(boolean checkbox) {
    this.checkbox = checkbox;
  }

  public boolean isRadiogroup() {
    return radiogroup;
  }

  public void setRadiogroup(boolean radiogroup) {
    this.radiogroup = radiogroup;
  }
}