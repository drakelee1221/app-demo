package com.drakelee.demo.common.constants.sys;

/**
 * 上传的文件类型
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/28 0028 15:55
 */
public enum FileType {

  /**
   * 其他
   */
  OTHER(0),

  /**
   * 营业执照正本
   */
  BUSINESS_LICENSE_MAIN(1),

  /**
   * 营业执照副本
   */
  BUSINESS_LICENSE_MAIN_MINOR(2),

  /**
   * 开户许可证
   */
  OPNE_ACCOUNT_LICENSE(3),

  /**
   * 公司章程
   */
  COMPANY_REGULATIONS(4),

  /**
   * 法人身份证
   */
  LEGAL_IDCARD(5),

  /**
   * 股东身份证
   */
  STOCKHOLDER_IDCARD(6),

  /**
   * 房屋租赁合同
   */
  LEASE_CONTRACT(7),

  /**
   * 房屋租赁发票
   */
  LEASE_INVOICE(8),

  /**
   * 代账服务发票
   */
  SERVICE_INVOICE(9),

  /**
   * 公章
   */
  CACHET(10),

  /**
   * 财务专用章
   */
  FINANCE_CACHET(11),

  /**
   * 法人章
   */
  LEGAL_CACHET(12),

  /**
   * 合同专用章
   */
  CONTRACT_CACHET(13),

  /**
   * 发票专用章
   */
  INVOICE_CACHET(14),

  /**
   * 收款收据
   */
  PROCEEEDS_BILL(15),

  ;

  private int val;

  FileType(int val){
    this.val = val;
  }

  public int getVal(){
    return val;
  }

}
