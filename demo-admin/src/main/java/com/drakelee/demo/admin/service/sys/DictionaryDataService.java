package com.drakelee.demo.admin.service.sys;

import com.drakelee.demo.common.constants.sys.DictionaryDataType;
import com.drakelee.demo.common.domain.sys.Dictionary;
import com.drakelee.demo.common.domain.sys.DictionaryData;
import com.base.components.common.util.ConvertUtil;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.sys.DictionaryDao;
import com.drakelee.demo.database.dao.sys.DictionaryDataDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * DictionaryData Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-09
 */
@Service
public class DictionaryDataService extends AbstractJpaService<DictionaryData, String, DictionaryDataDao> {
  @Autowired
  private DictionaryDao dictionaryDao;
  @Autowired
  private DictionaryService dictionaryService;

  /**
   * DictionaryData新增和修改
   *
   * @param params
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public DictionaryData saveOrUpdate(Map<String, String> params) {
    DictionaryData dictionaryData = ConvertUtil.populate(new DictionaryData(), params);
    dictionaryData.setDataKey(dictionaryData.getDataKey() != null ? dictionaryData.getDataKey().trim() : "");
    dictionaryData.setDataName(dictionaryData.getDataName() != null ? dictionaryData.getDataName().trim() : "");
    dictionaryData.setDataValue(dictionaryData.getDataValue() != null ? dictionaryData.getDataValue().trim() : "");
    if (StringUtils.isEmpty(dictionaryData.getId())) {
      int countSame = getDao().countSameInsert(dictionaryData.getDictId(), dictionaryData.getDataKey());
      Assert.isTrue(countSame == 0, "已存在同key的记录");
      Optional<Dictionary> op = dictionaryDao.findById(dictionaryData.getDictId());
      Assert.isTrue(op.isPresent(), "未查到字典信息");
      if (DictionaryDataType.SINGLE.toString().equals(op.get().getDataType())) {
        long c = getDao().count(
          ConditionGroup.build().addCondition("dictId", ConditionEnum.OPERATE_EQUAL, dictionaryData.getDictId()));
        Assert.isTrue(c <= 0, DictionaryDataType.SINGLE.toString() + "类型只能添加一个数据！");
      }
      if (dictionaryData.getOrderNo() == null) {
        Integer no = getDao().maxOrderNo(dictionaryData.getDictId());
        if (no == null) {
          no = 1;
        } else {
          no = no + 1;
        }
        dictionaryData.setOrderNo(no);
      }
    } else {
      int countSame = getDao()
        .countSameUpdate(dictionaryData.getId(), dictionaryData.getDictId(), dictionaryData.getDataKey());
      Assert.isTrue(countSame == 0, "已存在同key的记录");
    }
    getDao().save(dictionaryData);
    dictionaryService.refreshDictionaryCache();
    return dictionaryData;
  }

  /**
   * DictionaryData删除
   *
   * @param ids
   */
  @Transactional(rollbackFor = Exception.class)
  public void delete(Iterable<String> ids) {
    List<DictionaryData> list = getDao().findAllById(ids);
    if (!CollectionUtils.isEmpty(list)) {
      getDao().deleteInBatch(list);
    }
    dictionaryService.refreshDictionaryCache();
  }

  /**
   * 根据字典编码查询字典数据
   *
   * @param dictCode
   *
   * @return
   */
  public List<Map> dictionaryData(String dictCode) {
    return getDao().dictionaryData(dictCode);
  }


}