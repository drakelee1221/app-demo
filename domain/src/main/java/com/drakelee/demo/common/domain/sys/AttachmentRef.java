package com.drakelee.demo.common.domain.sys;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 *
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-05-09
 */
@Entity
@Table(name = "base_attachment_ref")
public class AttachmentRef implements Serializable  {
  private static final long serialVersionUID = 1L;

  /** id -  */
  private String  id ;

  /** attachment_id -  */
  private String  attachmentId ;

  /** ref_id -  */
  private String  refId ;

  /** ref_type -  */
  private String  refType ;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @Column(name = "id", nullable = false)
  public String  getId  () {
    return this.id;
  }

  @Column(name = "attachment_id", nullable = false)
  public String  getAttachmentId  () {
    return attachmentId;
  }
  @Column(name = "ref_id", nullable = false)
  public String  getRefId  () {
    return refId;
  }
  @Column(name = "ref_type", nullable = false)
  public String  getRefType  () {
    return refType;
  }

  public void setId (String  id) {
    this.id = id;
  }

  public void setAttachmentId (String  attachmentId) {
    this.attachmentId = attachmentId;
  }
  public void setRefId (String  refId) {
    this.refId = refId;
  }
  public void setRefType (String  refType) {
    this.refType = refType;
  }

}