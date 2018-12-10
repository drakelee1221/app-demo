package com.drakelee.demo.common.dto.sys;

import com.drakelee.demo.common.domain.admin.SysMember;

import java.io.Serializable;

/**
 * 下属成员统计
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/7/23 0023 11:20
 */
public class SysMemberCountDto extends SysMember implements Serializable{

  private static final long serialVersionUID = 1L;

  /** 业务计数 */
  private Integer count;

  public Integer getCount() {
    return count;
  }

  public void setCount(Integer count) {
    this.count = count;
  }
}
