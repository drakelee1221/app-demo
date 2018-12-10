package com.drakelee.demo.database.dao.admin;

import com.base.components.common.dto.page.DataPage;

import java.util.List;
import java.util.Map;

/**
 * DynamicFormDataExtendDao
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-15
 */
public interface DynamicFormDataExtendDao {

  DataPage<Map> page(String code, String title, Map<String, String> params, List<String> types);
}

