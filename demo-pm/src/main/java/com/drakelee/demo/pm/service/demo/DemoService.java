

package com.drakelee.demo.pm.service.demo;

import com.base.components.cache.Cache;
import com.base.components.cache.CacheLock;
import com.base.components.cache.CacheManager;
import com.base.components.common.constants.sys.Pages;
import com.base.components.common.dto.page.DataPage;
import com.base.components.common.service.message.ChannelMessageSender;
import com.base.components.common.token.TokenCacheObj;
import com.base.components.common.token.TokenManager;
import com.base.components.common.tools.Printer;
import com.base.components.common.util.JsonUtils;
import com.base.components.common.util.PasswordUtil;
import com.base.components.database.service.AbstractJpaService;
import com.base.components.transaction.TransactionEvent;
import com.base.components.transaction.TransactionManager;
import com.codingapi.tx.annotation.TxTransaction;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.util.concurrent.Uninterruptibles;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.msgqueue.channels.MessageChannel;
import com.drakelee.demo.common.domain.demo.Demo;
import com.drakelee.demo.common.token.user.UserToken;
import com.drakelee.demo.database.dao.demo.DemoDao;
import com.drakelee.demo.feign.client.pm.DemoClient;
import org.apache.commons.collections4.map.SingletonMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.persistence.Query;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;



/**
 * Test Service
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-10 10:18
 */
@Service
public class DemoService extends AbstractJpaService<Demo, String, DemoDao> {
//  @Autowired
//  private ExternalDemoClient externalDemoClient;
  @Autowired
  private CacheManager cacheManager;
  @Autowired
  private RedisTemplate redisTemplate;
//  @Autowired
//  private RedisConnector redisConnector;
  @Autowired
  private CacheLock cacheLock;
  @Autowired
  private TokenManager tokenManager;

  @Autowired
  private ChannelMessageSender channelMessageSender;
  @Autowired
  private DemoDao demoDao;
//  @Autowired
//  private PlatformTransactionManager transactionManager;
//  @Autowired
//  private SendMessageService sendMessageService;
//  @Autowired
//  private DemoEsRepository demoRepository;

  @Autowired
  private DemoClient demoClient;


  @TxTransaction(isStart = true)
  @Transactional(rollbackFor = Exception.class)
  public Demo save(Demo test) {
//    System.err.println("test = " + ToStringBuilder.reflectionToString(test));
//    return demoDao.saveAndFlush(test);
//    List<Object>
//      resultList = getEntityManager().createNativeQuery("select id from he_product_order_temp")
//                                     .getResultList();
//    Printer.err("resultList = " + resultList.size());
//    int i = 10001;
//    for (Object objects : resultList) {
//      getEntityManager().createNativeQuery(
//        "update he_product_order_temp set order_code = 'O20181206111545"
//          + i+"' where id = '"+objects+"'").executeUpdate();
//      i++;
//    }
//    Assert.isTrue(false, "g222344");
    Printer.err("@@@@@@@@@@@@@@@@@");
    return null;
  }
  //
//  @Transactional(rollbackFor = Exception.class)
//  public void delete(String id) {
//    demoDao.deleteById(id);
//  }

//  public int rebuildIndexWithAll() {
//    return demoRepository.rebuildIndexWithAll(getEntityManager());
//  }
//
//  public int rebuildIndexWithIncrement() {
//    return demoRepository.rebuildIndexWithIncrement(getEntityManager());
//  }
//
//  public int rebuildIndexWithNotPersistent() {
//    return demoRepository.rebuildIndexWithNotPersistent(getEntityManager());
//  }
//
//  public DataPage<Demo> esSearch(Map<String, String> params) {
//    Page<Demo> page = demoRepository
//      .fullTextSearch(params.get("q"), " ", Pages.Helper.pageable(params, new Sort(Sort.Direction.ASC, "age")));
////    return DataPage.from(demoRepository.criteriaSearch(new Criteria(), Pages.Helper
////      .pageable(params, new Sort(Sort.Direction.ASC, "age"))));
//    return DataPage.from(page);
//  }

  @Transactional
  public int incrementUpdate(String id, int age) {
    return demoDao.incrementAge(id, age);
  }

  @Transactional(rollbackFor = Exception.class)
  public void demoPublish() {
    Date now = new Date();
    Demo demo = new Demo();
    demo.setAddress("address");
    demo.setAge(1);
    demo.setUpdateTime(now);
    demo.setCreateTime(now);
    demo.setName("name");
    demo = demoDao.saveAndFlush(demo);
    System.err.println("111111111111111");
    channelMessageSender.sendMessage(MessageChannel.TEST_CHANNEL, JsonUtils.mapper.createObjectNode().put("id", demo.getId()), "remark");
    Uninterruptibles.sleepUninterruptibly(3, TimeUnit.SECONDS);
    System.err.println("222222222222222");
  }

  @TxTransaction(isStart = true)
  @Transactional(rollbackFor = Exception.class)
  public void txTest(){
    Page<Map<String, Object>> objects = demoDao.demoTest(Pages.Helper.pageable(1, 10, null));
    System.err.println("objects = " + objects.getSize());
    Demo d1 = new Demo();
    d1.setName("tx1111");
    d1.setAge(Integer.valueOf(System.getProperty("server.port")));
    demoDao.saveAndFlush(d1);
    demoClient.save(new SingletonMap<>("name", "tx2222"));
//    pmDemoClient.save(new SingletonMap<>("name", "tx3333"));

    redisTemplate.opsForValue().set("aaaa",11111);
    System.err.println("=============");
    TransactionManager.addTransactionEvent(new TransactionEvent() {
      @Override
      public void afterCommit() {
        System.err.println(" afterCommit ");
      }

      @Override
      public void afterRollback() {
        System.err.println(" afterRollback ");
      }

      @Override
      public void afterCompletion(int status) {
        System.err.println(" afterCompletion = " + status);
      }
    });
//    int a = 1/0;
    Query query = getEntityManager().createQuery("select 1 as a from Demo");
    setMapResult(query);
    System.err.println(query.getResultList());
    Assert.isTrue(false, "");
  }




  @TxTransaction
  @Transactional(rollbackFor = Exception.class)
  public void redisTest(){
    Cache cache = cacheManager.getCache(CacheName.PRE_SMS_CODE_LG);
    cacheLock.lock("ggg", new Runnable() {
      @Override
      public void run() {
        Integer aaaaaaaa = cache.get("ggg", Integer.class);
        System.err.println("!!!! " + aaaaaaaa);
        if(aaaaaaaa == null){
          aaaaaaaa = 0;
        }
        aaaaaaaa += 1;
        cache.put("ggg", aaaaaaaa);
      }
    });
    cacheLock.lock("ggg", new Runnable() {
      @Override
      public void run() {
        Integer aaaaaaaa = cache.get("ggg", Integer.class);
        System.err.println("=== " + aaaaaaaa);
        if(aaaaaaaa == null){
          aaaaaaaa = 0;
        }
        aaaaaaaa += 1;
        cache.put("ggg", aaaaaaaa);
      }
    });
//    cache.listsOfAppend("list", true, 1);
//    cache.listsOfAppend("list2", true, 1);
//    //    int a = 1/0;
//    UserToken userToken = new UserToken();
//    userToken.setUserId("aaaaa");
//    userToken.setToken("token");
//    userToken.setName("user1");
//    tokenManager.cacheToken(userToken);
//    //    int a = 1/0;
//    Demo d1 = new Demo();
//    d1.setName("tx1111");
//    d1.setAge(Integer.valueOf(System.getProperty("server.port")));
//    Demo d11 = demoDao.save(d1);
//    cache.put("bbbbbbbb", 22222222);
    //    redisTemplate.opsForValue().set("ccccccc", 3333333);
    //    redisTemplate.opsForValue().set("ddddddd", 4444444);
//    System.out.println(tokenManager.getByToken("token"));
    //    try {
//      System.err.println(JsonUtils.toString(userToken));
//    } catch (IOException e) {
//      e.printStackTrace();
//    }
//    TransactionManager.addTransactionEvent(new TransactionEvent() {
//      @Override
//      public void afterCommit() {
//        System.err.println(" afterCommit ");
//        System.err.println(Thread.currentThread());
//      }
//
//      @Override
//      public void afterRollback() {
//        System.err.println(" afterRollback ");
//      }
//
//      @Override
//      public void afterCompletion(int status) {
//        System.err.println(" afterCompletion = " + status);
//      }
//    });
//    DynamicHeaderRegistry.addNextFeignClientHeaders(new SingletonMap<>("aaa", "fffff"));
//    externalDemoClient.save(new SingletonMap<>("name", "tx2222"));
//    pmDemoClient.save2(new SingletonMap<>("name", "tx3333"));
    //    channelMessageSender.sendMessage(
    //      MessageChannel.TEST_CHANNEL,
    //      JsonUtils.createObjectNode().put("aaa", "111"));
//    System.err.println(" code over ");
//    throw new RuntimeException("aaa");
//    int a = 1/0;
  }



  public ObjectNode exLogin(Map<String, String> params){
//    ObjectNode login = externalDotnetCommonClient.login(
//      ConvertUtil.checkNotNull(params, "MemberPhone", String.class),
//      ConvertUtil.checkNotNull(params, "MemberPassword", String.class)
//    );
    return null;
  }

  @Transactional(rollbackFor = Exception.class)
  public DataPage tpsTest(Map<String, String> params){
    demoDao.incrementAge("06e27b34-824c-4ee0-abde-e7e5a2bac39c", 1);
    demoDao.updateName("517299df-d033-42cd-b449-ff3401beaf63", "名字");
    TokenCacheObj token = tokenManager.getByToken("01eee3fad1604a84a0d6a146902511d5");
    UserToken userToken = (UserToken)token;
    userToken.setLoginTime(new Date());
    tokenManager.cacheToken(userToken);
    Page<Demo> page = findAll(
      Pages.Helper.pageable(params, new Sort(Sort.Direction.DESC, "createTime"))
    );
    return DataPage.from(page);
  }

  @Transactional(rollbackFor = Exception.class)
  public DataPage qpsTest1(Map<String, String> params){
//    Page<Demo> page = findAll(
//      Pages.Helper.pageable(params, new Sort(Sort.Direction.DESC, "createTime"))
//    );
//    return DataPage.from(page);
//    Boolean a = redisConnector.execute(new RedisExecutor<Boolean>() {
//      @Override
//      public Boolean execute(RedisConnection redisConnection, CacheSerializer serializer) {
//        return redisConnection.set(serializer.serialKey("bbbbb"), serializer.serialVal(111111));
//      }
//    });
//    Uninterruptibles.sleepUninterruptibly(8, TimeUnit.SECONDS);
//    Demo d = new Demo();
//    d.setName("main");
//    d.setCreateTime(new Date());
//    demoDao.saveAndFlush(d);
    Serializable aaa = channelMessageSender
      .sendSyncMessage(MessageChannel.TEST_CHANNEL, JsonUtils.createObjectNode().put("aaa", 111));
    return DataPage.getEmpty();
  }
  public DataPage qpsTest2(Map<String, String> params){
    TokenCacheObj token = tokenManager.getByToken("01eee3fad1604a84a0d6a146902511d5");
    Page<Demo> page = findAll(
      Pages.Helper.pageable(params, new Sort(Sort.Direction.DESC, "createTime"))
    );
    return DataPage.from(page);
  }
}
