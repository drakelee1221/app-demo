package com.drakelee.demo.common.domain.sys;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 附件权限表
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-27
 */
@Entity
@Table(name = "base_attachment_auth")
public class AttachmentAuth implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** attachment_id - */
  private String attachmentId;

  /** user_id - */
  private String userId;

  /** url - */
  private String url;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "attachment_id", nullable = false)
  public String getAttachmentId() {
    return attachmentId;
  }

  @Column(name = "user_id", nullable = false)
  public String getUserId() {
    return userId;
  }

  @Column(name = "url")
  public String getUrl() {
    return url;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setAttachmentId(String attachmentId) {
    this.attachmentId = attachmentId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public void setUrl(String url) {
    this.url = url;
  }

}