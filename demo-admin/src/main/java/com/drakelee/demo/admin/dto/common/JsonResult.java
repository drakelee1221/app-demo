

package com.drakelee.demo.admin.dto.common;

import com.base.components.common.util.JsonUtils;

import java.io.IOException;
import java.io.Serializable;

/**
 * JsonResult
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-03-20 10:45
 */
public class JsonResult implements Serializable{
  private static final long serialVersionUID = 4516708788107419583L;
  public static final String SUCCESS_MSG = "操作成功";
  public static final String FAIL_MSG = "操作失败";
  private boolean success;
  private String message;
  private String code;
  private Object data;

  public JsonResult(boolean success, String message, String code, Object data) {
    this.success = success;
    this.message = message;
    this.code = code;
    this.data = data;
  }

  public static JsonResult success(){
    return new JsonResult(true, SUCCESS_MSG, null, null);
  }

  public static JsonResult success(Object data){
    return new JsonResult(true, SUCCESS_MSG, null, data);
  }

  public static JsonResult success(String message, String code, Object data){
    return new JsonResult(true, message, code, data);
  }

  public static JsonResult fail(){
    return new JsonResult(false, FAIL_MSG, null, null);
  }

  public static JsonResult fail(String message){
    return new JsonResult(false, message, null, null);
  }

  public static JsonResult fail(String message, String code, Object data){
    return new JsonResult(false, message, code, data);
  }

  public boolean isSuccess() {
    return success;
  }

  public void setSuccess(boolean success) {
    this.success = success;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public Object getData() {
    return data;
  }

  public void setData(Object data) {
    this.data = data;
  }

  @Override
  public String toString() {
    try {
      return JsonUtils.toString(this);
    } catch (IOException e) {
      return super.toString();
    }
  }
}
