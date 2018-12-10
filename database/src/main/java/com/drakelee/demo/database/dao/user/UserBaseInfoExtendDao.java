package com.drakelee.demo.database.dao.user;

import com.base.components.common.dto.page.DataPage;

import java.util.Map;

/**
 * UserBaseInfoExtendDao
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/21 0021 15:37
 */
public interface UserBaseInfoExtendDao {

  DataPage<Map> listPage(Map<String, String> params);

}
