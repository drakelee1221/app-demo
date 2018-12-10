package com.drakelee.demo.common.dto.sys;

import java.io.Serializable;

/**
 * 通用业务响应实体类
 *
 * @author <a href="lijian@xianyunsoft.com">Lijian</a>
 * @version 1.0.0, 2017-11-27
 */
public class BusinessEntity implements Serializable{
  private static final long serialVersionUID = 1L;
  private String msg;
  private Boolean success;
  private String code;
  private Serializable extendData;
  public BusinessEntity() {

  }
  public BusinessEntity(String msg, Boolean success) {
    this.msg = msg;
    this.success = success;
  }

  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public Boolean getSuccess() {
    return success;
  }

  public void setSuccess(Boolean success) {
    this.success = success;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public Serializable getExtendData() {
    return extendData;
  }

  public void setExtendData(Serializable extendData) {
    this.extendData = extendData;
  }
}
