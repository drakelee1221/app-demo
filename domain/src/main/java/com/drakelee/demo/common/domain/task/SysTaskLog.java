package com.drakelee.demo.common.domain.task;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 调度作业日志
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2017-11-20
 */
@Entity
@Table(name = "sys_task_log")
public class SysTaskLog implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** task_id - */
  private String taskId;

  /** task_name - 作业名称 */
  private String taskName;

  /** execute_over_time - 执行完成时间 */
  private java.util.Date executeOverTime;

  /** task_fire_time - 作业触发时间 */
  private java.util.Date taskFireTime;

  /** execute_success - 是否完整执行并未抛异常 */
  private Boolean executeSuccess;

  /** execute_exceptions - 异常信息 */
  private String executeExceptions;

  /** execute_server_host - 执行作业服务端 */
  private String executeServerHost;

  /** result_message - 完成返回信息 */
  private String resultMessage;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "task_id", nullable = false)
  public String getTaskId() {
    return taskId;
  }

  @Column(name = "task_name")
  public String getTaskName() {
    return taskName;
  }

  @Column(name = "execute_over_time", nullable = false)
  public java.util.Date getExecuteOverTime() {
    return executeOverTime;
  }

  @Column(name = "task_fire_time", nullable = false)
  public java.util.Date getTaskFireTime() {
    return taskFireTime;
  }

  @Column(name = "execute_success", nullable = false)
  public Boolean getExecuteSuccess() {
    return executeSuccess;
  }

  @Column(name = "execute_exceptions")
  public String getExecuteExceptions() {
    return executeExceptions;
  }

  @Column(name = "execute_server_host")
  public String getExecuteServerHost() {
    return executeServerHost;
  }

  @Column(name = "result_message")
  public String getResultMessage() {
    return resultMessage;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setTaskId(String taskId) {
    this.taskId = taskId;
  }

  public void setTaskName(String taskName) {
    this.taskName = taskName;
  }

  public void setExecuteOverTime(java.util.Date executeOverTime) {
    this.executeOverTime = executeOverTime;
  }

  public void setTaskFireTime(java.util.Date taskFireTime) {
    this.taskFireTime = taskFireTime;
  }

  public void setExecuteSuccess(Boolean executeSuccess) {
    this.executeSuccess = executeSuccess;
  }

  public void setExecuteExceptions(String executeExceptions) {
    this.executeExceptions = executeExceptions;
  }

  public void setExecuteServerHost(String executeServerHost) {
    this.executeServerHost = executeServerHost;
  }

  public void setResultMessage(String resultMessage) {
    this.resultMessage = resultMessage;
  }

}