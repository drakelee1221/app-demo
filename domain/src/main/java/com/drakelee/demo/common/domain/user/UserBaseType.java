

package com.drakelee.demo.common.domain.user;

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
 * @since : 2018-04-09
 */
@Entity
@Table(name = "base_user_base_type")
public class UserBaseType implements Serializable  {
  private static final long serialVersionUID = 1L;

    /** id -  */
  private String  id ;
  
    /** user_type -  */
    private Integer  userType ;

    /** user_type_name -  */
    private String  userTypeName ;

    /** remark -  */
    private String  remark ;

  

      @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @Column(name = "id", nullable = false)
    public String  getId  () {
        return this.id;
      }
  
      @Column(name = "user_type", nullable = false)
    public Integer  getUserType  () {
    return userType;
  }
      @Column(name = "user_type_name", nullable = false)
    public String  getUserTypeName  () {
    return userTypeName;
  }
      @Column(name = "remark")
    public String  getRemark  () {
    return remark;
  }
  
    public void setId (String  id) {
        this.id = id;
      }
  
    public void setUserType (Integer  userType) {
    this.userType = userType;
  }
    public void setUserTypeName (String  userTypeName) {
    this.userTypeName = userTypeName;
  }
    public void setRemark (String  remark) {
    this.remark = remark;
  }
  
  }