package com.drakelee.demo.common.domain.sys;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * sys_message_event_handle实体类
 *
 * @author : code tools
 * @version : 2.0
 * @date : 2018-08-08 13:35:22
 */
@Entity
@Table(name = "sys_message_event_handle")
@TableName("sys_message_event_handle")
public class SysMessageEventHandle implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String id;

  /** event_id - */
  @TableField(value = "event_id")
  @Column(name = "event_id", nullable = false)
  private String eventId;

  /** listener_id - */
  @TableField(value = "listener_id")
  @Column(name = "listener_id", nullable = false)
  private String listenerId;

  /** listener_class - */
  @TableField(value = "listener_class")
  @Column(name = "listener_class")
  private String listenerClass;

  /** has_done - 是否已完成 */
  @TableField(value = "has_done")
  @Column(name = "has_done")
  private Integer hasDone;

  /** create_time - 创建时间 */
  @TableField(value = "create_time")
  @Column(name = "create_time")
  private java.util.Date createTime;

  /** done_server - 完成服务host */
  @TableField(value = "done_server")
  @Column(name = "done_server")
  private String doneServer;

  /** done_host - */
  @TableField(value = "done_host")
  @Column(name = "done_host")
  private String doneHost;

  /** done_time - 完成时间 */
  @TableField(value = "done_time")
  @Column(name = "done_time")
  private java.util.Date doneTime;

  /** error_time - 异常时间 */
  @TableField(value = "error_time")
  @Column(name = "error_time")
  private java.util.Date errorTime;

  /** error_stack - 异常信息 */
  @TableField(value = "error_stack")
  @Column(name = "error_stack")
  private String errorStack;

  /** remark - */
  @TableField(value = "remark")
  @Column(name = "remark")
  private String remark;


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getEventId() {
    return eventId;
  }

  public void setEventId(String eventId) {
    this.eventId = eventId;
  }

  public String getListenerId() {
    return listenerId;
  }

  public void setListenerId(String listenerId) {
    this.listenerId = listenerId;
  }

  public String getListenerClass() {
    return listenerClass;
  }

  public void setListenerClass(String listenerClass) {
    this.listenerClass = listenerClass;
  }

  public Integer getHasDone() {
    return hasDone;
  }

  public void setHasDone(Integer hasDone) {
    this.hasDone = hasDone;
  }

  public java.util.Date getCreateTime() {
    return createTime;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public String getDoneServer() {
    return doneServer;
  }

  public void setDoneServer(String doneServer) {
    this.doneServer = doneServer;
  }

  public String getDoneHost() {
    return doneHost;
  }

  public void setDoneHost(String doneHost) {
    this.doneHost = doneHost;
  }

  public java.util.Date getDoneTime() {
    return doneTime;
  }

  public void setDoneTime(java.util.Date doneTime) {
    this.doneTime = doneTime;
  }

  public java.util.Date getErrorTime() {
    return errorTime;
  }

  public void setErrorTime(java.util.Date errorTime) {
    this.errorTime = errorTime;
  }

  public String getErrorStack() {
    return errorStack;
  }

  public void setErrorStack(String errorStack) {
    this.errorStack = errorStack;
  }

  public String getRemark() {
    return remark;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }


  @Override
  public String toString() {
    return "SysMessageEventHandle [id=" + id + " , eventId=" + eventId + " , listenerId=" + listenerId
      + " , listenerClass=" + listenerClass + " , hasDone=" + hasDone + " , createTime=" + createTime + " , doneServer="
      + doneServer + " , doneHost=" + doneHost + " , doneTime=" + doneTime + " , errorTime=" + errorTime
      + " , errorStack=" + errorStack + " , remark=" + remark + "  ]";

  }

}
