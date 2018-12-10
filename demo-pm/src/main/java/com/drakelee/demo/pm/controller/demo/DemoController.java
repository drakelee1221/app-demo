

package com.drakelee.demo.pm.controller.demo;

import com.base.components.common.dto.page.DataPage;
import com.base.components.common.service.ThreadPoolService;
import com.base.components.common.tools.Printer;
import com.base.components.common.util.ConvertUtil;
import com.base.components.common.util.IPUtils;
import com.base.components.common.util.Logs;
import com.base.components.common.util.SseEmitterBuilder;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.common.domain.demo.Demo;
import com.drakelee.demo.pm.service.demo.DemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

/**
 * Test Controller
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-10 10:47
 */
@RestController
@RequestMapping(GatewayPath.API_PM)
@Profile("!prod")
public class DemoController {

  @Autowired
  private DemoService demoService;
  //  @Autowired
  //  private OssQiniuClient ossQiniuClient;
  @Autowired
  private ThreadPoolService threadPoolService;
  //  @Autowired
  //  private TokenManager tokenManager;

  //  /** get - PathVariable */
  //  @GetMapping(value = "/demo/{id}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  //  public ResponseEntity<Demo> getTestPath(@PathVariable("id") String id) {
  ////    Map<String, String> map = Maps.newHashMap();
  ////    map.put("userId", "00000000000000000");
  ////    map.put("random", String.valueOf(new Random().nextInt(100000)));
  ////    System.err.println("paramMap = " + map);
  ////    ossQiniuClient.getUploadTokenForInternal(map);
  ////    ossQiniuClient.deleteFile(map);
  //    return new ResponseEntity<>(demoService.findById(id), HttpStatus.OK);
  //  }
  //
  @GetMapping(value = "/demo/event-stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
  public SseEmitter eventSteam(@RequestParam Map<String, String> params, HttpServletResponse response)
    throws IOException {
    Logs.get().warn("aaa");
    Printer.err("-----------------" + Thread.currentThread() + " - " + params);
    //主线程
    SseEmitter sseEmitter = SseEmitterBuilder.buildWhileSendAndNoTimeout((sendStatus, mainThreadVariables) -> {
      //异步子线程
      //sendStatus.complete(); //结束发送
      Printer.err("sendCount = " + sendStatus.sendCount());
      if (sendStatus.sendCount() == 5) {
        Assert.isTrue(false, "aaaaaaaaaaaaaaaaaaa");
        //        sendStatus.complete();
      }
      return "{\"info\":\"" + Thread.currentThread() + " - " + params + "\"}";
    }, threadPoolService.getExecutor());
    Printer.err("@@@@@@@@@@@@@@@@" + Thread.currentThread() + " - " + params);
    return sseEmitter;
  }

  /** get - RequestParam */
  //  @RequireToken(UserToken.class)
  @GetMapping(value = "/demo", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity getTest(@RequestParam Map<String, String> params) {
//    HttpServletRequest request = ServletContextHolder.getRequestNonNull();
//    Printer.err(Thread.currentThread() + " params = " + params);
//    Printer.err(Thread.currentThread() + " " + IPUtils.getRealIp(request));
//    Printer.err("token = " + TokenThreadLocal.getTokenObj());
//    Enumeration<String> headerNames = request.getHeaderNames();
//    while (headerNames.hasMoreElements()){
//      String n = headerNames.nextElement();
//      System.err.println(n + " = " + request.getHeader(n));
//    }
//    System.out.println(request.getProtocol());
    //    long s = System.currentTimeMillis();
    //    Page<Demo> page = demoService.findAll(
    //      ConditionGroup.build()
    //                    .addGroup(
    //                      ConditionGroup.build(ConditionEnum.Link.LINK_OR)
    //                                    .addCondition("age", ConditionEnum.OPERATE_EQUAL, 3)
    //                                    .addCondition("address", ConditionEnum.OPERATE_EQUAL, "address2")
    //                    )
    //                    .addCondition("name", ConditionEnum.OPERATE_EQUAL, "name2"),
    //      Pages.Helper.pageable(params, new Sort(Sort.Direction.DESC, "createTime"))
    //    );
    //    TokenCacheObj token = tokenManager.getByToken("01eee3fad1604a84a0d6a146902511d5");
    //    System.err.println("s = " + (System.currentTimeMillis() - s));
    //return new ResponseEntity<>(demoService.qpsTest2(params), HttpStatus.OK);
//    System.err.println(System.getProperty("server.port"));
//    Uninterruptibles.sleepUninterruptibly(10, TimeUnit.SECONDS);
    return new ResponseEntity<>("123", HttpStatus.OK);
  }
  //

  /** post - RequestBody */
  @PostMapping(value = "/demo", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<Demo> saveTest(@RequestBody Map<String, String> params) {
    Demo t = new Demo();
    //转换-可以为空
    //    t.setAge(ConvertUtil.convert(params.get("age"), Integer.class));
    //转换-不能为空，传入默认值
    t.setAge(ConvertUtil.convert(params.get("age"), 0));
    //转换-不能为空, 抛出异常至前端
    //    t.setAge(ConvertUtil.checkNotNull(params, "age", Integer.class));

    //转换-不能为空, 抛出异常至前端
    //    t.setAddress(ConvertUtil.checkNotNull(params,"address", "地址", String.class));

    t.setName(params.get("name"));
    t.setCreateTime(new Date());
    return new ResponseEntity<>(demoService.save(t), HttpStatus.CREATED);
  }

  //
  //  /** put - RequestBody */
  //  @PutMapping(value = "/demo", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  //  public ResponseEntity<Demo> updateTest(@RequestBody Map<String, String> params) {
  //
  //    Demo t = demoService.findById(
  //      //转换-不能为空, 抛出异常至前端
  //      ConvertUtil.checkNotNull(params, "id", String.class)
  //    );
  //    Integer age = ConvertUtil.convert(params.get("age"), Integer.class);
  //    if(age != null){
  //      t.setAge(age);
  //    }
  //
  //    //转换-可以为空
  //    String name = ConvertUtil.convert(params.get("name"), String.class);
  //    if(StringUtils.isNotBlank(name)){
  //      t.setName(name);
  //    }
  //
  //    //转换-不能为空, 抛出异常至前端
  //    t.setAddress(ConvertUtil.checkNotNull(params,"address", "地址", String.class));
  //
  //    //时间转换，可为空，格式默认 yyyy-MM-dd HH:mm:ss, 更多格式见 Dates
  //    DateTime demoTime = ConvertUtil.dateNullable(
  //      params.get("demoTime"), "demo时间" + Dates.DATE_DOC_EXP, Dates.DATE_FORMATTER);
  //    if(demoTime != null){
  //      t.setUpdateTime(demoTime.toDate());
  //    }
  //    //时间转换，非空，参数为空时，抛出异常，格式默认 yyyy-MM-dd HH:mm:ss, 更多格式见 Dates
  ////    t.setUpdateTime(ConvertUtil.dateNonnull(
  ////      params.get("demoTime"), "demo时间" + Dates.DATE_TIME_DOC_EXP, null).toDate());
  //
  //    return new ResponseEntity<>(demoService.save(t), HttpStatus.CREATED);
  //  }
  //
  //
  @PutMapping(value = "/demo/thread", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<Demo> updateTestThread(@RequestBody Map<String, String> params) {
    //    int threadCount = 1;
    //    threadPoolService.callWithMainThreadWait(threadCount, new Callable<Integer>() {
    //      @Override
    //      public Integer call() throws Exception {
    //        demoService.incrementUpdate("222", 1);
    //        return 1;
    //      }
    //    });
    System.err.println("params = " + params);
    return new ResponseEntity<>(HttpStatus.CREATED);
  }

  //
  //
  //  /** del - PathVariable */
  @DeleteMapping(value = "/demo/{id}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity delTest(@PathVariable("id") String id) {
    System.err.println("id = " + id);
    return new ResponseEntity<>(HttpStatus.NO_CONTENT);
  }

  //  /** del - RequestParam */
  @DeleteMapping(value = "/demo", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity delTest2(@RequestBody Map<String, String> params) {
    System.err.println("params = " + params);
    return new ResponseEntity<>(HttpStatus.NO_CONTENT);
  }
  //
  //

  /**
   * elastic search 全文查询
   *
   * @param params -
   * <p> query        - Nullable - Str - 查询关键字，可用空格分割
   */
  @GetMapping(value = "/demo/es", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<DataPage<Demo>> esSearch(@RequestParam Map<String, String> params, HttpServletRequest request) {
    String realIp = IPUtils.getRealIp(request);
    System.out.println(realIp);
    return new ResponseEntity(realIp, HttpStatus.OK);
  }

  /** elastic search 重构索引 */
  //  @PutMapping(value = "/demo/es/rebuild/hard", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  //  public ResponseEntity rebuildIndexWithAll(@RequestParam Map<String, String> params) {
  //    demoService.rebuildIndexWithAll();
  //    return new ResponseEntity<>(HttpStatus.CREATED);
  //  }

  /** elastic search 重构索引 */
  //  @PutMapping(value = "/demo/es/rebuild/soft", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  //  public ResponseEntity rebuildIndexWithIncrement(@RequestParam Map<String, String> params) {
  //    demoService.rebuildIndexWithIncrement();
  //    return new ResponseEntity<>(HttpStatus.CREATED);
  //  }

  /** elastic search 重构索引 */
  //  @PutMapping(value = "/demo/es/rebuild/mixed", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  //  public ResponseEntity esRebuild(@RequestParam Map<String, String> params) {
  //    demoService.rebuildIndexWithNotPersistent();
  //    return new ResponseEntity<>(HttpStatus.CREATED);
  //  }
  //
  //
  @PostMapping(value = "/demo/msg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity publishMsg(@RequestParam Map<String, String> params) {
    demoService.demoPublish();
    return new ResponseEntity<>(HttpStatus.CREATED);
  }
  @Autowired
  private RedisTemplate redisTemplate;

  /** 分布式事务 */
  @PostMapping(value = "/demo/tx", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity testTx(@RequestParam Map<String, String> params) {
    demoService.txTest();
    return new ResponseEntity<>(HttpStatus.CREATED);
  }

//  @RequireToken
  @PostMapping(value = "/demo/redis", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity testRedis(@RequestParam Map<String, String> params) {
    //    UserToken userToken = TokenThreadLocal.getUserTokenNonNull();
    //    System.err.println("token = " + ToStringBuilder.reflectionToString(userToken));
        try {
          threadPoolService.runWithMainThreadWait(1000, new Runnable() {
            @Override
            public void run() {
    demoService.redisTest();
            }
          });
        } catch (Exception e) {
          e.printStackTrace();
        }
    //    Uninterruptibles.sleepUninterruptibly(3, TimeUnit.SECONDS);
//    System.err.println("@@@@@@@@@@@@@@@@@@@@@@@@");
    System.err.println("ggg = " + redisTemplate.opsForValue().get(CacheName.PRE_SMS_CODE_LG.getPrefixCacheKey("ggg")));
    return new ResponseEntity<>(HttpStatus.CREATED);
  }


  /** external feign */
  @PostMapping(value = "/demo/ex-feign/login", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity exLogin(@RequestParam Map<String, String> params) {
    return new ResponseEntity<>(demoService.exLogin(params), HttpStatus.CREATED);
  }
}
