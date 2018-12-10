

package com.drakelee.demo.database.dao.sys;

import com.base.components.common.dto.page.DataPage;

import java.util.Map;

/**
 * SysMessageExtendDao
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
public interface SysMessageExtendDao{
  DataPage<Map<String,Object>> findDetailPage(Map<String,String> searchParam);
}

