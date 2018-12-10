package com.drakelee.demo.common.domain.task;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.util.Assert;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 调度作业
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2017-11-20
 */
@Entity
@Table(name = "sys_task")
public class SysTask implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** name - 作业名称 */
  private String name;

  /** description - 描述 */
  private String description;

  /** target_class - 执行完整类名 */
  private String targetClass;

  /** cron_expression - 格式: [秒] [分] [小时] [日] [月] [周] [年]，如：2016年1月10日13点24分0秒 为 0 24 13 10 1 ? 2016 */
  private String cronExpression;

  /** arguments_map - 传递到执行方法的参数 */
  private String argumentsMap;

  /** last_server - 最后执行的作业服务器端 */
  private String lastServer;

  /** last_time - 最后执行时间 */
  private java.util.Date lastTime;

  /** disabled - 已禁用 */
  private Boolean disabled;

  /** locking - 是否锁定中，一般为一个作业服务端调用时锁定并排它 */
  private Boolean locking;

  /** create_time - */
  private java.util.Date createTime;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "name", nullable = false)
  public String getName() {
    return name;
  }

  @Column(name = "description")
  public String getDescription() {
    return description;
  }

  @Column(name = "target_class", nullable = false)
  public String getTargetClass() {
    return targetClass;
  }

  @Column(name = "cron_expression", nullable = false)
  public String getCronExpression() {
    return cronExpression;
  }

  @Column(name = "arguments_map")
  public String getArgumentsMap() {
    return argumentsMap;
  }

  @Column(name = "last_server")
  public String getLastServer() {
    return lastServer;
  }

  @Column(name = "last_time")
  public java.util.Date getLastTime() {
    return lastTime;
  }

  @Column(name = "disabled", nullable = false)
  public Boolean getDisabled() {
    return disabled;
  }

  @Column(name = "locking", nullable = false)
  public Boolean getLocking() {
    return locking;
  }

  @Column(name = "create_time")
  public java.util.Date getCreateTime() {
    return createTime;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public void setTargetClass(String targetClass) {
    this.targetClass = targetClass;
  }

  public void setCronExpression(String cronExpression) {
    Assert.isTrue(cronExpression != null && cronExpression.startsWith("0"), "must start with 0");
    this.cronExpression = cronExpression;
  }

  public void setArgumentsMap(String argumentsMap) {
    this.argumentsMap = argumentsMap;
  }

  public void setLastServer(String lastServer) {
    this.lastServer = lastServer;
  }

  public void setLastTime(java.util.Date lastTime) {
    this.lastTime = lastTime;
  }

  public void setDisabled(Boolean disabled) {
    this.disabled = disabled;
  }

  public void setLocking(Boolean locking) {
    this.locking = locking;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  @Override
  public String toString() {
    return "SysTask{" + "name='" + name + '\'' + ", targetClass='" + targetClass + '\'' + ", cronExpression='"
      + cronExpression + '\'' + ", disabled=" + disabled + ", locking=" + locking + '}';
  }
}