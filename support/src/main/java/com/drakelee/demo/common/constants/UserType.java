

package com.drakelee.demo.common.constants;

import com.drakelee.demo.common.token.TokenType;

/**
 * UserType
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-16 13:39
 */
public enum  UserType {

  /** 未分配角色 */
  UNKNOWN(null, 0),
  /** 普通注册用户 */
  USER(TokenType.USER_TOKEN, 1),
  /** 客户经理 */
  MANAGER(TokenType.USER_MANAGER_TOKEN, 2),
  /** 业务专员 */
  SERVICE(TokenType.USER_SERVICE_TOKEN, 3),
  /** 业务专家 */
  EXPERT(TokenType.USER_EXPERT_TOKEN, 4),
  /** 客服人员 */
  CS(TokenType.USER_CS_TOKEN, 5),

  /** 渠道分销人员 */
  DISTRIBUTION_USER(TokenType.DISTRIBUTION_USER_TOKEN, 8),
  /** 渠道分销管理员 */
  DISTRIBUTION_ADMIN(TokenType.DISTRIBUTION_ADMIN_TOKEN, 9),
  ;

  private TokenType tokenType;
  private int code;

  UserType(TokenType tokenType, int code) {
    this.tokenType = tokenType;
    this.code = code;
  }

  public TokenType getTokenType() {
    return tokenType;
  }

  public int getCode() {
    return code;
  }

  public static UserType parse(int code){
    for (UserType userType : values()) {
      if(userType.code == code){
        return userType;
      }
    }
    return null;
  }
}
