

package com.drakelee.demo.admin.constants.auth;

import org.springframework.web.bind.annotation.RequestMethod;

/**
 * ReadOrWrite
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-04 9:13
 */
public enum  ReadOrWrite {
  ReadAndWrite(0, "读写"),
  Read(1, "只读"),
  write(2, "只写"),

  ;
  private final int value;
  private final String name;

  private static final String GET_METHOD = RequestMethod.GET.toString();

  ReadOrWrite(int value, String name) {
    this.value = value;
    this.name = name;
  }

  public int getValue() {
    return value;
  }

  public String getName() {
    return name;
  }

  public boolean checkRequestMethod(String requestMethod){
    if(value == ReadAndWrite.value){
      return true;
    }
    if(value == Read.value && GET_METHOD.equalsIgnoreCase(requestMethod)){
      return true;
    }
    if(value == write.value && !GET_METHOD.equalsIgnoreCase(requestMethod)){
      return true;
    }
    return false;
  }
}
