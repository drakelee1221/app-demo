package com.drakelee.demo.pm.controller.user;

import com.drakelee.demo.pm.service.user.UserCompanyInfoService;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.constants.user.company.CompanyIndustry;
import com.drakelee.demo.common.constants.user.company.CompanyNature;
import com.drakelee.demo.common.constants.user.company.CompanyScale;
import com.base.components.common.token.RequireToken;
import com.base.components.common.token.TokenThreadLocal;
import com.drakelee.demo.common.token.user.UserExpertToken;
import com.drakelee.demo.common.token.user.UserManagerToken;
import com.drakelee.demo.common.token.user.UserServiceToken;
import com.drakelee.demo.common.token.user.UserToken;
import com.drakelee.demo.pm.service.user.UserCompanyInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * UserCompanyInfoController
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/16 0016 17:31
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
public class UserCompanyInfoController {

  @Autowired
  UserCompanyInfoService userCompanyInfoService;


  /**
   * 完善企业信息
   *
   * @param params -
   * <p>   name                     - Nullable  - Str - 企业名称
   * <p>   nature                   - Nullable  - Str - 企业性质
   * <p>   industry                 - Nullable  - Str - 行业
   * <p>   scale                    - Nullable  - Str - 规模
   * <p>   region                   - Nullable  - Str - 地址区域
   * <p>   regionName               - Nullable  - Str - 地址区域
   * <p>   address                  - Nullable  - Str - 地址
   * <p>   phone                    - Nullable  - Str - 电话
   * <p>   logo                     - Nullable  - Str - logo
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class})
  @PutMapping(value = "/user/company/info", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity completeCompanyInfo(@RequestBody Map<String, String> params) {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    userCompanyInfoService.completeCompanyInfo(userId, params);
    return new ResponseEntity<>(HttpStatus.CREATED);
  }

  /**
   * 获取当前用户企业资料
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class})
  @GetMapping(value = "/user/company/info", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getCompanyInfo() {
    String userId = TokenThreadLocal.getTokenObjNonNull().objId().toString();
    return new ResponseEntity<>(userCompanyInfoService.findByUserId(userId), HttpStatus.CREATED);
  }

  /**
   * 获取企业资料初始化item
   *
   * @return
   */
  @RequireToken({UserToken.class, UserManagerToken.class, UserExpertToken.class, UserServiceToken.class})
  @GetMapping(value = "/user/company/info/item", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity callMeItem() {
    Map<String, Object> result = new HashMap<>(3);
    List<Map> industrys = new ArrayList<>();
    List<Map> natures = new ArrayList<>();
    List<Map> scales = new ArrayList<>();
    for (CompanyIndustry item : CompanyIndustry.values()) {
      Map<String, String> tmp = new HashMap<>(1);
      tmp.put(item.getCode() + "", item.getDesc());
      industrys.add(tmp);
    }
    for (CompanyNature item : CompanyNature.values()) {
      Map<String, String> tmp = new HashMap<>(1);
      tmp.put(item.getCode() + "", item.getDesc());
      natures.add(tmp);
    }
    for (CompanyScale item : CompanyScale.values()) {
      Map<String, String> tmp = new HashMap<>(1);
      tmp.put(item.getCode() + "", item.getDesc());
      scales.add(tmp);
    }
    result.put("industrys", industrys);
    result.put("natures", natures);
    result.put("scales", scales);
    return new ResponseEntity<>(result, HttpStatus.CREATED);
  }

  /**
   * 行业类别开放接口
   *
   * @return
   */
  @GetMapping(value = "/industry/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getIndustry() {
    List<Map> industrys = new ArrayList<>();
    for (CompanyIndustry item : CompanyIndustry.values()) {
      Map<String, String> tmp = new HashMap<>(1);
      tmp.put(item.getCode() + "", item.getDesc());
      industrys.add(tmp);
    }
    return new ResponseEntity<>(industrys, HttpStatus.CREATED);
  }


}
