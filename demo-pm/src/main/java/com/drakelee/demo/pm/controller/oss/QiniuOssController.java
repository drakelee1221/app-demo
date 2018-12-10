

package com.drakelee.demo.pm.controller.oss;

import com.base.components.common.dto.io.FileDTO;
import com.base.components.common.exception.business.BusinessException;
import com.base.components.common.service.oss.QiniuOssCallback;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.base.Function;
import com.google.common.collect.Lists;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.pm.service.oss.QiniuOssService;
import com.qiniu.util.Auth;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;


/**
 * QiniuOss
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-29 12:00
 */
@RestController
public class QiniuOssController {

  private static final Logger logger = LoggerFactory.getLogger(QiniuOssController.class);

  @Autowired
  private QiniuOssService qiniuOssService;


  /**
   * 获得上传文件凭证 - 外部调用，需要登录
   *
   * @param paramMap -
   * <p> service         - Nullable - Str - 上传后回调自定义方法的key，为空时回调不处理业务
   * <p> keepSrcFileName - Nullable - bool- 是否保留原文件名，默认true
   * <p> isPrivate       - Nullable - bool- 是否为私有文件（必须在通过统一授权oss地址接口时登录系统，公共文件可不用登录），默认true
   * <p> extras          - Nullable - Str - 自定义拓展参数json字符串, 在callback回调时传入
   * @return {"uptoken", "xxx"}
   */
  @RequestMapping(path = GatewayPath.API_PM + "/oss/qiniu/token/uploading", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<ObjectNode> getUploadToken(@RequestParam Map<String, String> paramMap) {
    paramMap.put("userId", TokenThreadLocal.getTokenObjNonNull().objId().toString());
    return new ResponseEntity<>(qiniuOssService.getUploadToken(paramMap), HttpStatus.OK);
  }

  /**
   * 获得下载文件凭证 - 外部调用，需要登录，只能访问用户自己的文件
   *
   * @param paramMap -
   * <p> fileIds      - NonNull - Str - 资源id,多个用 “|” 英文竖线隔开
   * @return 只返回有权限访问的url列表： [{"url":"xxx"}]
   */
  @RequestMapping(path = GatewayPath.API_PM + "/edges/oss/qiniu/token/downloading", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<List<ObjectNode>> getDownloadTokenArray(@RequestParam Map<String, String> paramMap) {
    String fileIds = ConvertUtil.checkNotNull(paramMap, "fileIds", "资源id为空", String.class);
    String[] arr = StringUtils.split(fileIds, "|");
    List<String> list = qiniuOssService.getDownloadTokens(TokenThreadLocal.getTokenObjNonNull().objId().toString(), arr);
    List<ObjectNode> nodes = Lists.transform(list, new Function<String, ObjectNode>() {
      @Override
      public ObjectNode apply(String s) {
        return JsonUtils.mapper.createObjectNode().put("url", s);
      }
    });
    return new ResponseEntity<>(nodes, HttpStatus.OK);
  }

  /**
   * 获得下载文件凭证 - 外部调用，需要登录，只能访问用户自己的文件
   *
   * @param paramMap -
   * <p> jsonArray      - Notnull  - Str - 需要获取凭证的json，格式如：[{"name":"aaa.jpg", "url":"xxx"}]
   * @return [{"name":"aaa.jpg", "url":"xxx"}]
   */
  @RequestMapping(path = GatewayPath.API_PM + "/oss/qiniu/token/downloading/node", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<ArrayNode> getDownloadTokenArrayNode(@RequestParam Map<String, String> paramMap) {
    String jsonArray = ConvertUtil.checkNotNull(paramMap, "jsonArray", String.class);
    ArrayNode arr;
    try {
      arr = JsonUtils.reader(jsonArray, ArrayNode.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("jsonArray 格式错误", e);
    }
    ArrayNode re = qiniuOssService.getDownloadTokens(TokenThreadLocal.getTokenObjNonNull().objId().toString(), arr);
    return new ResponseEntity<>(re, HttpStatus.OK);
  }


  /**
   * 上传成功回调
   *
   * @param request
   * @param paramMap
   * @param userId
   *
   * @return
   * {@code
   * {"fileSize":"130578",
   *  "fileUrl":"http://ottzopivr.bkt.clouddn.com/temp/00000000000000000000000000000000/73eaaf669ee04720a50c75e1d8518ba1.jpg",
   *  "host":"http://ottzopivr.bkt.clouddn.com",
   *  "key":"/temp/00000000000000000000000000000000/73eaaf669ee04720a50c75e1d8518ba1.jpg?e=1501644013\u0026token=c1UkWUwhvdFAB7MmwhwDY1M1qhmreu7uio6qybk3:BVw1UglbyJSGNWmFyg1hwt7E8nQ=",
   *  "service":"26cd2486d72245d6afd07effc4fa359e",
   *  "srcFileName":"153_140922164404_1.jpg",
   *  "success":true,
   *  "userId":"00000000000000000000000000000000"
   *  }
   *  }，<br/>
   * 当返回非200状态时，前端不会得到上面返回的json对象，
   * 所以当需要前端接收自定义异常时，请返回{@link BusinessException}
   */
  @RequestMapping(path = QiniuOssService.CALLBACK_URL
    + "/{userId}/{service}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<ObjectNode> callbackUrl(HttpServletRequest request, @RequestParam Map<String, String> paramMap,
                                                @PathVariable("userId") String userId, @PathVariable("service") String service) {
    logger.info(QiniuOssService.CALLBACK_URL + " >>> userId = {}, service = {}, params = {}", userId, service, paramMap);
    String callbackAuthHeader = request.getHeader("Authorization");
    Auth auth = qiniuOssService.createAuth();
    boolean validCallback = auth.isValidCallback(
      callbackAuthHeader, qiniuOssService.getServerPath() + QiniuOssService.CALLBACK_URL + "/" + userId + "/" + service,
      qiniuOssService.toParamString(paramMap).getBytes(), "application/x-www-form-urlencoded");
    boolean keepSrcFileName = ConvertUtil.convert(paramMap.get("keepSrcFileName"), Boolean.TRUE);
    boolean isPrivate = ConvertUtil.convert(paramMap.get("isPrivate"), Boolean.TRUE);
    String path = QiniuOssService.TEMP_PATH + (isPrivate ? "" : "/" + QiniuOssService.PUBLIC_PATH ) + "/"
      + userId + "/" + qiniuOssService.getRandomFileName(paramMap.get("srcFileName"), keepSrcFileName);
    ObjectNode node = JsonUtils.mapper.createObjectNode()
                                      .put("userId", userId)
                                      .put("service", service)
                                      .put("fileUrl", qiniuOssService.getHost() + "/" + path)
                                      .put("key", qiniuOssService.getDownloadToken(null, path, false)
                                                                 .replace(qiniuOssService.getHost(),""))
                                      .put("host", qiniuOssService.getHost());
    node.setAll(JsonUtils.convert(paramMap, ObjectNode.class));
    if (validCallback) {
      try {
        QiniuOssCallback callback = qiniuOssService.getCallbackService(service);
        if (callback != null) {
          callback.callback(node);
        } else {
          logger.info("未找到业务处理服务");
        }
        node.put("success", true);
        return new ResponseEntity<>(JsonUtils.mapper.createObjectNode()
                                                    .put("key", path)
                                                    .putPOJO("payload", node),
                                    HttpStatus.OK);
      } catch (Exception e) {
        node.put("success", false);
        node.put("errorMsg", e.getMessage());
        logger.error("回调调用业务处理服务失败", e);
      }
    } else {
      node.put("success", false);
      node.put("errorMsg", "回调校验失败");
      logger.warn("回调校验失败");
    }
    return new ResponseEntity<>(node, HttpStatus.BAD_REQUEST);
  }

  /**
   * 预转持久化处理完成回调
   *
   * @param request
   * @param paramMap
   * @param userId
   *
   * @return
   */
  @RequestMapping(path = QiniuOssService.PERSISTENT_NOTIFY_URL
    + "/{userId}/{service}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<ObjectNode> persistentNotifyUrl(HttpServletRequest request,
                                                        @RequestBody Map<String, Object> paramMap, @PathVariable("userId") String userId,
                                                        @PathVariable("service") String service) {
    logger.info(QiniuOssService.PERSISTENT_NOTIFY_URL + " >>> userId = {}, service = {}, params = {}", userId, service, paramMap);
    ObjectNode node = JsonUtils.mapper.createObjectNode().put("userId", userId).put("service", service)
                                      .put("host", qiniuOssService.getHost());
    node.setAll(JsonUtils.convert(paramMap, ObjectNode.class));
    if (StringUtils.isNotBlank(userId) && paramMap != null && !paramMap.isEmpty()) {
      try {
        QiniuOssCallback callback = qiniuOssService.getCallbackService(service);
        if (callback != null) {
          callback.persistentNotify(node);
        }
        return new ResponseEntity<>(node.put("success", true), HttpStatus.OK);
      } catch (Exception e) {
        node.put("success", false);
        node.put("errorMsg", "预转持久化处理完成回调-业务处理失败");
        logger.error("预转持久化处理完成回调-业务处理失败", e);
      }
    }
    return new ResponseEntity<>(node.put("success", false), HttpStatus.BAD_REQUEST);
  }



  /**
   * 获得上传文件凭证 - 内部服务使用
   *
   * @param paramMap -
   * <p> service         - Nullable - Str - 上传后回调自定义方法的key，为空时回调不处理业务
   * <p> keepSrcFileName - Nullable - bool- 是否保留原文件名，默认true
   * <p> isPrivate       - Nullable - bool- 是否为私有文件（必须在通过统一授权oss地址接口时登录系统，公共文件可不用登录），默认true
   * <p> extras          - Nullable - Str - 自定义拓展参数json字符串, 在callback回调时传入
   * <p> userId          - NonNull  - Str - 定义该文件所属的用户
   * @return {"uptoken", "xxx"}
   */
  @RequestMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu/token/uploading", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ObjectNode getUploadTokenForInternal(@RequestParam Map<String, String> paramMap) {
    return qiniuOssService.getUploadToken(paramMap);
  }

  /**
   * 获得下载文件凭证 - 内部服务使用
   *
   * @param paramMap -
   * <p> fileUrls      - NonNull - Str - 资源原地址，可在后面添加自定义参数，如：http://xxx?a=1&b=2，多个用 “|” 英文竖线隔开
   * @return [url]
   */
  @RequestMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu/token/downloading", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public List<String> getDownloadTokenArrayForInternal(@RequestParam Map<String, String> paramMap) {
    String fileUrls = ConvertUtil.checkNotNull(paramMap, "fileUrls", "文件地址为空", String.class);
    String[] arr = StringUtils.split(fileUrls, "|");
    return qiniuOssService.getDownloadTokens(null, arr);
  }

  /**
   * 获得下载文件凭证 - 内部服务使用
   *
   * @param paramMap -
   * <p> jsonArray      - Notnull  - Str - 需要获取凭证的json，格式如：[{"name":"aaa.jpg", "url":"xxx"}]
   * @return [{"name":"aaa.jpg", "url":"xxx"}]
   */
  @RequestMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu/token/downloading/node", method = RequestMethod.GET,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ArrayNode getDownloadTokenArrayNodeForInternal(@RequestParam Map<String, String> paramMap) {
    String jsonArray = ConvertUtil.checkNotNull(paramMap, "jsonArray", String.class);
    ArrayNode arr;
    try {
      arr = JsonUtils.reader(jsonArray, ArrayNode.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("jsonArray 格式错误", e);
    }
    return qiniuOssService.getDownloadTokens(null, arr);
  }

  /**
   * 持久化云对象 - 内部服务使用
   * @param paramMap -
   * <p> service        - Nullable - 回调服务名，用于回调使用
   * <p> userId         - Nullable - 用户ID，用于回调使用
   * <p> jsonArray      - Notnull  - Str - 需要持久化的文件地址json，格式如：[{"name":"aaa.jpg", "url":"xxx"}]
   * @return [{"name":"aaa.jpg", "url":"xxx"}]
   */
  @RequestMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu/persistent", method = RequestMethod.POST,
    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ArrayNode persistent(@RequestBody Map<String, String> paramMap) {
    String userId = paramMap.get("userId");
    String service = paramMap.get("service");
    String jsonArray = ConvertUtil.checkNotNull(paramMap, "jsonArray", String.class);
    ArrayNode arr;
    try {
      arr = JsonUtils.reader(jsonArray, ArrayNode.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("jsonArray 格式错误", e);
    }
    return qiniuOssService.persistent(service, userId, arr);
  }

  /**
   * 服务器覆盖上传文件
   * @param file -
   * <p> userId           - Notnull  - Str - 用户ID，文件所属用户
   * <p> fileName         - Notnull  - Str - 文件名，如：.docx
   * <p> uploadBytes      - Notnull  - Str - 文件字节数组
   * <p> privateFile      - Notnull  - Bool- 是否为私有文件
   * <p> tempFile         - Notnull  - Bool- 是否为临时文件
   * <p> path             - Nullable - Str - 上传时的url路径，文件地址回最终生成为：{tempFile}/{privateFile}/userId/path/fileName
   * @return {"name":"", "url":""}
   */
  @PostMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu/uploading", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ObjectNode serverUploadFile(@RequestBody FileDTO file){
    Assert.notNull(file, "file 为空");
    return qiniuOssService.serverUploadFile(file);
  }

  /**
   * 删除文件 - 内部服务使用
   *
   * @param paramMap -
   * <p> userId        - Nullable - 用户ID，如果不为空，则只能删除该用户的文件
   * <p> fileUrls      - NonNull - Str - 资源原地址，可在后面添加自定义参数，如：http://xxx?a=1&b=2，多个用 “|” 英文竖线隔开
   * @return [url]
   */
  @DeleteMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public List<String> deleteFile(@RequestParam Map<String, String> paramMap){
    String fileUrls = ConvertUtil.checkNotNull(paramMap, "fileUrls", "文件地址为空", String.class);
    String[] arr = StringUtils.split(fileUrls, "|");
    return qiniuOssService.deleteFile(paramMap.get("userId"), arr);
  }
}
