

package com.drakelee.demo.pm.service.oss;

import com.drakelee.demo.pm.handler.auth.AuthHandler;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.base.components.common.dto.io.FileDTO;
import com.base.components.common.service.oss.QiniuOssCallback;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.URLUtil;
import com.base.components.common.util.UUIDUtils;
import com.drakelee.demo.pm.handler.auth.AuthHandler;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.processing.OperationManager;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * 七牛oss
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-29 11:57
 *
 */
@Service
@RefreshScope
@ConditionalOnProperty({"base.oss.qiniu.accessKey",
                        "base.oss.qiniu.secretKey"})
public class QiniuOssService {

  private static final Logger logger = LoggerFactory.getLogger(QiniuOssService.class);

  /** 临时文件地址前缀 */
  public static final String TEMP_PATH = "temp";

  /** 公共文件（可不用登录）地址前缀 */
  public static final String PUBLIC_PATH = "pub";

  /** 上传回调地址URI */
  public static final String CALLBACK_URL = GatewayPath.API_PM + "/oss/qiniu/callback";

  /** 持久化回调地址URI */
  public static final String PERSISTENT_NOTIFY_URL = GatewayPath.API_PM + "/oss/qiniu/callback/persistent";


  //        华东	Zone.zone0()
  //        华北	Zone.zone1()
  //        华南	Zone.zone2()
  //        北美	Zone.zoneNa0()
  private static Zone zone = Zone.zone2();

  @Autowired(required = false)
  private List<QiniuOssCallback> qiniuOssCallbacks;

  /**
   * 将自定义的回调方法处理接口放入此map中
   */
  private static final Map<String, QiniuOssCallback> callbacks = Maps.newConcurrentMap();

  @Value("${base.oss.qiniu.accessKey}")
  private String accessKey;

  @Value("${base.oss.qiniu.secretKey}")
  private String secretKey;

  @Value("${base.oss.qiniu.bucket}")
  private String bucket;

  @Value("${base.oss.qiniu.host}")
  private String host;

  @Value("${base.oss.qiniu.persistentPipeline}")
  private String persistentPipeline;

  @Value("${base.oss.qiniu.tokenExpireSeconds}")
  private int tokenExpireSeconds;

  @Value("${base.host.api}")
  private String serverPath;

  @Value("${base.oss.qiniu.fileSizeByte}")
  private long fileSizeByte;

  @Value("${base.oss.qiniu.tempFileDeleteDays}")
  private int tempFileDeleteDays;

  @Autowired
  private AuthHandler authHandler;


  /**
   * 获取已注册的自定义回调服务
   * @param key
   * @return
   */
  public QiniuOssCallback getCallbackService(String key){
    return callbacks.get(key);
  }

  /**
   * 创建鉴权对象
   * @return
   */
  public Auth createAuth(){
    return Auth.create(accessKey, secretKey);
  }


  /**
   * 获得下载文件凭证
   * @param fileUrl     - NonNull  - Str  - 资源原地址，可在后面添加自定义参数，如：http://xxx?a=1&b=2
   * @param userId      - Nullable - Str  - 非空时，验证资源是否属于该用户
   * @param interval    - Nullable - bool - 是否计算间隔时间
   * @return 无权限访问时，返回空
   */
  public String getDownloadToken(String userId, String fileUrl, boolean interval) {
    Assert.hasText(fileUrl, "文件地址为空");
    if(userId != null && !fileUrl.contains(userId)){
      return null;
    }
    fileUrl = deepDecoding(fileUrl);
    fileUrl = fileUrl.replace(host, "");
    if(fileUrl.startsWith("http")){
      return fileUrl;
    }
    String otherQueryStr = "";
    if (fileUrl.contains("?")) {
      otherQueryStr = getQueryString(fileUrl.substring(fileUrl.indexOf("?") + 1, fileUrl.length()));
      fileUrl = fileUrl.substring(0, fileUrl.indexOf("?"));
    }
    fileUrl = fileUrl.startsWith("/") ? fileUrl.substring(1, fileUrl.length()) : fileUrl;
    String encodingFileUrl = splitEncoding(fileUrl, "/");
    Auth auth = createAuth();
    String url = auth.privateDownloadUrl(host + "/" + encodingFileUrl,
                                         buildExpireSeconds(interval) );
//    return host + "/" + fileUrl + url.substring(url.indexOf("?"), url.length()) + otherQueryStr;
    return url + otherQueryStr;
  }

  /**
   * 获得下载文件凭证
   * @param userId      - Nullable - Str - 非空时，验证资源是否属于该用户
   * @param fileUrls    - NonNull  - Str - 资源原地址，可在后面添加自定义参数，如：http://xxx?a=1&b=2
   * @return 只返回有权限访问的url列表
   */
  public List<String> getDownloadTokens(String userId, String... fileUrls) {
    List<String> list = Lists.newArrayList();
    for (String fileUrl : fileUrls) {
      JsonNode result = authHandler.getRedirectString(userId, fileUrl);
      if(result.get("hasauth").booleanValue()){
        list.add(result.get("url").textValue());
      }
    }
    return list;
  }

  /**
   * 获得下载文件凭证
   * @param userId      - Nullable - Str - 非空时，验证资源是否属于该用户
   * @param arrayNode   - Notnull  - Str - 需要获取凭证的json，格式如：[{"name":"aaa.jpg", "url":"xxx"}]
   * @return 只返回有权限访问的url列表
   */
  public ArrayNode getDownloadTokens(String userId, ArrayNode arrayNode) {
    ArrayNode array = JsonUtils.mapper.createArrayNode();
    for (JsonNode node : arrayNode) {
      JsonNode urlNode = node.get("url");
      if(urlNode != null){
        JsonNode result = authHandler.getRedirectString(userId, urlNode.asText());
        if(result.get("hasauth").booleanValue()){
          array.add(JsonUtils.mapper.createObjectNode()
                                    .put("url", result.get("url").textValue())
                                    .set("name", node.get("name")));
        }
      }
    }
    return array;
  }


  /**
   * 获得上传文件凭证
   *
   * @param paramMap
   *        <p> service         - Nullable - Str - 上传后回调自定义方法的key，为空时回调不处理业务
   *        <p> keepSrcFileName - Nullable - bool- 是否保留原文件名，默认true
   *        <p> extras          - Nullable - Str - 自定义拓展参数json字符串, 在callback回调时传入
   *        <p> userId          - NonNull  - Str - 定义该文件所属的用户
   * @return {"uptoken", "xxx"}
   */
  public ObjectNode getUploadToken(Map<String, String> paramMap) {
    String userId = ConvertUtil.checkNotNull(paramMap, "userId", "用户ID未获取", String.class);
    String service = ConvertUtil.convert(paramMap.get("service"), UUIDUtils.generateKey());
    Boolean keepSrcFileName = ConvertUtil.convert(paramMap.get("keepSrcFileName"), Boolean.TRUE);
    Boolean isPrivate = ConvertUtil.convert(paramMap.get("isPrivate"), Boolean.TRUE);
//    String fileName = checkFileName(paramMap.get("fileName"));
//    String suffix = ConvertUtil.convert(paramMap.get("suffix"), "")
//                               .replaceAll("\\.", "");
    Auth auth = createAuth();
//    String path = userId + "/" +  fileName + (StringUtils.isBlank(suffix)?"":"." + suffix);
    StringMap putPolicy = new StringMap();
    // 数据处理指令，支持多个指令
//    String saveFileEntry = String.format("%s:%s", getBucket(), path);
//    String saveAsOps = String.format("saveas/%s", UrlSafeBase64.encodeToString(saveFileEntry));
    // 将多个数据处理指令拼接起来
//    String persistentOpfs = StringUtils.join(new String[] {saveAsOps}, ";");
    //    putPolicy.put("mimeLimit", "image/*");
//    putPolicy.put("persistentOps", persistentOpfs);
    // 数据处理队列名称，必填
//    putPolicy.put("persistentPipeline", getPersistentPipeline());

    //    putPolicy.put("returnBody",
    //                  "{\"key\":\"$(key)\",\"hash\":\"$(etag)\",\"bucket\":\"$(bucket)\",\"fsize\":$(fsize)}");

    putPolicy.put("fsizeLimit", fileSizeByte);
    putPolicy.put("deleteAfterDays", tempFileDeleteDays);
    putPolicy.put("callbackFetchKey", 1);
    Map<String, String> callbackBody = Maps.newHashMap();
//    callbackBody.put("fileUrl", String.format("%s/%s", getHost(), path));
    callbackBody.put("srcFileName", "$(fname)");
    callbackBody.put("fileSize", "$(fsize)");
    callbackBody.put("keepSrcFileName", keepSrcFileName.toString());
    callbackBody.put("isPrivate", isPrivate.toString());
    putExtraParams(callbackBody, paramMap.get("extras"));
    // 数据处理完成结果通知地址
    String body = toParamString(callbackBody);
    putPolicy.put("callbackUrl", getServerPath() + CALLBACK_URL + "/" + userId + "/" + service)
             .put("callbackBody", body);

    // 预转持久化处理完成回调： 数据转存转码，异步通知地址
//    putPolicy.put("persistentNotifyUrl", getServerPath() + persistentNotifyUrl + "/" + userId + "/" + service);
    String upToken = auth.uploadToken(getBucket(), null, getTokenExpireSeconds(), putPolicy);
    logger.info("/oss/qiniu/img/uploadToken , callbackBody = " + body);
    return JsonUtils.mapper.createObjectNode().put("uptoken", upToken);
  }


  /**
   * 持久化文件资源，只对temp开头的资源有效
   * @param service - Nullable - 回调服务名，用于回调使用
   * @param userId  - Nullable - 用户ID，用于回调使用
   * @param array   - NonNull  - 需要持久化的文件地址json，格式如：[{"name":"aaa.jpg", "url":"xxx"}]
   * @return [{"name":"aaa.jpg", "url":"xxx"}]
   */
  public ArrayNode persistent(String service, String userId, ArrayNode array){
    String persistentNotify = "";
    if(service != null && userId != null){
      persistentNotify = PERSISTENT_NOTIFY_URL + "/" + userId + "/" + service;
    }
    ArrayNode list = JsonUtils.mapper.createArrayNode();
    if(array == null || array.size() == 0){
      return list;
    }
    for (JsonNode node : array) {
      JsonNode keyNode = node.get("url");
      if (keyNode != null ) {
        String key = keyNode.asText();
        key = deepDecoding(key);
        if(key.contains("?")){
          key = key.substring(0, key.indexOf("?"));
        }
        key = key.replace(host, "");
        key = key.startsWith("/") ? key.substring(1, key.length()) : key;
        String targetKey = key.replace(TEMP_PATH + "/", "");
        Auth auth = createAuth();
        String saveFileEntry = String.format("%s:%s", getBucket(), targetKey);
        String saveAsOps = String.format("saveas/%s", UrlSafeBase64.encodeToString(saveFileEntry));
        String persistentOpfs = StringUtils.join(new String[] {saveAsOps}, ";");

        StringMap putPolicy = new StringMap();
        putPolicy.put("persistentOps", persistentOpfs);
        putPolicy.put("persistentPipeline", getPersistentPipeline());

        Configuration cfg = new Configuration(zone);
        OperationManager operationManager = new OperationManager(auth, cfg);
        try {
          //可以根据该 persistentId 查询任务处理进度
          String persistentId = operationManager
            .pfop(bucket, key, persistentOpfs, persistentPipeline, persistentNotify, true);
          list.add(JsonUtils.mapper.createObjectNode()
                                   .put("url", "/" + targetKey)
                                   .set("name", node.get("name")));
          //解析 operationStatus 的结果
        } catch (QiniuException e) {
          logger.error(e.response.toString(), e);
        } catch (Exception ex) {
          logger.error("", ex);
        }
      }
    }
    return list;
  }

  /**
   * 服务器覆盖上传文件
   * @param file -
   * <p> userId           - Notnull  - Str - 用户ID，文件所属用户
   * <p> fileName         - Notnull  - Str - 文件名，如：.docx
   * <p> uploadBytes      - Notnull  - Str - 文件字节数组
   * <p> privateFile      - Notnull  - Bool- 是否为私有文件
   * <p> tempFile         - Notnull  - Bool- 是否为临时文件
   * <p> path             - Nullable - Str - 上传时的url路径，文件地址回最终生成为：{tempFile}/{privateFile}/userId/path/random/fileName
   * @return {"name":"", "url":""}
   */
  public ObjectNode serverUploadFile(FileDTO file){
    Assert.hasText(file.getUserId(), "userId 为空");
    Assert.hasText(file.getFileName(), "fileName 为空");
    Assert.isTrue(file.getUploadBytes() != null && file.getUploadBytes().length > 0, "上传文件为空");
    String key = "";
    try {
      Configuration cfg = new Configuration(zone);
      UploadManager uploadManager = new UploadManager(cfg);
      String path = replaceStartAndEnd(file.getPath(), "/", "");
      String fileName = replaceStartAndEnd(file.getFileName(), "/", "");
      key = joinUrl(
        (file.getTempFile() ? TEMP_PATH : ""),
        (file.getPrivateFile() ? "" : PUBLIC_PATH),
        file.getUserId(),
        (path == null ? "": path),
        UUIDUtils.generateKey(),
        (fileName == null ? "": URLUtil.encode(fileName, '-')));
      Auth auth = createAuth();
      String upToken = auth.uploadToken(getBucket(), key);
      Response response = uploadManager.put(file.getUploadBytes(), key, upToken);
      logger.info("服务器直传文件成功：" + key);
      return JsonUtils.mapper.createObjectNode()
                             .put("name", file.getFileName())
                             .put("url", getDownloadToken(null, key, false));
    } catch (QiniuException e) {
      logger.error("服务器直传文件失败：" + key, e);
      throw new IllegalArgumentException(e.response.toString(), e);
    }catch (Exception ex){
      throw new IllegalArgumentException(ex);
    }
  }

  /**
   * 删除文件
   * @param userId        - Nullable - 用户ID，如果不为空，则只能删除该用户的文件
   * @param fileUrls      - NonNull - Str - 资源原地址，可在后面添加自定义参数，如：http://xxx?a=1&b=2，多个用 “|” 英文竖线隔开
   *
   * @return
   */
  public List<String> deleteFile(String userId, String ... fileUrls){
    List<String> deleted = Lists.newArrayList();
    if(fileUrls != null && fileUrls.length > 0){
      Auth auth = createAuth();
      Configuration cfg = new Configuration(Zone.zone1());
      BucketManager bucketManager = new BucketManager(auth, cfg);
      for (String url : fileUrls) {
        String key = url.replace(host, "");
        Assert.isTrue(userId == null || key.contains(userId),
                      "该用户 ("+userId+") 未能授权删除文件：" + url);
        try {
          bucketManager.delete(bucket, key);
          deleted.add(url);
        } catch (QiniuException e) {
          logger.error("删除文件失败：" + key, e);
        }
      }
    }
    return deleted;
  }










  /** 用 split 分割后，分段转码 */
  private String splitEncoding(String url, String split){
    String[] arr = StringUtils.split(url, split);
    try {
      for (int i = 0; i < arr.length; i++) {
        arr[i] = URLEncoder.encode(arr[i], "utf-8").replace("+", "%20");
      }
      return StringUtils.join(arr, split);
    } catch (UnsupportedEncodingException e) {
      throw new IllegalArgumentException("文件地址格式出错", e);
    }
  }

  /** 获取下载连接时原连接中的请求参数，除去签名会生成的 e和 token */
  private String getQueryString(String queryStr){
    String[] arr = StringUtils.split(queryStr, "&");
    StringBuilder str = new StringBuilder();
    for (String q : arr) {
      if (!q.startsWith("e") && !q.startsWith("token")) {
        str.append("&").append(q);
      }
    }
    return str.toString();
  }

  public String getRandomFileName(String fileName, boolean keepSrcFileName){
    try {
      if(keepSrcFileName){
        return UUIDUtils.generateKey() + "/" + URLUtil.encode(fileName, '-');
      }
      String suffix = fileName.contains(".") ? fileName.substring(fileName.indexOf("."), fileName.length()) : "";
      return UUIDUtils.generateKey() + suffix;
    } catch (Exception e) {
      throw new IllegalArgumentException(e);
    }
  }

  public boolean checkIsPublic(String url){
    return url.startsWith("/") ?
           (url.startsWith("/" + PUBLIC_PATH) || url.startsWith("/" + TEMP_PATH + "/" + PUBLIC_PATH))
           : (url.startsWith(host + "/" + PUBLIC_PATH) || url.startsWith(host + "/" + TEMP_PATH + "/" + PUBLIC_PATH )) ;
  }

  public boolean checkIsTemp(String url){
    return url.startsWith("/") ? url.startsWith("/" + TEMP_PATH) : url.startsWith(host + "/" + TEMP_PATH);
  }

  /** 去掉带 . 的文件名后缀 */
  private String checkFileName(String fileName) {
    if(StringUtils.isBlank(fileName)){
      return UUIDUtils.generateKey();
    }
    int index = fileName.lastIndexOf(".");
    if (index >= 0) {
      fileName = fileName.substring(0, index);
    }
    if(StringUtils.isBlank(fileName)){
      return UUIDUtils.generateKey();
    }
    return fileName;
  }









  /**
   * 将拓展参数put进callbackBody
   * @param callbackBody
   * @param extras
   */
  private void putExtraParams(Map<String, String> callbackBody, String extras) {
    if (StringUtils.isNotBlank(extras) && callbackBody != null) {
      try {
        Map<String, String> extrasMap =
          JsonUtils.reader(extras, new TypeReference<Map<String, String>>() {});
        if (extrasMap != null && !extrasMap.isEmpty()) {
          callbackBody.putAll(extrasMap);
        }
      } catch (IOException e) {
        throw new IllegalArgumentException("拓展参数解析异常 extras = " + extras, e);
      }
    }
  }

  public String toParamString(Map<String, String> paramMap) {
    List<String> list = Lists.newArrayList();
    List<String> keys = Lists.newArrayList(paramMap.keySet());
    Collections.sort(keys);
    try {
      for (String key : keys) {
        String v = paramMap.get(key);
        if(v == null){
          list.add(key + "=");
        }
        else if( v.startsWith("$(") && v.endsWith(")")){
          list.add(key + "=" + v);
        }else{
          list.add(key + "=" + URLEncoder.encode(v, "UTF-8"));
        }
      }
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }
    return StringUtils.join(list, "&");
  }

  private static String replaceStartAndEnd(String src, String match, String replaceStr){
    if(src == null){
      return null;
    }
    boolean check = true;
    if(src.startsWith(match)){
      src = replaceStr + src.substring(1, src.length());
      check = false;
    }
    if(src.endsWith(match)){
      src = src.substring(0, src.length() - 1) + replaceStr;
      check = false;
    }
    if(check){
      return src;
    }else{
      return replaceStartAndEnd(src, match, replaceStr);
    }
  }

  private static String deepDecoding(String src){
    String t = src;
    try {
      String decoded = URLDecoder.decode(src, "UTF-8");
      if(decoded.equals(src)){
        t = decoded;
      }else{
        t = deepDecoding(decoded);
      }
    } catch (Exception ignore) {
    }
    return t;
  }


  private volatile boolean init;

  @PostConstruct
  public void init(){
    if(!init){
      if( qiniuOssCallbacks != null){
        for (QiniuOssCallback qiniuOssCallback : qiniuOssCallbacks) {
          callbacks.put(qiniuOssCallback.getServiceKey(), qiniuOssCallback);
        }
      }
      init = true;
    }
  }

  private static String joinUrl(String...path){
    List<String> url = Lists.newArrayList();
    for (String s : path) {
      if(StringUtils.isNotBlank(s)){
        url.add(s);
      }
    }
    return StringUtils.join(url, "/");
  }


  public String getAccessKey() {
    return accessKey;
  }

  public String getSecretKey() {
    return secretKey;
  }

  public String getBucket() {
    return bucket;
  }

  public String getHost() {
    return host;
  }

  public String getPersistentPipeline() {
    return persistentPipeline;
  }

  public int getTokenExpireSeconds() {
    return tokenExpireSeconds;
  }

  public String getServerPath() {
    return serverPath;
  }


  /**
   * 通过间隔时间计算失效时间，比如总失效时间时30分钟，当前时间为01:14，则失效时时间为01:35；<br>
   * 计算公式：{@code
   *    e = 总失效时间;
   *    c = 当前分钟值；
   *
   *    (((c / e ) + 1 ) *  e - c + 5)分钟
   *
   * }
   * @param interval 是否计算间隔时间
   *
   * @return 失效时间
   */
  private long buildExpireSeconds(boolean interval){
    if(interval){
      int e = getTokenExpireSeconds() / 60;
      DateTime date = DateTime.now().secondOfMinute().setCopy(0).millisOfSecond().setCopy(0);
      int c = date.minuteOfHour().get();
      date = date.plusMinutes(((c / e) + 1) * e - c + 5);
      return ( date.getMillis() - System.currentTimeMillis() ) / 1000;
    }else{
      return getTokenExpireSeconds();
    }
  }
}
