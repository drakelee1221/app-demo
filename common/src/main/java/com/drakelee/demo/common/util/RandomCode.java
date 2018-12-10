package com.drakelee.demo.common.util;

/**
 * RandomCode
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version v1.0.0
 * @date 2018-09-12 10:15
 */
public class RandomCode {

  public static String generateCoupon(){
    return generateRandomStr(15);
  }

  public static String generateRandomStr(int len) {
    // 字符源，可以根据需要删减
    String generateSource = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String rtnStr = "";
    for (int i = 0; i < len; i++) {
      //循环随机获得当次字符，并移走选出的字符
      String nowStr = String.valueOf(generateSource.charAt((int) Math.floor(Math.random() * generateSource.length())));
      rtnStr += nowStr;
      generateSource = generateSource.replaceAll(nowStr, "");
    }
    return rtnStr;
  }
}
