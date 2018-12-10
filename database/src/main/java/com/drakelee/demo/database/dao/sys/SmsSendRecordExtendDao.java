package com.drakelee.demo.database.dao.sys;

import com.base.components.common.dto.page.DataPage;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * SmsSendRecordExtendDao
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/6/27 0027 10:36
 */
@Repository
public interface SmsSendRecordExtendDao {

  DataPage<Map> pageRecord(Map<String, String> params);

}
