

package com.drakelee.demo.database.dao.demo;

import com.drakelee.demo.common.domain.demo.Demo;
import com.base.components.database.dao.base.GenericJpaDao;
import com.base.components.database.dao.base.annotation.ReturnMapKeys;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * test
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-10 9:57
 */
@Repository
public interface DemoDao extends GenericJpaDao<Demo, String>, DemoExtendDao {


  /**
   * {@code  List<Map> } 示例
   *
   * @param name
   *
   * @return {@code List<Map> }
   */
  @Query(value = "SELECT * FROM t_demo WHERE t_name = :name", nativeQuery = true)
  @ReturnMapKeys({"id", "name", "age", "createTime"})
  <R> List<R> exampleList(@Param("name") String name);

  /**
   * {@code  Page<Map> } 示例
   *
   * @param name
   * @param pageable
   *
   * @return {@code List<Map> }
   */
  @Query(value = "SELECT * FROM t_demo WHERE t_name = :name ",
    countQuery = "SELECT count(1) FROM t_demo WHERE t_name = :name", nativeQuery = true)
  @ReturnMapKeys({"id", "name", "age", "createTime"})
  <R> Page<R> examplePage(@Param("name") String name, Pageable pageable);

  /**
   * {@code  Page<Map> } 修改
   *
   * @param id
   * @param name
   *
   * @return {@code List<Map> }
   */
  @Query(value = "UPDATE t_demo SET t_name = :name WHERE t_id = :id", nativeQuery = true)
  @Modifying
  int updateName(@Param("id") String id, @Param("name") String name);


  @Query(value = "UPDATE t_demo SET t_age = t_age + :age WHERE t_id = :id", nativeQuery = true)
  @Modifying
  int incrementAge(@Param("id") String id, @Param("age") Integer age);

  /**
   * 多表查询
   *
   * @param pageable -
   *
   * @return page
   */
  @Query(value = "SELECT st.description ,stl.* FROM sys_task st LEFT JOIN sys_task_log stl ON st.id = stl.task_id",
    countQuery = "SELECT count(1) FROM sys_task st LEFT JOIN sys_task_log stl ON st.id = stl.task_id", nativeQuery = true)
  @ReturnMapKeys({"description", "id", "taskId", "taskName", "executeOverTime", "taskFireTime", "executeSuccess",
    "executeExceptions", "executeServerHost", "resultMessage"})
  <R> Page<R> demoTest(Pageable pageable);
}
