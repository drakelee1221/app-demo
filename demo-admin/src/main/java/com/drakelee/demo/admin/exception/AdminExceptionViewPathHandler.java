

package com.drakelee.demo.admin.exception;

import com.base.components.common.exception.ExceptionViewPathHandler;
import org.springframework.stereotype.Service;

/**
 * AdminExceptionViewPathHandler
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-04-08 14:14
 */
@Service
public class AdminExceptionViewPathHandler implements ExceptionViewPathHandler {

  @Override
  public String internalServerError() {
    return "/error/500";
  }

  @Override
  public String badRequest() {
    return "/error/400";
  }

  @Override
  public String unauthorized() {
    return "/error/401";
  }

  @Override
  public String forbidden() {
    return "/error/403";
  }

  @Override
  public String notFound() {
    return "/error/404";
  }
}
