package com.drakelee.demo.common.domain.user;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.base.components.common.doc.annotation.Param;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;




/**
 * 用户详情表
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-10-25
 */
@Entity
@Table(name = "base_user_base_info")
@TableName("base_user_base_info")
public class UserBaseInfo implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  @org.springframework.data.annotation.Id
  @Param("id")
  private String id;
    
  /** phone -  */
  @TableField(value = "phone")
  @Column(name = "phone", nullable = false)
  @Param("phone")
  private String phone;

  /** phone2 -  */
  @TableField(value = "phone2")
  @Column(name = "phone2")
  @Param("备用联系电话")
  private String phone2;

  /** pwd -  */
  @TableField(value = "pwd")
  @Column(name = "pwd", nullable = false)
  @Param("pwd")
  private String pwd;

  /** avatar -  */
  @TableField(value = "avatar")
  @Column(name = "avatar")
  @Param("avatar")
  private String avatar;

  /** user_nick_name -  */
  @TableField(value = "user_nick_name")
  @Column(name = "user_nick_name", nullable = false)
  @Param("userNickName")
  private String userNickName;

  /** gender - 0、 未填写  1、男  2、女 */
  @TableField(value = "gender")
  @Column(name = "gender", nullable = false)
  @Param("0、 未填写  1、男  2、女")
  private Integer gender;

  /** birth -  */
  @TableField(value = "birth")
  @Column(name = "birth")
  @Param("birth")
  private String birth;

  /** user_email -  */
  @TableField(value = "user_email")
  @Column(name = "user_email")
  @Param("userEmail")
  private String userEmail;

  /** open_id -  */
  @TableField(value = "open_id")
  @Column(name = "open_id")
  @Param("openId")
  private String openId;

  /** user_qq -  */
  @TableField(value = "user_qq")
  @Column(name = "user_qq")
  @Param("userQq")
  private String userQq;

  /** user_type - 1、注册用户，2、客户经理，3、专业会计，4、财务专家 */
  @TableField(value = "user_type")
  @Column(name = "user_type", nullable = false)
  @Param("1、注册用户，2、客户经理，3、专业会计，4、财务专家")
  private Integer userType;

  /** user_type_id -  */
  @TableField(value = "user_type_id")
  @Column(name = "user_type_id", nullable = false)
  @Param("userTypeId")
  private String userTypeId;

  /** balance - 余额 */
  @TableField(value = "balance")
  @Column(name = "balance", nullable = false)
  @Param("余额")
  private BigDecimal balance;

  /** regist_time -  */
  @TableField(value = "regist_time")
  @Column(name = "regist_time", nullable = false)
  @Param("registTime")
  private java.util.Date registTime;

  /** regist_ip -  */
  @TableField(value = "regist_ip")
  @Column(name = "regist_ip", nullable = false)
  @Param("registIp")
  private String registIp;

  /** last_login_time -  */
  @TableField(value = "last_login_time")
  @Column(name = "last_login_time")
  @Param("lastLoginTime")
  private java.util.Date lastLoginTime;

  /** last_login_ip -  */
  @TableField(value = "last_login_ip")
  @Column(name = "last_login_ip")
  @Param("lastLoginIp")
  private String lastLoginIp;

  /** status - 1,正常 0.限制登录 */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  @Param("1,正常 0.限制登录")
  private Integer status;

  /** password_errors - 密码错误次数 */
  @TableField(value = "password_errors")
  @Column(name = "password_errors", nullable = false)
  @Param("密码错误次数")
  private Integer passwordErrors;

  /** wx_name -  */
  @TableField(value = "wx_name")
  @Column(name = "wx_name")
  @Param("wxName")
  private String wxName;

  /** wx_img -  */
  @TableField(value = "wx_img")
  @Column(name = "wx_img")
  @Param("wxImg")
  private String wxImg;

  /** work_status - 0、未工作，1、工作中 */
  @TableField(value = "work_status")
  @Column(name = "work_status", nullable = false)
  @Param("0、未工作，1、工作中")
  private Integer workStatus;

  /** profile - 个人简介 */
  @TableField(value = "profile")
  @Column(name = "profile")
  @Param("个人简介")
  private String profile;

  /** regist_region -  */
  @TableField(value = "regist_region")
  @Column(name = "regist_region")
  @Param("registRegion")
  private String registRegion;

  /** region_id -  */
  @TableField(value = "region_id")
  @Column(name = "region_id", nullable = false)
  @Param("regionId")
  private String regionId;

  /** select_region - 用户选择的地区 */
  @TableField(value = "select_region")
  @Column(name = "select_region")
  @Param("用户选择的地区")
  private String selectRegion;

  /** select_region_id - 用户选择的地区id */
  @TableField(value = "select_region_id")
  @Column(name = "select_region_id")
  @Param("用户选择的地区id")
  private String selectRegionId;

  /** homepage -  */
  @TableField(value = "homepage")
  @Column(name = "homepage")
  @Param("homepage")
  private String homepage;

  /** remark - 备注 */
  @TableField(value = "remark")
  @Column(name = "remark", nullable = false)
  @Param("备注")
  private String remark;

  /** data_source - 数据来源（0 - PC, 1 - MOBILE, 2 - 存量数据导入） */
  @TableField(value = "data_source")
  @Column(name = "data_source")
  @Param("数据来源（0 - PC, 1 - MOBILE, 2 - 存量数据导入）")
  private Integer dataSource;

  /** pay_pwd - 支付密码 */
  @TableField(value = "pay_pwd")
  @Column(name = "pay_pwd")
  @Param("支付密码")
  private String payPwd;

  /** mini_open_id -  */
  @TableField(value = "mini_open_id")
  @Column(name = "mini_open_id")
  @Param("miniOpenId")
  private String miniOpenId;

  /** wx_union_id -  */
  @TableField(value = "wx_union_id")
  @Column(name = "wx_union_id")
  @Param("wxUnionId")
  private String wxUnionId;

  /** referrer_user_id - 推荐人id */
  @TableField(value = "referrer_user_id")
  @Column(name = "referrer_user_id")
  @Param("推荐人id")
  private String referrerUserId;

  

    public String  getId  () {
        return this.id;
      }
  
    public String  getPhone  () {
    return phone;
  }

    public String getPhone2() {
    return phone2;
  }

    public String  getPwd  () {
    return pwd;
  }

    public String  getAvatar  () {
    return avatar;
  }

    public String  getUserNickName  () {
    return userNickName;
  }

    public Integer  getGender  () {
    return gender;
  }

    public String  getBirth  () {
    return birth;
  }

    public String  getUserEmail  () {
    return userEmail;
  }

    public String  getOpenId  () {
    return openId;
  }

    public String  getUserQq  () {
    return userQq;
  }

    public Integer  getUserType  () {
    return userType;
  }

    public String  getUserTypeId  () {
    return userTypeId;
  }

    public BigDecimal  getBalance  () {
    return balance;
  }

    public java.util.Date  getRegistTime  () {
    return registTime;
  }

    public String  getRegistIp  () {
    return registIp;
  }

    public java.util.Date  getLastLoginTime  () {
    return lastLoginTime;
  }

    public String  getLastLoginIp  () {
    return lastLoginIp;
  }

    public Integer  getStatus  () {
    return status;
  }

    public Integer  getPasswordErrors  () {
    return passwordErrors;
  }

    public String  getWxName  () {
    return wxName;
  }

    public String  getWxImg  () {
    return wxImg;
  }

    public Integer  getWorkStatus  () {
    return workStatus;
  }

    public String  getProfile  () {
    return profile;
  }

    public String  getRegistRegion  () {
    return registRegion;
  }

    public String  getRegionId  () {
    return regionId;
  }

    public String  getSelectRegion  () {
    return selectRegion;
  }

    public String  getSelectRegionId  () {
    return selectRegionId;
  }

    public String  getHomepage  () {
    return homepage;
  }

    public String  getRemark  () {
    return remark;
  }

    public Integer  getDataSource  () {
    return dataSource;
  }

    public String  getPayPwd  () {
    return payPwd;
  }

    public String  getMiniOpenId  () {
    return miniOpenId;
  }

    public String  getWxUnionId  () {
    return wxUnionId;
  }

    public String  getReferrerUserId  () {
    return referrerUserId;
  }

  
    public void setId (String  id) {
        this.id = id;
      }

  
    public void setPhone (String  phone) {
    this.phone = phone;
  }
    public void setPhone2(String phone2) {
    this.phone2 = phone2;
  }
    public void setPwd (String  pwd) {
    this.pwd = pwd;
  }
    public void setAvatar (String  avatar) {
    this.avatar = avatar;
  }
    public void setUserNickName (String  userNickName) {
    this.userNickName = userNickName;
  }
    public void setGender (Integer  gender) {
    this.gender = gender;
  }
    public void setBirth (String  birth) {
    this.birth = birth;
  }
    public void setUserEmail (String  userEmail) {
    this.userEmail = userEmail;
  }
    public void setOpenId (String  openId) {
    this.openId = openId;
  }
    public void setUserQq (String  userQq) {
    this.userQq = userQq;
  }
    public void setUserType (Integer  userType) {
    this.userType = userType;
  }
    public void setUserTypeId (String  userTypeId) {
    this.userTypeId = userTypeId;
  }
    public void setBalance (BigDecimal  balance) {
    this.balance = balance;
  }
    public void setRegistTime (java.util.Date  registTime) {
    this.registTime = registTime;
  }
    public void setRegistIp (String  registIp) {
    this.registIp = registIp;
  }
    public void setLastLoginTime (java.util.Date  lastLoginTime) {
    this.lastLoginTime = lastLoginTime;
  }
    public void setLastLoginIp (String  lastLoginIp) {
    this.lastLoginIp = lastLoginIp;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
    public void setPasswordErrors (Integer  passwordErrors) {
    this.passwordErrors = passwordErrors;
  }
    public void setWxName (String  wxName) {
    this.wxName = wxName;
  }
    public void setWxImg (String  wxImg) {
    this.wxImg = wxImg;
  }
    public void setWorkStatus (Integer  workStatus) {
    this.workStatus = workStatus;
  }
    public void setProfile (String  profile) {
    this.profile = profile;
  }
    public void setRegistRegion (String  registRegion) {
    this.registRegion = registRegion;
  }
    public void setRegionId (String  regionId) {
    this.regionId = regionId;
  }
    public void setSelectRegion (String  selectRegion) {
    this.selectRegion = selectRegion;
  }
    public void setSelectRegionId (String  selectRegionId) {
    this.selectRegionId = selectRegionId;
  }
    public void setHomepage (String  homepage) {
    this.homepage = homepage;
  }
    public void setRemark (String  remark) {
    this.remark = remark;
  }
    public void setDataSource (Integer  dataSource) {
    this.dataSource = dataSource;
  }
    public void setPayPwd (String  payPwd) {
    this.payPwd = payPwd;
  }
    public void setMiniOpenId (String  miniOpenId) {
    this.miniOpenId = miniOpenId;
  }
    public void setWxUnionId (String  wxUnionId) {
    this.wxUnionId = wxUnionId;
  }
    public void setReferrerUserId (String  referrerUserId) {
    this.referrerUserId = referrerUserId;
  }
  
  }