package com.drakelee.demo.common.constants.admin;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用作统一管理后台特殊权限的代码
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/6/12 0012 17:27
 */
public enum AuthCode {
  /**
   * 后台查看私有资源的权限
   */
  PRIVATE_ATTACHMENT_AUTH("后台查看私有资源的权限"),

  /**
   * 后台查看所有订单的权限
   */
  SUPER_ORDER_ROLE("后台查看所有订单的权限"),

  /**
   * 后台查看所有服务的权限
   */
  SUPER_SERVICE_ROLE("后台查看所有服务的权限"),
  /**
   * 线下充值录入权限
   */
  OFFLINE_RECHARGE_IN("线下充值录入权限"),
  /**
   * 线下充值审核权限
   */
  OFFLINE_RECHARGE_AUDIT("线下充值审核权限"),
  ORDER_MANAGER_MODIFY("订单客户经理修改权限"),
  ORDER_SERVICE_MODIFY("订单服务人员修改权限"),

  SENSITIVE_DATA_AUTH("敏感数据查看权限（如：客户手机号码等）")
  ;

  private String desc;

  AuthCode(String desc){
    this.desc = desc;
  }

  public static List<Map> getCodes(){
    ArrayList<Map> list = Lists.newArrayList();
    for (AuthCode authCode : values()) {
      HashMap<String, String> map = Maps.newHashMap();
      map.put("key", authCode.toString());
      map.put("val", authCode.getDesc());
      list.add(map);
    }
    return list;
  }

  public String getDesc(){
    return desc;
  }
}
