package com.drakelee.demo.common.token.user;

import com.base.components.common.token.TokenCacheObj;

import java.io.Serializable;

/**
 * UserMemberToken
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-29 13:39
 */
public class UserMemberToken implements TokenCacheObj {
  private static final long serialVersionUID = 1L;
  /**
   * user id
   */
  private String id;

  /**
   * 手机号
   */
  private String account;
  private String memberName;
  private Integer memberType;
  private String token;

  @Override
  public Serializable objId() {
    return id;
  }

  @Override
  public String getToken() {
    return token;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getAccount() {
    return account;
  }

  public void setAccount(String account) {
    this.account = account;
  }

  public String getMemberName() {
    return memberName;
  }

  public void setMemberName(String memberName) {
    this.memberName = memberName;
  }

  public Integer getMemberType() {
    return memberType;
  }

  public void setMemberType(Integer memberType) {
    this.memberType = memberType;
  }

  public void setToken(String token) {
    this.token = token;
  }
}
