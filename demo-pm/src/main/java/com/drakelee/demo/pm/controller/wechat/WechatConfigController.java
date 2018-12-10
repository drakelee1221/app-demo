package com.drakelee.demo.pm.controller.wechat;

import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.util.ConvertUtil;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.mp.api.WxMpService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.net.URLDecoder;
import java.util.Map;

/**
 * WechatConfigController
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-07-24 10:28
 */
@RequestMapping(GatewayPath.API_PM)
@RestController
public class WechatConfigController {
  private static Logger logger = LoggerFactory.getLogger(WechatConfigController.class);
  @Autowired
  private WxMpService mpService;
  /**
   * 获取微信分享配置
   * @return
   */
  @GetMapping(value = "/wechat/share/config",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getShareConfig(@RequestParam Map<String,String> param) throws Exception {
    String url = ConvertUtil.checkNotNull(param,"url","url不能为空",String.class);
    logger.info("url:"+url);
    url = URLDecoder.decode(url,"utf-8");
    logger.info("test url:"+url);
    WxJsapiSignature jsapiTicket = mpService.createJsapiSignature(url);
    return new ResponseEntity<>(jsapiTicket, HttpStatus.OK);
  }
}
