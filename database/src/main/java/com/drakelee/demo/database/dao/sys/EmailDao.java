

package com.drakelee.demo.database.dao.sys;

import com.drakelee.demo.common.domain.sys.Email;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.stereotype.Repository;

/**
 * Email DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface EmailDao extends GenericJpaDao<Email, String>,EmailExtendDao {


}

