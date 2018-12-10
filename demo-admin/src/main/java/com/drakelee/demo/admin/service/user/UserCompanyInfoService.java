package com.drakelee.demo.admin.service.user;

import com.drakelee.demo.common.domain.user.UserCompanyInfo;
import com.drakelee.demo.database.dao.user.UserCompanyInfoDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.stereotype.Service;

/**
 * UserCompanyInfoService
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/16 0016 17:30
 */
@Service
public class UserCompanyInfoService extends AbstractJpaService<UserCompanyInfo, String, UserCompanyInfoDao> {

}
