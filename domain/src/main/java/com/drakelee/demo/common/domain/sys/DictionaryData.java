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
 * 字典数据表
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-07-02
 */
@Entity
@Table(name = "base_dictionary_data")
@TableName("base_dictionary_data")
public class DictionaryData implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;
    
  /** dict_id -  */
  @TableField(value = "dict_id")
  @Column(name = "dict_id", nullable = false)
  private String  dictId ;

  /** data_value -  */
  @TableField(value = "data_value")
  @Column(name = "data_value", nullable = false)
  private String  dataValue ;

  /** data_key -  */
  @TableField(value = "data_key")
  @Column(name = "data_key", nullable = false)
  private String  dataKey ;

  /** data_name -  */
  @TableField(value = "data_name")
  @Column(name = "data_name", nullable = false)
  private String  dataName ;

  /** order_no -  */
  @TableField(value = "order_no")
  @Column(name = "order_no", nullable = false)
  private Integer  orderNo ;

  /** remarks -  */
  @TableField(value = "remarks")
  @Column(name = "remarks")
  private String  remarks ;

  /** status -  */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer  status ;

  

    public String  getId  () {
        return this.id;
      }
  
    public String  getDictId  () {
    return dictId;
  }

    public String  getDataValue  () {
    return dataValue;
  }

    public String  getDataKey  () {
    return dataKey;
  }

    public String  getDataName  () {
    return dataName;
  }

    public Integer  getOrderNo  () {
    return orderNo;
  }

    public String  getRemarks  () {
    return remarks;
  }

    public Integer  getStatus  () {
    return status;
  }

  
    public void setId (String  id) {
        this.id = id;
      }

  
    public void setDictId (String  dictId) {
    this.dictId = dictId;
  }
    public void setDataValue (String  dataValue) {
    this.dataValue = dataValue;
  }
    public void setDataKey (String  dataKey) {
    this.dataKey = dataKey;
  }
    public void setDataName (String  dataName) {
    this.dataName = dataName;
  }
    public void setOrderNo (Integer  orderNo) {
    this.orderNo = orderNo;
  }
    public void setRemarks (String  remarks) {
    this.remarks = remarks;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
  
  }