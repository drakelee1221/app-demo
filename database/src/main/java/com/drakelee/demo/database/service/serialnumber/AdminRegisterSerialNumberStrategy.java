package com.drakelee.demo.database.service.serialnumber;

import com.base.components.common.service.serialnumber.DataBaseSerialNumberStrategy;
import com.drakelee.demo.common.constants.admin.InvitationType;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

/**
 * DataBaseSerialNumberServiceImpl
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version v1.0.0
 * @date 2018-06-13 17:09
 */
@Service
public class AdminRegisterSerialNumberStrategy implements DataBaseSerialNumberStrategy<String> {
//  @Autowired
//  private OrgExtendInfoDao orgExtendInfoDao;
//  @Autowired
//  private UserBaseInfoExtendDao extendDao;
  @Override
  public String selectCurrentMaxSerialNumber(String cacheKey) {
    String res;
    if(cacheKey.equals(InvitationType.ORG_SERIAL_NUMBER.toString())){
      res = "100";
      if(StringUtils.isBlank(res)){
        res = "G80000";
      }
    }else{
      res = "100";
      if(StringUtils.isBlank(res)){
        res = "80000";
      }
    }
    return res;
  }

  @Override
  public String increment(String cacheKey, String currentNumber) {
    if(cacheKey.equals(InvitationType.ORG_SERIAL_NUMBER.toString())){
      Integer g = Integer.valueOf(currentNumber.replace("G", ""));
      g = g+1;
      return "G"+g;
    }else{
      Integer u = Integer.valueOf(currentNumber);
      u = u+1;
      return ""+u;
    }
  }
}
