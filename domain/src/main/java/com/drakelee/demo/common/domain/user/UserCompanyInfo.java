

package com.drakelee.demo.common.domain.user;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 注册用户企业信息
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Entity
@Table(name = "base_user_company_info")
public class UserCompanyInfo implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** user_id - */
  private String userId;

  /** logo - */
  private String logo;

  /** nature - */
  private String nature;

  /** industry - */
  private String industry;

  /** scale - */
  private String scale;

  /** address - */
  private String address;

  /** phone - */
  private String phone;

  /** name - */
  private String name;

  /** region - */
  private String region;

  /** region_name - */
  private String regionName;

  @Column(name = "region_name")
  public String getRegionName() {
    return regionName;
  }

  public void setRegionName(String regionName) {
    this.regionName = regionName;
  }

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

  @Column(name = "logo")
  public String getLogo() {
    return logo;
  }

  @Column(name = "nature")
  public String getNature() {
    return nature;
  }

  @Column(name = "industry")
  public String getIndustry() {
    return industry;
  }

  @Column(name = "scale")
  public String getScale() {
    return scale;
  }

  @Column(name = "address")
  public String getAddress() {
    return address;
  }

  @Column(name = "phone")
  public String getPhone() {
    return phone;
  }

  @Column(name = "name")
  public String getName() {
    return name;
  }

  @Column(name = "region")
  public String getRegion() {
    return region;
  }


  public void setId(String id) {
    this.id = id;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public void setLogo(String logo) {
    this.logo = logo;
  }

  public void setNature(String nature) {
    this.nature = nature;
  }

  public void setIndustry(String industry) {
    this.industry = industry;
  }

  public void setScale(String scale) {
    this.scale = scale;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setRegion(String region) {
    this.region = region;
  }


}