package com.drakelee.demo.admin.service.user;

import com.drakelee.demo.common.constants.UserType;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.user.UserBaseType;
import com.base.components.common.dto.page.DataPage;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.drakelee.demo.database.dao.user.BaseUserTypeDao;
import com.drakelee.demo.database.dao.user.UserBaseInfoDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Map;

/**
 * UserBaseType Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-09
 */
@Service
public class BaseUserTypeService extends AbstractJpaService<UserBaseType, String, BaseUserTypeDao> {
  @Autowired
  private UserBaseInfoDao userBaseInfoDao;

  public DataPage page(Map<String, String> params) {
    Page page = getDao().findAll(
      ConditionGroup.build(ConditionEnum.Link.LINK_OR).addGroup(
        ConditionGroup.build().addCondition("userType", ConditionEnum.OPERATE_UNEQUAL, 0)
                      .addCondition("userType", ConditionEnum.OPERATE_UNEQUAL, 1)),
      Pages.Helper.pageable(params, Sort.by(Sort.Direction.ASC, "userType"))
    );
    return DataPage.from(page);
  }

  @Transactional(rollbackFor = Exception.class)
  public boolean addUserType(UserBaseType userType) {
    if (UserType.USER.getCode() == userType.getUserType()) {
      long count = getDao()
        .count(ConditionGroup.build().addCondition("userType", ConditionEnum.OPERATE_EQUAL, UserType.USER.getCode()));
      if (count >= 1) {
        return false;
      }
    }
    getDao().save(userType);
    return true;
  }

  @Transactional(rollbackFor = Exception.class)
  public void updateUserType(UserBaseType userBaseType) {
    UserBaseType userType = getDao().findById(userBaseType.getId())
                                           .orElseThrow(() -> new IllegalArgumentException("未找到用户类型"));
    userType.setUserTypeName(userBaseType.getUserTypeName());
    userType.setUserType(userBaseType.getUserType());
    userType.setRemark(userBaseType.getRemark());
    getDao().save(userType);
    // 更改所有关联的用户类型
    userBaseInfoDao.updateUserType(userBaseType.getId(), userBaseType.getUserType());
  }

  @Transactional(rollbackFor = Exception.class)
  public void deleteUserType(String id) {
    UserBaseType userBaseType = getDao().findById(id)
                                               .orElseThrow(() -> new IllegalArgumentException("未找到用户类型"));
    Assert.isTrue(
      userBaseType.getUserType() != UserType.UNKNOWN.getCode() && userBaseType.getUserType() != UserType.USER.getCode(),
      "该角色类型无法删除！"
    );
    getDao().deleteById(id);
    userBaseInfoDao
      .updateUnknown(id, getDao().findIdByUserType(UserType.UNKNOWN.getCode()), UserType.UNKNOWN.getCode());
  }

  public List<UserBaseType> findAllExceptBaseUser() {
    return getDao().findAllExceptBaseUserType();
  }
}