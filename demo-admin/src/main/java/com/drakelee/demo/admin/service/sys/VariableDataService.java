package com.drakelee.demo.admin.service.sys;

import com.fasterxml.jackson.databind.node.ArrayNode;
import com.drakelee.demo.admin.service.attachment.AttachmentService;
import com.drakelee.demo.admin.service.attachment.AttachmentService;
import com.drakelee.demo.common.domain.sys.VariableData;
import com.base.components.common.token.TokenThreadLocal;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.Logs;
import com.drakelee.demo.database.dao.sys.VariableDataDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.Map;

/**
 * VariableData Service
 * @author : code generator
 * @version : 1.0
 * @since : 2018-05-21
 */
@Service
public class VariableDataService extends AbstractJpaService<VariableData, String, VariableDataDao> {
  @Autowired
  private AttachmentService attachmentService;

  @Transactional(rollbackFor = Exception.class)
  public void addData(Map<String, String> params) {
    ArrayNode attas = JsonUtils.mapper.createArrayNode();
    try {
      attas = JsonUtils.reader(ConvertUtil.checkNotNull(params, "attas", String.class), ArrayNode.class);
    } catch (IOException e) {
      Logs.get().error("", e);
    }
	  VariableData data = new VariableData();
    try {
      BeanUtils.populate(data, params);
    } catch (Exception e) {
      e.printStackTrace();
    }
    // 如果持久化过 则不再持久化
    if(attas.size() > 0){
      // 附件持久化
      ArrayNode persistent = attachmentService
        .persistent(attas, false, TokenThreadLocal.getTokenObjNonNull().objId().toString());
      if(persistent != null){
        data.setAvatar(persistent.get(0).get("url").textValue());
      }
    }
    getDao().save(data);
  }

  @Transactional(rollbackFor = Exception.class)
  public void delete(String id) {
    getDao().deleteById(id);
  }
}