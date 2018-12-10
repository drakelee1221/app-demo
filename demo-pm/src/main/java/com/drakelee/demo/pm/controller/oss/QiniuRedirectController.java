

package com.drakelee.demo.pm.controller.oss;

import com.base.components.common.exception.auth.AuthException;
import com.base.components.common.exception.auth.OssRedirectAuthException;
import com.base.components.common.token.TokenCacheObj;
import com.base.components.common.token.TokenManager;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.ExceptionUtil;
import com.base.components.common.util.ServletContextHolder;
import com.fasterxml.jackson.databind.JsonNode;
import com.drakelee.demo.common.constants.oss.OssConstant;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.token.TokenThreadLocal;
import com.drakelee.demo.pm.handler.auth.AuthHandler;
import com.drakelee.demo.pm.service.oss.QiniuOssService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * OSS文件统一授权访问重定向接口
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-12-20 9:54
 */
@Controller
public class QiniuRedirectController {

  @Autowired
  private QiniuOssService qiniuOssService;

  @Autowired
  private AuthHandler authHandler;

  @Autowired
  private TokenManager tokenManager;

  public static final String PARAM_TOKEN_KEY = "__token__";

  /**
   * OSS文件统一授权访问重定向接口
   *
   * @param params -
   * <p> file             - Notnull  - Str - oss文件地址
   * <p> __token__        - Nullable - Str - 登录token，私有文件需要传入
   *
   * @return redirect string
   *
   * @throws Exception
   */
  @GetMapping(OssConstant.REDIRECT_URL)
  public String redirect(@RequestParam Map<String, String> params) throws Exception {
    return ServletContextHolder.sendRedirectString("redirect:" + getRedirectString(params));
  }

  /**
   * OSS文件统一授权访问重定向接口 - 服务内部专用
   *
   * @param params -
   * <p> file             - Notnull  - Str - oss文件地址
   * <p> fileId           - Notnull  - Str - oss文件id
   *
   * @return redirect string
   *
   * @throws Exception
   */
  @GetMapping(GatewayPath.API_INTERNALS + "/edges/oss/redirect")
  @ResponseBody
  public String redirectInternals(@RequestParam Map<String, String> params) throws Exception {
    if (StringUtils.isAllBlank(params.get("file"), params.get("fileId"))) {
      return "";
    }
    return getRedirectInternalsString(params.get("file"), params.get("fileId"));
  }

  /**
   * 获取OSS文件统一授权访问重定向链接接口
   *
   * @param params -
   * <p> file             - Nullable  - Str - oss文件地址  与fileId二选一填入
   * <p> fileId           - Nullable  - Str - 文件记录id   与file二选一填入
   * <p> __token__        - Nullable  - Str - 登录token，私有文件需要传入
   *
   * @return redirect string
   *
   * @throws Exception
   */
  @GetMapping(GatewayPath.API_PM + "/edges/oss/redirect-string")
  @ResponseBody
  public String redirectString(@RequestParam Map<String, String> params) throws Exception {
    return getRedirectString(params);
  }

  private String getRedirectString(Map<String, String> params) throws Exception {
    String file = params.get("file");
    String fileId = params.get("fileId");
    String url = file;
    try {
      if (StringUtils.isNotBlank(fileId)) {
        TokenCacheObj tokenObj = TokenThreadLocal.getTokenObj();
        if (tokenObj == null) {
          tokenObj = tokenManager.getByToken(params.get(PARAM_TOKEN_KEY));
        }
        ExceptionUtil.hasauth(tokenObj != null);
        JsonNode node = authHandler.getRedirectString(tokenObj.objId().toString(), fileId);
        ExceptionUtil.hasauth(node.get("hasauth").booleanValue());
        return new String(node.get("url").textValue().getBytes("UTF-8"), "ISO8859_1");
      } else if (StringUtils.isNotBlank(file)) {
        if (file.startsWith(qiniuOssService.getHost()) || file.startsWith("/")) {
          //私有文件
          ExceptionUtil.hasauth(qiniuOssService.checkIsPublic(file) || qiniuOssService.checkIsTemp(file));
          Boolean isNoCache = ConvertUtil.convertNullable(params.get("isNoCache"), Boolean.class);
          if (isNoCache != null && isNoCache) {
            file = file + "?v=" + System.currentTimeMillis();
          }
          url = qiniuOssService.getDownloadToken(null, file, true);
        }
        return new String(url.getBytes("UTF-8"), "ISO8859_1");
      }
    } catch (AuthException e) {
      throw new OssRedirectAuthException(e);
    }
    return "/info";
  }

  private String getRedirectInternalsString(String file, String fileId) {
    return authHandler.getRedirectInternalsString(file, fileId);
  }
}
