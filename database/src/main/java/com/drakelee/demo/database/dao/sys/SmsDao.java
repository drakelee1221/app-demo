

package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.Sms;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.stereotype.Repository;

/**
 * Sms DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface SmsDao extends GenericJpaDao<Sms, String>,SmsExtendDao {


}

