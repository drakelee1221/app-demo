package com.drakelee.demo.pm.controller.sys;

import com.base.components.cache.Cache;
import com.base.components.cache.CacheManager;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.sys.DictionaryData;
import com.base.components.common.util.ConvertUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * DictionaryData Controller
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-07-02
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
public class DictionaryDataController {

  @Autowired
  private CacheManager cacheManager;


  /**
   * 根据字典编码获取字典数据(多个值)
   *
   * @param params -
   * <p> dictCode               - NotNull  - Str  - 字典编码
   *
   * @return
   */
  @GetMapping(value = "/dictionary/data/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity dictionaryDataList(@RequestParam Map<String, String> params) {
    String dictCode = ConvertUtil.checkNotNull(params, "dictCode", "字典编号不能为空", String.class);
    dictCode = dictCode.trim();
    //从缓存获取
    CacheName cacheName = CacheName.DICTIONARY;
    Cache cache = cacheManager.getCache(cacheName);
    return new ResponseEntity(cache.get(dictCode, List.class), HttpStatus.OK);
  }

  /**
   * 根据字典编码获取字典数据(单个值)
   *
   * @param params -
   * <p> dictCode               - NotNull  - Str  - 字典编码
   *
   * @return
   */
  @GetMapping(value = "/dictionary/data/single", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity dictionaryDataSingle(@RequestParam Map<String, String> params) {
    String dictCode = ConvertUtil.checkNotNull(params, "dictCode", "字典编号不能为空", String.class);
    dictCode = dictCode.trim();
    //从缓存获取
    CacheName cacheName = CacheName.DICTIONARY;
    Cache cache = cacheManager.getCache(cacheName);
    String res = "";
    List<DictionaryData> list = cache.get(dictCode, List.class);
    if (list != null && list.size() != 0) {
      res = list.get(0).getDataValue();
    }
    return new ResponseEntity(res, HttpStatus.OK);
  }



}
