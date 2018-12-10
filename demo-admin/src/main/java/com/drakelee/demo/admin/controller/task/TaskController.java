

package com.drakelee.demo.admin.controller.task;

import com.google.common.collect.Maps;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.drakelee.demo.admin.dto.common.JsonResult;
import com.base.components.common.constants.sys.Dates;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.task.SysTask;
import com.drakelee.demo.common.domain.task.SysTaskLog;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.util.ConvertUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.task.SysTaskLogDao;
import com.drakelee.demo.feign.client.task.TaskManagerClient;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * 调度作业
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-12-14 11:46
 */
@Controller
@RequestMapping(GatewayPath.ADMIN + "/task")
public class TaskController {

  @Autowired
  private SysTaskLogDao sysTaskLogDao;
  @Autowired
  private DiscoveryClient discoveryClient;
  @Autowired
  private TaskManagerClient taskManagerClient;

  @Value("${module-task}")
  private String taskServerName;

  /**
   * 管理页
   */
  @GetMapping(value = {"/", "/index"})
  public String index(ModelMap model) {
    model.put("taskServers", discoveryClient.getInstances(taskServerName));
    return "task/index";
  }

  /**
   * 修改页
   */
  @GetMapping("/edit/{id}")
  public String edit(ModelMap model, @PathVariable("id") String id) {
    Map<String, String> map = Maps.newHashMap();
    map.put("id", id);
    model.put("task", taskManagerClient.getTask(map));
    return "task/form";
  }

  /**
   * 修改
   */
  @PostMapping("/edit/{id}")
  @ResponseBody
  public ResponseEntity edit(@PathVariable("id") String id, @RequestParam Map<String, String> params) {
    params.put("taskId", id);
    taskManagerClient.updateTask(params);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.CREATED);
  }

  /**
   * 启用
   */
  @PostMapping("/enable/{id}")
  @ResponseBody
  public ResponseEntity enable(@PathVariable("id") String id, @RequestParam Map<String, String> params) {
    taskManagerClient.startTask(id, true);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.CREATED);
  }

  /**
   * 禁用
   */
  @PostMapping("/disable/{id}")
  @ResponseBody
  public ResponseEntity disable(@PathVariable("id") String id, @RequestParam Map<String, String> params) {
    taskManagerClient.pauseTask(id, true);
    return new ResponseEntity<>(JsonResult.success(), HttpStatus.CREATED);
  }

  /**
   * 立即触发
   *
   * @param id 作业ID
   * @param params -
   * <p>  argumentsMap       - Nullable - Json - 触发参数
   */
  @PostMapping("/trigger/{id}")
  @ResponseBody
  public ResponseEntity trigger(@PathVariable("id") String id, @RequestParam Map<String, String> params) {
    Map countMap = taskManagerClient.trigger(id, false, params.get("argumentsMap"));
    return new ResponseEntity<>(JsonResult.success(countMap), HttpStatus.CREATED);
  }

  /**
   * 重构同步服务
   */
  @PostMapping("/rebuild")
  @ResponseBody
  public ResponseEntity rebuild(@RequestParam Map<String, String> params) {
    Boolean result = taskManagerClient.rebuildServer(true);
    return new ResponseEntity<>(result ? JsonResult.success() : JsonResult.fail("重构同步服务失败"), HttpStatus.CREATED);
  }

  /**
   * 分页查询集合
   *
   * @param params
   *
   * @return
   */
  @GetMapping(value = {"/list"})
  @ResponseBody
  public ResponseEntity<DataPage> list(@RequestParam Map<String, String> params) {
    List<ServiceInstance> list = discoveryClient.getInstances(taskServerName);
    DataPage<SysTask> page = DataPage.getEmpty();
    if (list != null && !list.isEmpty()) {
      page = taskManagerClient.getTaskPage(params);
    }
    return new ResponseEntity<>(page, HttpStatus.OK);
  }

  /**
   * 分页查询集合
   *
   * @param params
   *
   * @return
   */
  @GetMapping(value = {"/logs"})
  @ResponseBody
  public ResponseEntity<DataPage> logs(@RequestParam Map<String, String> params) {
    DateTime timeS = ConvertUtil.dateNullable(params.get("timeS"), null, Dates.DATE_TIME_FORMATTER);
    DateTime timeE = ConvertUtil.dateNullable(params.get("timeE"), null, Dates.DATE_TIME_FORMATTER);
    ConditionGroup<SysTaskLog> condition = ConditionGroup.build()
      .addCondition("taskId", ConditionEnum.OPERATE_EQUAL, params.get("taskId"), true)
      .addCondition("taskFireTime", ConditionEnum.OPERATE_GREATER_EQUAL,
                    timeS == null ? null : timeS.toDate(), true)
      .addCondition("taskFireTime", ConditionEnum.OPERATE_LESS_EQUAL,
                    timeE == null ? null : timeE.toDate(), true);
    Page<SysTaskLog> page = sysTaskLogDao
      .findAll(condition, Pages.Helper.pageable(params, new Sort(Sort.Direction.DESC, "taskFireTime")));
    return new ResponseEntity<>(DataPage.from(page), HttpStatus.OK);
  }

}
