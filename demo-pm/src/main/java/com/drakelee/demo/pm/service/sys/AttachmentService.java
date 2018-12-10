package com.drakelee.demo.pm.service.sys;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.google.common.collect.Lists;
import com.drakelee.demo.common.domain.sys.Attachment;
import com.drakelee.demo.common.domain.sys.AttachmentRef;
import com.drakelee.demo.database.dao.sys.AttachmentDao;
import com.drakelee.demo.database.dao.sys.AttachmentRefDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * AttachmentService 附件
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/20 0020 10:23
 */
@Service
public class AttachmentService extends AbstractJpaService<Attachment, String, AttachmentDao> {

  @Autowired
  private AttachmentRefDao attachmentRefDao;

  /**
   * 添加附件列表
   *
   * @param arr
   * @param fileType 见 {@link com.drakelee.demo.common.constants.sys.FileType}
   * @param remark 备注
   * @param refId 关联id（订单操作过程中的附件都是关联订单id）
   * @param nameclass 关联类名
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public List<Attachment> addAttachments(ArrayNode arr, int fileType, String remark, String refId, String nameclass) {
    List attachments = Lists.newArrayList();
    for (JsonNode jsonNode : arr) {
      Attachment attachment = new Attachment();
      attachment.setUrl(jsonNode.get("url").textValue());
      attachment.setFileType(fileType);
      attachment.setRemark(remark);
      attachment.setName(jsonNode.get("name").textValue());
      attachment.setRefId(refId);
      attachments.add(attachment);
    }
    List list = getDao().saveAll(attachments);

    List refList = Lists.newArrayList();
    // 添加附件关联关系
    for (Object o : list) {
      Attachment attachment = (Attachment) o;

      AttachmentRef attachmentRef = new AttachmentRef();
      attachmentRef.setRefId(refId);
      attachmentRef.setAttachmentId(attachment.getId());
      attachmentRef.setRefType(nameclass);
      refList.add(attachmentRef);
    }
    attachmentRefDao.saveAll(refList);
    return list;
  }
}
