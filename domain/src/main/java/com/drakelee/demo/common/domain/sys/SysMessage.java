

package com.drakelee.demo.common.domain.sys;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 系统消息
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Entity
@Table(name = "base_sys_message")
public class SysMessage implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** user_id - */
  private String userId;

  /** content - */
  private String content;

  /** create_time - */
  private java.util.Date createTime;

  /** know_time - */
  private java.util.Date knowTime;

  /** status - 0、未读 1、已读 */
  private Integer status;

  /** biz_type - 业务类型 */
  private String bizType;

  /** biz_id - 业务id */
  private String bizId;

  /** del_flag - 删除标记 0、已删除 1、未删除 */
  private Integer delFlag;


  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "user_id", nullable = false)
  public String getUserId() {
    return userId;
  }

  @Column(name = "content", nullable = false)
  public String getContent() {
    return content;
  }

  @Column(name = "create_time", nullable = false)
  public java.util.Date getCreateTime() {
    return createTime;
  }

  @Column(name = "know_time")
  public java.util.Date getKnowTime() {
    return knowTime;
  }

  @Column(name = "status", nullable = false)
  public Integer getStatus() {
    return status;
  }

  @Column(name = "biz_type")
  public String getBizType() {
    return bizType;
  }

  @Column(name = "biz_id")
  public String getBizId() {
    return bizId;
  }

  @Column(name = "del_flag")
  public Integer getDelFlag() {
    return delFlag;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public void setKnowTime(java.util.Date knowTime) {
    this.knowTime = knowTime;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public void setBizType(String bizType) {
    this.bizType = bizType;
  }

  public void setBizId(String bizId) {
    this.bizId = bizId;
  }

  public void setDelFlag(Integer delFlag) {
    this.delFlag = delFlag;
  }
}