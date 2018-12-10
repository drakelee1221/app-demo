

package com.drakelee.demo.database.dao.sys;

import com.base.components.common.dto.page.DataPage;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Sms DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface SmsExtendDao {

  DataPage querySysSms(Map<String,String> params);

  DataPage<Map<String,Object>> querySmsUser(Map<String, String> params,Integer max);
}

