package com.drakelee.demo.pm.service.sys;

import com.drakelee.demo.common.domain.sys.VariableData;
import com.drakelee.demo.database.dao.sys.VariableDataDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * VariableData Service
 * @author : code generator
 * @version : 1.0
 * @since : 2018-05-21
 */
@Service
public class VariableDataService extends AbstractJpaService<VariableData, String, VariableDataDao> {

  @Transactional(rollbackFor = Exception.class)
  public void addData(Map<String, String> params) {
	  VariableData data = new VariableData();
    try {
      BeanUtils.populate(data, params);
    } catch (Exception e) {
      e.printStackTrace();
    }
    getDao().save(data);
  }

  @Transactional(rollbackFor = Exception.class)
  public void delete(String id) {
    getDao().deleteById(id);
  }
}