package com.drakelee.demo.common.dto.mail;

/**
 * Mailable
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version v1.0.0
 * @date 2018-07-17 13:38
 */
public interface Mailable {
  String getSmtp();

  String getAddress();

  String getPassword();
}
