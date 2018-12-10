

package com.drakelee.demo.common.domain.sys;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 邮件
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Entity
@Table(name = "base_email")
public class Email implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** subject - */
  private String subject;

  /** content - */
  private String content;

  /** addressee - */
  private String addressee;

  /** remark - */
  private String remark;

  /** create_time - */
  private java.util.Date createTime;

  /** author_id - */
  private String authorId;

  /** status - 0、未发送 1、已发送 */
  private Integer status;

  /** mailbox_id - */
  private String mailboxId;

  /** count - */
  private Integer count;

  /** send_time - */
  private java.util.Date sendTime;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "subject", nullable = false)
  public String getSubject() {
    return subject;
  }

  @Column(name = "content", nullable = false)
  public String getContent() {
    return content;
  }

  @Column(name = "addressee", nullable = false)
  public String getAddressee() {
    return addressee;
  }

  @Column(name = "remark")
  public String getRemark() {
    return remark;
  }

  @Column(name = "create_time", nullable = false)
  public java.util.Date getCreateTime() {
    return createTime;
  }

  @Column(name = "author_id", nullable = false)
  public String getAuthorId() {
    return authorId;
  }

  @Column(name = "status", nullable = false)
  public Integer getStatus() {
    return status;
  }

  @Column(name = "mailbox_id", nullable = false)
  public String getMailboxId() {
    return mailboxId;
  }

  @Column(name = "count", nullable = false)
  public Integer getCount() {
    return count;
  }

  @Column(name = "send_time")
  public java.util.Date getSendTime() {
    return sendTime;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public void setAddressee(String addressee) {
    this.addressee = addressee;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public void setAuthorId(String authorId) {
    this.authorId = authorId;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public void setMailboxId(String mailboxId) {
    this.mailboxId = mailboxId;
  }

  public void setCount(Integer count) {
    this.count = count;
  }

  public void setSendTime(java.util.Date sendTime) {
    this.sendTime = sendTime;
  }

}