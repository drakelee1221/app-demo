

package com.drakelee.demo.common.constants.admin;

import java.io.Serializable;

/**
 * MemberType
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-17 10:57
 */
public enum MemberType implements Serializable{

  DEPT(0, "部门"),
  PERSON(1, "员工")
  ;
  private int type;
  private String name;

  MemberType(int type, String name) {
    this.type = type;
    this.name = name;
  }

  public int getType() {
    return type;
  }

  public String getName() {
    return name;
  }
}
