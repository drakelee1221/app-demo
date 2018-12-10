

package com.drakelee.demo.common.token.user;



import com.base.components.common.token.TokenCacheObj;

import java.io.Serializable;
import java.util.Date;

/**
 * 注册用户登录token对象
 *
 * @author <a href="ligeng@xianyunsoft.com">Ligeng</a>
 * @version 1.0.0, 2017-06-30
 */
public class UserToken implements TokenCacheObj {
  private static final long serialVersionUID = 1L;
  /**
   * user id
   */
  private String userId;

  /**
   * 手机号
   */
  private String phone;

  /**
   * 昵称
   */
  private String userNickName;

  /**
   * 登录时间
   */
  private Date loginTime;

  /**
   * 用户类型
   */
  private Integer type;

  /**
   * 用户类型名称
   */
  private String typeName;

  /**
   * 微信头像
   */
  private String wxImg;

  /**
   * 微信昵称
   */
  private String wxName;

  /**
   * 用户头像
   */
  private String avatar;

  public String getTypeName() {
    return typeName;
  }

  public void setTypeName(String typeName) {
    this.typeName = typeName;
  }

  /**
   * token
   */
  private String token;

  public String getWxImg() {
    return wxImg;
  }

  public void setWxImg(String wxImg) {
    this.wxImg = wxImg;
  }

  public String getWxName() {
    return wxName;
  }

  public void setWxName(String wxName) {
    this.wxName = wxName;
  }

  public String getAvatar() {
    return avatar;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getUserNickName() {
    return userNickName;
  }

  public void setUserNickName(String userNickName) {
    this.userNickName = userNickName;
  }

  public Integer getType() {
    return type;
  }

  public void setType(Integer type) {
    this.type = type;
  }

  public Date getLoginTime() {
    return loginTime;
  }

  public void setLoginTime(Date loginTime) {
    this.loginTime = loginTime;
  }

  @Override
  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }

  @Override
  public Serializable objId() {
    return userId;
  }
}
