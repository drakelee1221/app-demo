

package com.drakelee.demo.feign.client.pm;

import com.base.components.common.dto.io.FileDTO;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

/**
 * 七牛OSS 内部调用接口
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-08-01 15:04
 */
@FeignClient(value = "${module-pm}")
public interface OssQiniuClient {

  /**
   * 服务器上传文件
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
  ObjectNode serverUploadFile(@RequestBody FileDTO file);


  /**
   * 持久化云对象 - 内部服务使用
   * @param paramMap-
   * <p> service        - Nullable - 回调服务名，用于回调使用
   * <p> userId         - Nullable - 用户ID，用于回调使用
   * <p> jsonArray      - Notnull  - Str - 需要持久化的文件地址json，格式如：[{"name":"aaa.jpg", "url":"xxx"}]
   * @return [{"name":"aaa.jpg", "url":"xxx"}]
   *
   * @return
   */
  @PostMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu/persistent", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ArrayNode persistent(@RequestBody Map<String, String> paramMap);


  /**
   * 删除文件 - 内部服务使用
   *
   * @param paramMap -
   * <p> userId        - Nullable - 用户ID，如果不为空，则只能删除该用户的文件
   * <p> fileUrls      - NonNull - Str - 资源原地址，可在后面添加自定义参数，如：http://xxx?a=1&b=2，多个用 “|” 英文竖线隔开
   * @return [url]
   */
  @DeleteMapping(path = GatewayPath.API_INTERNALS + "/edges/oss/qiniu", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  List<String> deleteFile(@RequestParam Map<String, String> paramMap);

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
  String redirectInternals(@RequestParam Map<String, String> params);
}
