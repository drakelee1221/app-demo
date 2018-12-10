

package com.drakelee.demo.common.domain.sys;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 附件表
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-29
 */
@Entity
@Table(name = "base_attachment")
public class Attachment implements Serializable  {
  private static final long serialVersionUID = 1L;

  /** id -  */
  private String  id ;

  /** url -  */
  private String  url ;

  /** name -  */
  private String  name ;

  /** file_type - 0、其他，1、企业营业执照，2、法人身份证，3、银行流水，4、协议书，5、合同 */
  private Integer  fileType ;

  /** remark -  */
  private String  remark ;

  /** ref_id -  */
  private String  refId ;

  /** size -  */
  private String  size ;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @Column(name = "id", nullable = false)
  public String  getId  () {
    return this.id;
  }

  @Column(name = "url", nullable = false)
  public String  getUrl  () {
    return url;
  }
  @Column(name = "name", nullable = false)
  public String  getName  () {
    return name;
  }
  @Column(name = "file_type", nullable = false)
  public Integer  getFileType  () {
    return fileType;
  }
  @Column(name = "remark")
  public String  getRemark  () {
    return remark;
  }
  @Column(name = "ref_id", nullable = false)
  public String  getRefId  () {
    return refId;
  }
  @Column(name = "size")
  public String  getSize () {
    return size;
  }

  public void setId (String  id) {
    this.id = id;
  }

  public void setUrl (String  url) {
    this.url = url;
  }
  public void setName (String  name) {
    this.name = name;
  }
  public void setFileType (Integer  fileType) {
    this.fileType = fileType;
  }
  public void setRemark (String  remark) {
    this.remark = remark;
  }
  public void setRefId (String  refId) {
    this.refId = refId;
  }
  public void setSize (String  size) {
    this.size = size;
  }

}