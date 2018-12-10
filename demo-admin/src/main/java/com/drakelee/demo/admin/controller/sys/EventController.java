package com.drakelee.demo.admin.controller.sys;

import com.base.components.common.constants.msgqueue.Channel;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.service.sys.MessageEventService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.msgqueue.SysMessageEventError;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * EventController
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-26 16:23
 */
@Controller
@RequestMapping(GatewayPath.ADMIN)
public class EventController {
  @Autowired
  private MessageEventService eventService;
  /**
   * 事件首页
   *
   * @param request
   * @param response
   * @param modelMap
   *
   * @return
   */
  @GetMapping("/event/index")
  public String rechargeIndex(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
    try {
      ObjectNode node = JsonUtils.createObjectNode();
      for (Channel channel : Channel.getAllChannels()) {
        node.put(channel.getId(), channel.getDesc());
      }
      modelMap.put("messageChannels", node);
   } catch (Exception ignore) {
    }
    return "sys/event/index";
  }

  @GetMapping("/event/list")
  @ResponseBody
  public ResponseEntity queryPayLogs(@RequestParam Map<String, String> params) {
    DataPage dp = eventService.queryMessageEvent(params);
    return new ResponseEntity<>(dp, HttpStatus.OK);
  }

  /**
   * 查看异常详细
   * @param params
   * @return
   */
  @GetMapping("/event/error/info")
  @ResponseBody
  public ResponseEntity getErrorInfo(@RequestParam Map<String, Object> params) {
    String messageId = ConvertUtil.checkNotNull(params, "messageId", "消息id不能为空", String.class);
    SysMessageEventError dp = eventService.getErrorInfo(messageId);
    return new ResponseEntity<>(JsonResult.success(dp), HttpStatus.OK);
  }

  /**
   * 查看事件处理page
   * @param params
   * @return
   */
  @GetMapping("/event/handle/page")
  @ResponseBody
  public ResponseEntity pageHandle(@RequestParam Map<String, String> params) {
    DataPage page = eventService.pageHandle(ConvertUtil.checkNotNull(params, "messageId", "消息id不能为空", String.class),
                                            params);
    return new ResponseEntity<>(page, HttpStatus.OK);
  }
}
