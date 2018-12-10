package com.drakelee.demo.common.domain.admin;

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
 * 动态表单数据从表
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-20
 */
@Entity
@Table(name = "base_dynamic_data_child")
@TableName("base_dynamic_data_child")
public class DynamicDataChild implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;
    
  /** ref_id -  */
  @TableField(value = "ref_id")
  @Column(name = "ref_id", nullable = false)
  private String  refId ;

  /** type -  */
  @TableField(value = "type")
  @Column(name = "type", nullable = false)
  private String  type ;

  /** code -  */
  @TableField(value = "code")
  @Column(name = "code", nullable = false)
  private String  code ;

  /** json_data -  */
  @TableField(value = "json_data")
  @Column(name = "json_data")
  private String  jsonData ;

  /** status - 状态 */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer  status ;

  

    public String  getId  () {
        return this.id;
      }
  
    public String  getRefId  () {
    return refId;
  }

    public String  getType  () {
    return type;
  }
    public String  getCode  () {
    return code;
  }

    public String  getJsonData  () {
    return jsonData;
  }

    public Integer  getStatus  () {
    return status;
  }

  
    public void setId (String  id) {
        this.id = id;
      }

  
    public void setRefId (String  refId) {
    this.refId = refId;
  }
    public void setType (String  type) {
    this.type = type;
  }
    public void setCode (String  code) {
    this.code = code;
  }
    public void setJsonData (String  jsonData) {
    this.jsonData = jsonData;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
  
  }