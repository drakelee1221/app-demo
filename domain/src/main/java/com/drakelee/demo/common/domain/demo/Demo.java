package com.drakelee.demo.common.domain.demo;

import com.base.components.common.elasticsearch.Analyzer;
import com.base.components.common.elasticsearch.DocumentIndexBuildQuery;
import com.base.components.common.elasticsearch.EsIndex;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * test
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-10 9:56
 */
@Entity
@Table(name = "t_demo")
@DocumentIndexBuildQuery(value = "select * from t_demo", idColumn = "t_id", columnPrefix = "t_")
@Document(indexName = EsIndex.INDEX_PREFIX + "demo", type = EsIndex.INDEX_PREFIX + "demo")
public class Demo implements Serializable {
  private static final long serialVersionUID = 1119202170745121570L;

  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "t_id")
  @org.springframework.data.annotation.Id
  private String id;

  @Column(name = "t_name")
  @Field(type = FieldType.text, analyzer = Analyzer.IK_MAX_WORD, searchAnalyzer = Analyzer.IK_MAX_WORD)
  private String name;

  @Column(name = "t_address")
  @Field(type = FieldType.text, analyzer = Analyzer.IK_MAX_WORD, searchAnalyzer = Analyzer.IK_MAX_WORD)
  private String address;

  @Column(name = "t_age")
  @Field(type = FieldType.Integer)
  private Integer age;

  @Column(name = "t_update_time")
  @Field(type = FieldType.Date)
  private Date updateTime;

  @Column(name = "t_create_time")
  @Field(type = FieldType.Date)
  private Date createTime;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Integer getAge() {
    return age;
  }

  public void setAge(Integer age) {
    this.age = age;
  }

  public Date getCreateTime() {
    return createTime;
  }

  public void setCreateTime(Date createTime) {
    this.createTime = createTime;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public Date getUpdateTime() {
    return updateTime;
  }

  public void setUpdateTime(Date updateTime) {
    this.updateTime = updateTime;
  }
}
