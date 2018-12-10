package com.drakelee.demo.admin.service.member;

import com.drakelee.demo.cache.serialnumber.AbstractCacheToDatabaseSerialNumberService;
import com.drakelee.demo.database.service.serialnumber.AdminRegisterSerialNumberStrategy;
import org.springframework.stereotype.Service;

/**
 * InvitationCodeService
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-06-13 18:37
 */
@Service
public class InvitationCodeService extends AbstractCacheToDatabaseSerialNumberService<String,AdminRegisterSerialNumberStrategy> {
}
