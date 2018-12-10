package com.drakelee.demo.database.dao.admin;

import com.drakelee.demo.common.domain.admin.DynamicFormData;
import com.base.components.database.dao.base.GenericJpaDao;
import org.springframework.stereotype.Repository;

/**
 * DynamicFormData DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-15
 */
@Repository
public interface DynamicFormDataDao extends GenericJpaDao<DynamicFormData, String>, DynamicFormDataExtendDao {

}

