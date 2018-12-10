package com.drakelee.demo.admin.service.attachment;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Maps;
import com.drakelee.demo.admin.util.AuthUtilHelper;
import com.drakelee.demo.common.constants.admin.AuthCode;
import com.drakelee.demo.common.constants.oss.OssConstant;
import com.drakelee.demo.common.constants.sys.FileType;
import com.drakelee.demo.common.domain.sys.Attachment;
import com.base.components.common.dto.io.FileDTO;
import com.base.components.common.exception.business.BusinessException;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.URLUtil;
import com.drakelee.demo.database.dao.sys.AttachmentDao;
import com.drakelee.demo.feign.client.pm.OssQiniuClient;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/4/4 0004 10:40
 */
@Service
public class AttachmentService {

  @Autowired
  private OssQiniuClient ossQiniuClient;

  @Autowired
  private AttachmentDao attachmentDao;

  public ArrayNode persistent(ArrayNode arr, boolean flag, String userId) {
    if (arr.size() == 0) {
      return null;
    }
    Map<String, String> map = Maps.newHashMap();
    map.put("userId", userId);
    if (flag) {
      map.put("jsonArray", arr.toString());
    } else {
      map.put("jsonArray", getPersistentArrayNode(arr).toString());
    }
    ArrayNode persistent = ossQiniuClient.persistent(map);
    Assert.isTrue(persistent.size() > 0, "持久化附件失败，请联系管理员");
    return persistent;
  }

  /**
   * 上传临时文件
   *
   * @param file
   *
   * @return
   */
  public ObjectNode uploadAtta(MultipartFile file, boolean isPrivate) {
    String userId = "temp";
    Assert.notNull(file, "上传文件为空");
    Long fileSize = file.getSize();
    Assert.isTrue(fileSize <= 10 * 1024 * 1024, "上传文件太大");
    String fileName = file.getOriginalFilename();
    // 上传至云服务器(临时文件名)
    FileDTO fileDTO = new FileDTO();
    fileDTO.setFileName(fileName);
    fileDTO.setUserId(userId);
    fileDTO.setTempFile(Boolean.TRUE);
    fileDTO.setPrivateFile(isPrivate);
    try {
      fileDTO.setUploadBytes(file.getBytes());
    } catch (IOException e) {
      Assert.isTrue(false, "上传文件出现异常");
    }
    ObjectNode objectNode = ossQiniuClient.serverUploadFile(fileDTO);
    objectNode.put("size", Double.valueOf(fileSize) / 1000);
    return objectNode;
  }


  /**
   * 持久化附件到附件表
   *
   * @param userId 用户id
   * @param attas - 附件json字符串
   * [
   * {
   * "attaName":"后台样式.doc",
   * "attaRemark":"",
   * "attaUrl":"http://p618oy41v.bkt.clouddn.com/temp/pub/temp/867bf3c9361a419aae61626b5caecabd/后台样式
   * .doc?e=1523850424&token=k3MuqdLb5FXihNYeYJiCnKR5Y2mo5UNLJg3DZeiU:p7ujTz9hmmIh5YDfcqdST4LYCPw=",
   * "attaSize":"31.744k"
   * },
   * {
   * "attaName":"本机IP.png",
   * "attaRemark":"",
   * "attaUrl":"http://p618oy41v.bkt.clouddn.com/temp/pub/temp/e4ebccae9f4941b7b0a80bcea09c3428/本机IP
   * .png?e=1523850523&token=k3MuqdLb5FXihNYeYJiCnKR5Y2mo5UNLJg3DZeiU:qkf9AUQ1Y1icWOXquQY8htrgdIA=",
   * "attaSize":"31.502k"
   * }
   * ]
   * @param refId 关联id
   */
  public void dealAttas(String userId, String attas, String refId) {
    Map<String, String> paramMap = new HashMap<>(2);
    paramMap.put("userId", userId);
    List<Attachment> attachments = new ArrayList<>();
    JSONArray obj = JSON.parseArray(attas);
    ArrayNode arrayNode = JsonUtils.mapper.createArrayNode();
    Map<String, String> tempRemark = Maps.newHashMap();
    Map<String, String> tempSize = Maps.newHashMap();
    for (Object item : obj) {
      JSONObject jsonObject = (JSONObject) item;
      String url = jsonObject.getString("attaUrl");
      String name = jsonObject.getString("attaName");
      String remark = jsonObject.getString("attaRemark");
      String size = jsonObject.getString("attaSize");
      Assert.notNull(url, "url为空");
      if (url.indexOf("/temp/") > 0) {
        ObjectNode objectNode = JsonUtils.mapper.createObjectNode();
        objectNode.put("name", name);
        objectNode.put("url", url);
        tempRemark.put(name, remark);
        tempSize.put(name, size);
        arrayNode.add(objectNode);
      } else {
        Attachment attachment = new Attachment();
        attachment.setName(name);
        attachment.setRefId(refId);
        attachment.setFileType(FileType.OTHER.getVal());
        attachment.setUrl(url);
        attachment.setRemark(remark);
        attachment.setSize(size);
        attachments.add(attachment);
      }
    }
    paramMap.put("jsonArray", arrayNode.toString());
    ArrayNode newAttas = ossQiniuClient.persistent(paramMap);
    for (JsonNode node : newAttas) {
      Attachment attachment = new Attachment();
      attachment.setName(node.get("name").asText());
      attachment.setRefId(refId);
      attachment.setFileType(FileType.OTHER.getVal());
      String url = node.get("url").asText();
      url = url.substring(url.indexOf("/pub/"));
      attachment.setUrl(url);
      attachment.setRemark(tempRemark.get(attachment.getName()));
      attachment.setSize(tempSize.get(attachment.getName()));
      attachments.add(attachment);
    }
    attachmentDao.saveAll(attachments);

  }

  /**
   * 获取持久化后的json串
   * @param attas
   */
  public ArrayNode dealAttas(String attas) {
    Map<String, String> paramMap = new HashMap<>(2);
    JSONArray obj = JSON.parseArray(attas);
    ArrayNode arrayNode = JsonUtils.mapper.createArrayNode();
    ArrayNode resultNode = JsonUtils.mapper.createArrayNode();
    for (Object item : obj) {
      JSONObject jsonObject = (JSONObject) item;
      String url = jsonObject.getString("attaUrl");
      String name = jsonObject.getString("attaName");
      String remark = jsonObject.getString("attaRemark");
      String size = jsonObject.getString("attaSize");
      Assert.notNull(url, "url为空");
      ObjectNode objectNode = JsonUtils.mapper.createObjectNode();
      objectNode.put("name", name);
      objectNode.put("url", url);
      arrayNode.add(objectNode);
    }
    paramMap.put("jsonArray", arrayNode.toString());
    ArrayNode newAttas = ossQiniuClient.persistent(paramMap);
    for (int i=0;i<arrayNode.size();i++){
      boolean transfer = true;
      for (int j=0;j<newAttas.size();j++) {
        if (arrayNode.get(i).get("name").equals(newAttas.get(j).get("name"))) {
          resultNode.add(newAttas.get(j));
          transfer = false;
        }
      }
      if(transfer){
        ObjectNode objectNode = JsonUtils.mapper.createObjectNode();
        objectNode.put("name", arrayNode.get(i).get("name").toString().replace("\"", ""));
        objectNode.put("url", arrayNode.get(i).get("url").toString().replace("\"", "").split("file=")[1]);
        resultNode.add(objectNode);
      }
    }
    return resultNode;
  }

  /**
   * 持久化ueditor里面的图片
   *
   * @param userId
   * @param content
   *
   * @return
   */
  public String dealUeditorImg(String userId, String content) {
    Map<String, String> paramMap = new HashMap<>(2);
    paramMap.put("userId", userId);
    Document doc = Jsoup.parseBodyFragment(content);
    Elements images = doc.select("img");
    List<String> oldImg = new ArrayList<>();
    List<String> ignoreImg = new ArrayList<>();
    ArrayNode arrayNode = JsonUtils.mapper.createArrayNode();
    for (Element image : images) {
      ObjectNode objectNode = JsonUtils.mapper.createObjectNode();
      objectNode.put("name", image.attr("alt"));
      objectNode.put("url", image.attr("src"));
      // 非临时文件不持久化
      if (image.attr("src").indexOf("temp") > -1) {
        oldImg.add(image.attr("src"));
        arrayNode.add(objectNode);
      } else {
        ignoreImg.add(image.attr("src"));
      }
    }
    ArrayNode newImg = JsonUtils.mapper.createArrayNode();
    if (arrayNode.size() > 0) {
      paramMap.put("jsonArray", arrayNode.toString());
      newImg = ossQiniuClient.persistent(paramMap);
    }
    for (int i = 0; i < oldImg.size(); i++) {
      content = content.replace(oldImg.get(i), newImg.get(i).get("url").asText());
    }
    for (int i = 0; i < ignoreImg.size(); i++) {
      String tmp = ignoreImg.get(i);
      tmp = tmp.substring(tmp.indexOf("=") + 1);
      try {
        tmp = URLDecoder.decode(tmp,"UTF-8");
      } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      content = content.replace(ignoreImg.get(i), tmp);
    }
    return content;
  }

  /**
   * 获取持久化对象时所需的arraynode
   *
   * @param arr 后台附件传入的对象
   *
   * @return
   */
  public ArrayNode getPersistentArrayNode(ArrayNode arr) {
    ArrayNode result = JsonUtils.mapper.createArrayNode();
    for (JsonNode jsonNode : arr) {
      ObjectNode node = JsonUtils.mapper.createObjectNode()
                                        .put("url", URLUtil.getUri(jsonNode.get("attaUrl").textValue()))
                                        .put("name", jsonNode.get("attaName").textValue());
      result.add(node);
    }
    return result;
  }

  /**
   * 展示从数据库查询出来的ueditor图片
   *
   * @param content
   *
   * @return
   */
  public String displayUeditorImg(String content) {
    Document doc = Jsoup.parseBodyFragment(content);
    Elements images = doc.select("img");
    for (Element image : images) {
      String url = image.attr("src");
      try {
        url = URLEncoder.encode(url, "UTF-8");
      } catch (UnsupportedEncodingException e) {
        throw new BusinessException("url编码错误");
      }
      image.attr("src", OssConstant.REDIRECT_URL + "?file=" + url);
    }
    content = doc.selectFirst("body").html();
    return content;
  }


  /**
   * 展示数据库查询出来的附件
   *
   * @param url
   *
   * @return
   */
  public String displayAtta(String url) {
    if (url == null) {
      return null;
    }
    try {
      url = URLEncoder.encode(url, "UTF-8");
    } catch (UnsupportedEncodingException e) {
      throw new BusinessException("url编码错误");
    }
    url = OssConstant.REDIRECT_URL + "?file=" + url;
    return url;
  }



  public String redirectInternals(Map<String, String> params) {
    String file = params.get("file");
    if(StringUtils.isNotBlank(file) && file.startsWith("/pub")){
      return ossQiniuClient.redirectInternals(params);
    }
    if(AuthUtilHelper.getAuth().checkRoleCode(AuthCode.PRIVATE_ATTACHMENT_AUTH.toString())){
      return ossQiniuClient.redirectInternals(params);
    }
    return "";
  }
}
