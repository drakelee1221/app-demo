

package com.drakelee.demo.feign.client.task;

import com.drakelee.demo.common.domain.task.SysTask;
import com.base.components.common.dto.page.DataPage;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

/**
 * 作业管理 服务
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-08-03 18:42
 */
@FeignClient("${module-task}")
public interface TaskManagerClient {

  /**
   * 添加任务，广播并持久化到数据库
   *
   * @param paramMap -
   * <p> taskName        - Nonnull  - Str  - 作业名称
   * <p> description     - Nullable - Str  - 作业描述
   * <p> targetClass     - Nonnull  - Str  - 作业执行类全名
   * <p> cronExpression  - Nonnull  - Str  - 作业执行周期 <br>
   * - 格式：[秒] [分] [小时] [日] [月] [周] [年]，如：2016年1月10日13点每分0秒 为 0 * 13 10 1 ? 2016
   * <p> argumentsMap    - Nullable - Str -  作业执行调用方法时传递的参数json <br>
   * - 格式：{"aaa":"123", "bbb":"321"}
   * <p> async           - Nullable - bool - true=异步广播(默认), false=同步广播
   *
   * @return SysTask
   */
  @RequestMapping(path = "/task/add", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  SysTask addTask(@RequestParam Map<String, String> paramMap);

  /**
   * 修改任务，广播并持久化到数据库
   *
   * @param paramMap -
   * <p> taskId          - Nonnull  - Str  - 作业ID
   * <p> taskName        - Nullable - Str  - 作业名称
   * <p> description     - Nullable - Str  - 作业描述
   * <p> targetClass     - Nullable - Str  - 作业执行类全名
   * <p> cronExpression  - Nullable - Str  - 作业执行周期 <br>
   * - 格式：[秒] [分] [小时] [日] [月] [周] [年]，如：2016年1月10日13点每分0秒 为 0 * 13 10 1 ? 2016 <br>
   * 调度时间配置设置秒位精确度只能为 0 或 00
   * <p> argumentsMap    - Nullable - Str  - 作业执行调用方法时传递的参数json <br>
   * - 格式：{"aaa":"123", "bbb":"321"}
   * <p> async           - Nullable - bool - true=异步广播(默认), false=同步广播
   *
   * @return SysTask
   */
  @RequestMapping(path = "/task/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  SysTask updateTask(@RequestParam Map<String, String> paramMap);

  /**
   * 立即触发任务，并广播
   *
   * @param fireTaskId - Nonnull  - Str  - id
   * @param async - Nullable - bool - true=异步广播,false=同步广播
   * @param argumentsMap - Nullable - Json - 调用参数
   *
   * @return { count : (异步广播=0, 同步广播>=0) }
   */
  @RequestMapping(path = "/task/trigger", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  Map trigger(@RequestParam("fireTaskId") String fireTaskId,
              @RequestParam(value = "async", defaultValue = "true") boolean async,
              @RequestParam("argumentsMap") String argumentsMap);

  /**
   * 启动任务，广播并持久化到数据库
   *
   * @param fireTaskId - Nonnull  - Str  - id
   * @param async - Nullable - bool - true=异步广播,false=同步广播
   *
   * @return SysTask
   */
  @RequestMapping(path = "/task/start", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  SysTask startTask(@RequestParam("fireTaskId") String fireTaskId,
                       @RequestParam(value = "async", defaultValue = "true") boolean async);

  /**
   * 暂停任务，广播并持久化到数据库
   *
   * @param fireTaskId - Nonnull  - Str  - id
   * @param async - Nullable - bool - true=异步广播,false=同步广播
   *
   * @return SysTask
   */
  @RequestMapping(path = "/task/pause", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  SysTask pauseTask(@RequestParam("fireTaskId") String fireTaskId,
                       @RequestParam(value = "async", defaultValue = "true") boolean async);

  /**
   * 重构某服务器所有任务
   *
   * @param async - Nullable - bool - true=异步广播,false=同步广播
   *
   * @return Boolean
   */
  @RequestMapping(path = "/task/rebuild", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  Boolean rebuildServer(@RequestParam(value = "async", defaultValue = "true") boolean async);

  //  /**
  //   * 停止某服务器的动态作业功能
  //   *
  //   * @param serverHost
  //   * @param async      true=异步广播,false=同步广播
  //   */
  //  @RequestMapping(path = "/task/stop", method = RequestMethod.PUT,
  //                  produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  //  Boolean stopServer(@RequestParam("serverHost") String serverHost,
  //                     @RequestParam(value = "async", defaultValue = "true") boolean async);


  /**
   * 查询作业
   *
   * @param paramMap -
   * <p> id             - Nonnull  - Str  - 作业ID
   *
   * @return SysTask;
   */
  @RequestMapping(path = "/task/list", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  SysTask getTask(@RequestParam Map<String, String> paramMap);

  /**
   * 查询作业分页
   *
   * @param paramMap -
   * <p> taskName       - Nullable - Str  - 作业名称
   * <p> description    - Nullable - Str  - 作业名称
   * <p> targetClass    - Nullable - Str  - 作业执行类全名
   * <p> cronExpression - Nullable - Str  - 作业执行周期
   * <p> lastServer     - Nullable - Str  - 最后调用的服务端host，如：192.168.0.1:8055
   * <p> lastTime       - Nullable - Str  - 最后调用时间，如：2017-01-01 11:22:33
   * <p> disabled       - Nullable - bool - 是否已禁用，true/false
   * <p> pageIndex      - Nullable - Int  - 当前页数，默认1
   *
   * @return PageInfo&lt;SysTask&gt;
   */
  @RequestMapping(path = "/task/page", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  DataPage<SysTask> getTaskPage(@RequestParam Map<String, String> paramMap);
}
