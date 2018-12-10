

package com.drakelee.demo.database.dao.user;

import com.base.components.database.dao.base.GenericJpaDao;
import com.base.components.database.dao.base.annotation.ReturnMapKeys;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * UserBaseInfo DAO
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Repository
public interface UserBaseInfoDao extends GenericJpaDao<UserBaseInfo, String>, UserBaseInfoExtendDao {

  /**
   * 通过手机号查询
   *
   * @param phone 手机号
   *
   * @return UserBaseInfo
   */
  UserBaseInfo findByPhone(String phone);

  /**
   * 通过openid查询
   *
   * @param openId
   *
   * @return UserBaseInfo
   */
  UserBaseInfo findByOpenId(String openId);

  /**
   * 获取用户余额
   *
   * @param userId
   *
   * @return
   */
  @Query(value = "select balance from base_user_base_info where id = :userId", nativeQuery = true)
  BigDecimal findBalanceById(@Param("userId") String userId);

  /**
   * 修改余额
   *
   * @param userId
   * @param beforeBalance
   * @param afterBalance
   *
   * @return
   */
  @Query(value = "update base_user_base_info set balance = :afterBalance where id = :userId and balance = "
    + ":beforeBalance", nativeQuery = true)
  @Modifying
  @Transactional
  Integer updateUserBalance(@Param("userId") String userId, @Param("beforeBalance") BigDecimal beforeBalance,
                            @Param("afterBalance") BigDecimal afterBalance);

  @Query(value = "select phone from base_user_base_info where id = :targetId", nativeQuery = true)
  String findPhoneById(@Param("targetId") String targetId);

  @Query(value = "update base_user_base_info set user_type = :userType where user_type_id = :id ", nativeQuery = true)
  @Modifying
  void updateUserType(@Param("id") String id, @Param("userType") Integer userType);

  @Query(value = "update base_user_base_info set user_type = :userType, user_type_id = :unknownId where user_type_id = "
    + ":id ", nativeQuery = true)
  @Modifying
  void updateUnknown(@Param("id") String id, @Param("unknownId") String unknownId, @Param("userType") Integer userType);

  @Query(value = "select count(1) as nums, date_format(regist_time, '%Y-%m-%d') as registTime from base_user_base_info "
    + " where regist_time is not null and regist_time >= :startdate and regist_time <= :enddate GROUP BY date_format"
    + "(regist_time, '%Y-%m-%d')  order by date_format(regist_time, '%Y-%m-%d') asc", nativeQuery = true)
  @ReturnMapKeys({"nums", "registTime"})
  List<Map<String, Object>> queryRegister(@Param("startdate") Date startdate, @Param("enddate") Date enddate);

  @Query(value = "select count(1) from base_user_base_info where user_type = :userType", nativeQuery = true)
  long countUser(@Param("userType") Integer userType);

  @Query(value = "select  (case  when last_login_time < :thirtyDay then 'thirty' "
    + "when last_login_time < :fifteenDay then 'fifteen'  when last_login_time < :sevenDay then 'seven' else 'other'"
    + "end) days  ,count(*) count from base_user_base_info where  user_type = :userType and last_login_time >= :maxDay group by days", nativeQuery = true)
  List<Map> countUnLogin(@Param("thirtyDay") Date thirtyDay, @Param("fifteenDay") Date fifteenDay,
                         @Param("sevenDay") Date sevenDay, @Param("maxDay") Date maxDay,
                         @Param("userType") Integer userType);

  @Query(value = "select  (case  when last_login_time < :thirtyDay then 'thirty' "
    + "when last_login_time < :fifteenDay then 'fifteen'  when last_login_time < :sevenDay then 'seven' else 'other'"
    + "end) days  ,count(*) count from base_user_base_info where user_type != :userType and last_login_time >= :maxDay group by days", nativeQuery = true)
  List<Map> countUnLoginNotequal(@Param("thirtyDay") Date thirtyDay, @Param("fifteenDay") Date fifteenDay,
                                 @Param("sevenDay") Date sevenDay, @Param("maxDay") Date maxDay,
                                 @Param("userType") Integer userType);

  @Query(value = "select count(1) from base_user_base_info where user_type != :userType and last_login_time <= :minus "
    + "and last_login_time >= :other", nativeQuery = true)
  long countUnLoginNotequal(@Param("minus") Date minus, @Param("other") Date other,
                            @Param("userType") Integer userType);

  /**
   * 计算用户总余额
   *
   * @return
   */
  @Query(value = "select sum(balance) from base_user_base_info ", nativeQuery = true)
  BigDecimal countUserBalance();


  @Query(value = "select a.id, a.avatar,a.user_nick_name as userNickName,a.gender,a.user_email as userEmail,a.phone, "
    + "b.phone as companyPhone,b.name as companyName," + "c.user_type as userType,c.user_type_name as userTypeName "
    + "from base_user_base_info a left join base_user_company_info b on a.id=b.user_id "
    + "left join base_user_base_type c on a.user_type_id=c.id " + "where a.id= :userId", nativeQuery = true)
  Map userInfoSimple(@Param("userId") String userId);

  @Query(value = " update base_user_base_info set wx_name=null,wx_img=null,open_id=null where open_id=:openId and phone!=:phone ", nativeQuery = true)
  @Modifying
  void clearOtherBind(@Param("openId") String openId, @Param("phone") String phone);

  @Query(value = " update base_user_base_info set mini_open_id=null where mini_open_id=:miniOpenId and phone!=:phone ", nativeQuery = true)
  @Modifying
  void clearOtherMiniBind(@Param("miniOpenId") String miniOpenId, @Param("phone") String phone);

  UserBaseInfo findByPhoneAndUserNickNameAndUserType(String phone, String userNickName,Integer userType);

  @Query(value = "select 1 from base_user_base_info where id=:userId FOR UPDATE ",nativeQuery = true)
  void lockUserBaseInfo(@Param("userId") String userId);

  Optional<UserBaseInfo> findByMiniOpenId(String miniOpenId);

  UserBaseInfo findByPhoneOrPhone2(String phone, String phone2);
}

