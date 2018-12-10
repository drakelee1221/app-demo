package com.drakelee.demo.pm.controller.sys;

import com.drakelee.demo.pm.service.sys.SysMessageService;
import com.base.components.common.constants.Valid;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.sys.SysMessage;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.pm.service.sys.SysMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * SysMessageController
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-27 16:38
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
public class SysMessageController {
  @Autowired
  private SysMessageService sysMessageService;

  /**
   * 未读消息数量
   *
   * @return
   */
  @GetMapping("/sys/message/count")
  public ResponseEntity messageCount() {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    int count = sysMessageService.countUnReadMessage(userId);
    Map<String, Integer> data = new HashMap<>();
    data.put("count", count);
    return new ResponseEntity<>(data, HttpStatus.OK);
  }

  /**
   * 消息列表
   *
   * @return
   */
  @GetMapping("/sys/message/page")
  public ResponseEntity queryMessages(@RequestParam Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    ConditionGroup<SysMessage> build = ConditionGroup.build()
                                                     .addCondition("userId", ConditionEnum.OPERATE_EQUAL, userId)
                                                     .addCondition("delFlag", ConditionEnum.OPERATE_EQUAL,
                                                                   Valid.TRUE.getVal()
                                                     );
    Sort.Order status = Sort.Order.asc("status");
    Sort.Order createTime = Sort.Order.desc("createTime");
    Pageable pageable = Pages.Helper.pageable(params, Sort.by(status, createTime));

    DataPage<SysMessage> data = DataPage.from(sysMessageService.findAll(build, pageable));
    return new ResponseEntity<>(data, HttpStatus.OK);
  }

  /**
   * 设置消息已读
   *
   * @param msgId
   *
   * @return
   */
  @PutMapping("/sys/message/read")
  public ResponseEntity setReadStatus(@RequestParam("msgId") String msgId) {
    sysMessageService.updateReadStatus(msgId);
    return new ResponseEntity(HttpStatus.OK);
  }

  /**
   * 设置所有消息已读
   *
   * @return
   */
  @PutMapping("/sys/message/read-all")
  public ResponseEntity readAllMessage() {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    sysMessageService.readAllMessage(userId);

    return new ResponseEntity(HttpStatus.OK);
  }

  /**
   * 删除消息
   *
   * @param id
   *
   * @return
   */
  @DeleteMapping("/sys/message/{id}")
  public ResponseEntity deleteMessage(@PathVariable("id") String id) {
    sysMessageService.deleteMessage(id);
    return new ResponseEntity(HttpStatus.OK);
  }
}
