

package com.drakelee.demo.database.dao.demo.impl;

import com.drakelee.demo.database.dao.demo.DemoExtendDao;
import com.drakelee.demo.common.domain.demo.Demo;
import com.base.components.database.dao.base.AbstractExtendDao;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * DemoDaoImpl
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-28 11:04
 */
public class DemoDaoImpl extends AbstractExtendDao<Demo> implements DemoExtendDao {

  @Override
  public List<Map<String, Object>> findExtend(Map<String, Object> params) {
    System.err.println("@@@@@@@@@@@@" + entityManager);
    return Collections.emptyList();
  }
}
