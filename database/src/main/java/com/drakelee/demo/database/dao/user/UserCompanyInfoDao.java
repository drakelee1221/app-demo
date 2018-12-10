

package com.drakelee.demo.database.dao.user;

import com.drakelee.demo.common.domain.user.UserCompanyInfo;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * UserCompanyInfo DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface UserCompanyInfoDao extends GenericJpaDao<UserCompanyInfo, String> {


  Optional<UserCompanyInfo> findByUserId(String userId);
}

