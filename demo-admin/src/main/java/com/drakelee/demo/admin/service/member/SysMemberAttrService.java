package com.drakelee.demo.admin.service.member;

import com.drakelee.demo.admin.dto.fancytree.TreeNodeData;
import com.drakelee.demo.admin.dto.member.TreeParam;
import com.drakelee.demo.common.constants.admin.MemberAttrType;
import com.drakelee.demo.common.domain.admin.SysMember;
import com.drakelee.demo.common.domain.admin.SysMemberAttr;
import com.drakelee.demo.database.dao.admin.SysMemberAttrDao;
import com.drakelee.demo.database.dao.admin.SysMemberDao;
import com.base.components.database.service.AbstractJpaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * SysMemberAttr Service
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-08
 */
@Service
public class SysMemberAttrService extends AbstractJpaService<SysMemberAttr, String, SysMemberAttrDao> {
  @Autowired
  private SysMemberService sysMemberService;

  public List<TreeNodeData<SysMember>> loadMemberAttrTree(TreeParam treeParam, String memberId){
    List<String> valueList = findValueList(memberId, MemberAttrType.organization.getAttrKey());
    return sysMemberService.loadAllNodes(treeParam, new MemberNodeBuilder(), SysMemberDao.PROFESSION_TREE_KIND, valueList);
  }

  public List<String> findValueList(String memberId, String attrKey){
	  return StringUtils.isBlank(attrKey)
           ? getDao().findValue(memberId)
           : getDao().findValue(memberId, attrKey);
  }

  /**
   * 给member添加组织机构属性
   * @param ids
   * @param memberId
   */
  @Transactional(rollbackFor = Exception.class)
  public void updateMemberTree(String[] ids, String memberId) {
	  getDao().deleteByMemberId(memberId);
    for (String id : ids) {
      SysMemberAttr sysMemberAttr = new SysMemberAttr();
      sysMemberAttr.setAttrKey(MemberAttrType.organization.getAttrKey());
      sysMemberAttr.setAttrName(MemberAttrType.organization.getAttrName());
      sysMemberAttr.setAttrValue(id);
      sysMemberAttr.setMemberId(memberId);
      getDao().save(sysMemberAttr);
    }
  }


  public List getMemberTree(String memberId) {
    return getDao().getMemberTree(memberId);
  }
}