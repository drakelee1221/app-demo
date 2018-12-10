package com.drakelee.demo.pm.controller.region;

import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.sys.Region;
import com.drakelee.demo.pm.service.region.RegionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * RegionController
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/30 0030 16:23
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
public class RegionController {

  @Autowired
  RegionService regionService;


  /**
   * 获取地区列表
   *
   * @param params -
   * <p>  id                    - Nullable   - Str - 地区id (不传查根节点)
   *
   * @return
   */
  @GetMapping(value = "/region/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getRegionByParentId(@RequestParam Map<String, String> params) {
    String id = params.get("id");
    List<Region> res = regionService.getRegionByParentId(id);
    return new ResponseEntity<>(res, HttpStatus.OK);
  }

  @GetMapping(value = "/region/selected/{id}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity findSelected(@PathVariable("id") String id) {
    return new ResponseEntity<>(regionService.fingSelected(id), HttpStatus.OK);
  }


  /**
   * 获取全部地区树api
   *
   * @param params -
   *
   * @return
   */
  @GetMapping(value = "/region/tree", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getRegionTree(@RequestParam Map<String, String> params) {
    return new ResponseEntity<>(regionService.getRegionTree(), HttpStatus.OK);
  }


  /**
   * 通过地区名称获取regionId
   * @param params -
   * <P> - province         - Str  - NotNull -  省
   * <P> - city             - Str  - NotNull -  市
   * <P> - district         - Str  - NotNull -  区
   *
   * @return
   */
  @GetMapping(value = "/region/id", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getRegionIdByName(@RequestParam Map<String, String> params) {
    return new ResponseEntity<>(regionService.getRegionIdByName(params), HttpStatus.OK);
  }

}
