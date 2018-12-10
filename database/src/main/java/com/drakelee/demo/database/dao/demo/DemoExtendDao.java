

package com.drakelee.demo.database.dao.demo;

import java.util.List;
import java.util.Map;

/**
 * 自定义拓展dao
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-28 11:01
 */
public interface DemoExtendDao {

  /**
   * 测试自定义拓展方法
   *
   * @param params
   *
   * @return
   */
  List<Map<String, Object>> findExtend(Map<String, Object> params);
}
