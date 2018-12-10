

package com.drakelee.demo.database.dao.sys;

import com.base.components.common.dto.page.DataPage;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Email DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface EmailExtendDao  {

  DataPage queryEmails(Map<String,String> params);
}

