package com.drakelee.demo.common.constants.weChat;

import org.apache.commons.lang3.StringUtils;

/**
 * WxMsgTemplate
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-16 16:08
 */
public enum WxMsgTemplate {
  /**
   * 新工单提醒
   */
  ORDER_SAVE("ywmzuYwbnAiCI2kut4-VikR1W-VTQHn1jUSIQA9-vsI","下单"),
  /**
   * 审核结果通知
   */
  SUPPLY_DEMAND_PASS("VWMqgH9wvyuYPodbV0LnljaQfnGKqO6SK37RwG7Qgas","供需审核通过"),
  /**
   * 新订单通知
   */
  SUBMIT_INTENTION("iRJAh3xCYBWXjM8dyfbAbambSMmHF9_N_Hjltmju3Ms","供需提交意向"),
  /**
   * 客户咨询通知
   */
  CONSULT_RECEIVED("_vCzc2o_CbYfLRpGrwCMygVap9WggkQQFY77p2op3fI","收到咨询"),
  /**
   * 反馈结果通知
   */
  CONSULT_REPLY("S3GGYFMzsyO3ZzZY8c0q4rHlQsFVJ0pBgwJm3qcdVKs","咨询回复"),
  /**
   * 新评价通知
   */
  EVALUATE_EMPLOYEE("2nybgt4nwUaPU6hRomOcsOoaLkfpLKzID0yjcwn061Q","评价"),
  /**
   * 服务进度通知
   */
  ADD_SERVICE_LOG("RnVw5qcTD-_k1eAAEi3KnET067DrxdDqCLDUAp-fj34","添加服务日志"),
  /**
   * 用户登录提醒
   */
  USER_LOGIN("e0liIHkqJEKG3AJokPD5kU3jHhKw_wTeTFcl_Ya-TZY","用户登录"),
  /**
   * 服务派单提醒
   */
  CALL_ME_DEAL("gO8ssZC3mT9YEgoMyGzOJbluoeKipJ9TQXObMtN81jA","callme处理"),
  /**
   * 服务派单提醒
   */
  CALL_ME_AUTO_DEAL("gO8ssZC3mT9YEgoMyGzOJbluoeKipJ9TQXObMtN81jA","callme自动处理"),
  /**
   * 服务申请通知
   */
  TRANSFORM_ORDER("-ujsJtcVCuV1oDQIjfftqFzjA_aJEnipFv8GJRZjSbw","转移订单"),
  /**
   * 申请审批提醒
   */
  SERVICE_START("qqKE354t0qVmr0xdSMrACxRQjoJm15_aYR3BiCmjiIU","开始服务"),
  SERVICE_REJECT("qqKE354t0qVmr0xdSMrACxRQjoJm15_aYR3BiCmjiIU","驳回"),
  REQUEST_REFUND("GmL3erWeG1f8jO-A2yi0Wo1IJofO6Na2BWmJrgt0VRQ","申请退款"),
  CONFIRM_REFUND("dnKU8Y2jB8hMxxhQuLxa7FGP8W0Y_NNHR0a8V81lkJw","确认退款"),
  REFUSE_REFUND("eEUd4tTkkXBFAOcwWBZ2Fb72GIIwoIcu-TN7L40KzdY","拒绝退款");
  private String templateId;
  private String desc;
  WxMsgTemplate(String templateId,String desc) {
    this.templateId = templateId;
    this.desc = desc;
  }

  public String getTemplateId() {
    return templateId;
  }

  public String getDesc() {
    return desc;
  }

  public static WxMsgTemplate parse(String template) {
    if (StringUtils.isNotBlank(template)) {
      for (WxMsgTemplate wxMsgTemplate : values()) {
        if (wxMsgTemplate.toString().equalsIgnoreCase(template)) {
          return wxMsgTemplate;
        }
      }
    }
    return null;
  }
}
