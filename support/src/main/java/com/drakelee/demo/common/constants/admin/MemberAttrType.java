package com.drakelee.demo.common.constants.admin;

/**
 * 成员属性类型
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/4/8 0008 14:54
 */
public enum MemberAttrType {

  organization("organization", "组织机构"),
  ;
  private String attrKey;
  private String attrName;

  public String getAttrKey() {
    return attrKey;
  }

  public String getAttrName() {
    return attrName;
  }

  MemberAttrType(String attrKey, String attrName){
    this.attrKey = attrKey;
    this.attrName = attrName;
  }

}
