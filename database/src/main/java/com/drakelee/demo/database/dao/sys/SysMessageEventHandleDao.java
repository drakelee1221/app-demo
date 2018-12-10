package com.drakelee.demo.database.dao.sys;

import com.base.components.database.dao.base.GenericJpaDao;
import com.drakelee.demo.common.domain.sys.SysMessageEventHandle;
import org.springframework.stereotype.Repository;

/**
 * SysMessageEventHandleDao的Dao接口
 *
 * @author : code tools
 * @version : 2.0
 * @date : 2018-08-08 09:29:13
 */
@Repository
public interface SysMessageEventHandleDao extends GenericJpaDao<SysMessageEventHandle, String> {
}
