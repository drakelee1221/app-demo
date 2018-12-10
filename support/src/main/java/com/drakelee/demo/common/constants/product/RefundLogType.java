package com.drakelee.demo.common.constants.product;

/**
 * RefundLogType
 *
 * @author <a href="929592332@qq.com">wangXin</a>
 * @version v1.0.0
 * @date 2018-11-14 15:08
 */
public enum RefundLogType {
  coupons("优惠卷",0),
  product_service("服务产品",1),
  contract_record("签约记录",3),
  product_order("产品订单",2);
  private String desc;
  private Integer val;

  RefundLogType(String desc, int val) {
    this.desc = desc;
    this.val = val;
  }

  public String getDesc() {
    return desc;
  }

  public Integer getVal() {
    return val;
  }
}
