

package com.drakelee.demo.common.domain.admin;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 管理端授权应用
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-02
 */
@Entity
@Table(name = "admin_sys_app_info")
public class SysAppInfo implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** name - */
  private String name;

  /** description - 描述 */
  private String description;

  /** target_url - 跳转路径 */
  private String targetUrl;

  /** params_json - 跳转参数 */
  private String paramsJson;

  /** auth_url_prefix - 授权uri前缀，不用*号结束，会授权以此路径开头的url */
  private String authUrlPrefix;

  /** icon_class - 图标 */
  private String iconClass;

  /** directory - 是否为目录，0、否，1、是 */
  private Integer directory;

  /** read_write_type - 控制授权url下，读写级别，优先级比排除授权资源高，0、读写，1、只读，2、只写 */
  private Integer readWriteType;

  /** parent_id - */
  private String parentId;

  /** left_val - */
  private Integer leftVal;

  /** right_val - */
  private Integer rightVal;

  /** status - 是否已禁用，0、否，1、是 */
  private Integer status;



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

  @Column(name = "target_url")
  public String getTargetUrl() {
    return targetUrl;
  }

  @Column(name = "params_json")
  public String getParamsJson() {
    return paramsJson;
  }

  @Column(name = "auth_url_prefix")
  public String getAuthUrlPrefix() {
    return authUrlPrefix;
  }

  @Column(name = "icon_class")
  public String getIconClass() {
    return iconClass;
  }

  @Column(name = "directory", nullable = false)
  public Integer getDirectory() {
    return directory;
  }

  @Column(name = "read_write_type", nullable = false)
  public Integer getReadWriteType() {
    return readWriteType;
  }

  @Column(name = "parent_id", nullable = false)
  public String getParentId() {
    return parentId;
  }

  @Column(name = "left_val", nullable = false)
  public Integer getLeftVal() {
    return leftVal;
  }

  @Column(name = "right_val", nullable = false)
  public Integer getRightVal() {
    return rightVal;
  }

  @Column(name = "status", nullable = false)
  public Integer getStatus() {
    return status;
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

  public void setTargetUrl(String targetUrl) {
    this.targetUrl = targetUrl;
  }

  public void setParamsJson(String paramsJson) {
    this.paramsJson = paramsJson;
  }

  public void setAuthUrlPrefix(String authUrlPrefix) {
    this.authUrlPrefix = authUrlPrefix;
  }

  public void setIconClass(String iconClass) {
    this.iconClass = iconClass;
  }

  public void setDirectory(Integer directory) {
    this.directory = directory;
  }

  public void setReadWriteType(Integer readWriteType) {
    this.readWriteType = readWriteType;
  }

  public void setParentId(String parentId) {
    this.parentId = parentId;
  }

  public void setLeftVal(Integer leftVal) {
    this.leftVal = leftVal;
  }

  public void setRightVal(Integer rightVal) {
    this.rightVal = rightVal;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

}