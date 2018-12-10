

package com.drakelee.demo.common.token;

/**
 * Token常量
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-11 15:32
 */
public interface TokenConstant {
  /**
   * user token 的 key
   */
  String USER_TOKEN_KEY = "token";
  /**
   * 后台 token 的 key
   */
  String USER_MEMBER_TOKEN_KEY = "member_token";
  /**
   * 客服人员 token 的 key
   */
  String USER_CS_TOKEN_KEY = "cs_token";
  /**
   * 传递注册用户对象对应的key
   */
  String USER_TOKEN_RECEIVE_KEY = "_user_token_json_";
  /**
   * 传递客户经理用户对象对应的key
   */
  String USER_MANAGER_TOKEN_RECEIVE_KEY = "_user_manager_token_json_";
  /**
   * 传递服务专员用户对象对应的key
   */
  String USER_SERVICE_TOKEN_RECEIVE_KEY = "_user_service_token_json_";
  /**
   * 传递业务专家用户对象对应的key
   */
  String USER_EXPERT_TOKEN_RECEIVE_KEY = "_user_expert_token_json_";

  /**
   * 传递后台用户对象对应的key
   */
  String USER_MEMBER_TOKEN_RECEIVE_KEY = "_user_member_token_json_";

  /**
   * 传递客服人员对象对应的key
   */
  String USER_CS_TOKEN_RECEIVE_KEY = "_user_cs_token_json_";

  /**
   * 传递分销渠道人员对象对应的key
   */
  String DISTRIBUTION_USER_TOKEN_RECEIVE_KEY = "_distribution_user_token_json_";

  /**
   * 传递分销渠道管理员员对象对应的key
   */
  String DISTRIBUTION_ADMIN_TOKEN_RECEIVE_KEY = "_distribution_admin_token_json_";

}
