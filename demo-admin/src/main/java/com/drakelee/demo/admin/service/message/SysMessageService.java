

package com.drakelee.demo.admin.service.message;

import com.drakelee.demo.common.constants.KnowStatus;
import com.drakelee.demo.common.domain.sys.SysMessage;
import com.base.components.common.dto.page.DataPage;
import com.drakelee.demo.database.dao.sys.SysMessageDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 系统消息service
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/20 0020 15:23
 */
@Service
public class SysMessageService extends AbstractJpaService<SysMessage, String, SysMessageDao> {

  public long countUnReadMessage() {
    return getDao().countByUnread(KnowStatus.UNREAD.getStatus());
  }

  public DataPage<Map<String,Object>> findDetailPage(Map<String,String> searchParam){
    return getDao().findDetailPage(searchParam);
  }
}
