<!DOCTYPE html>
<html>

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">


  <title>500-出错啦</title>
  <meta name="keywords" content="">
  <meta name="description" content="">

  <link rel="shortcut icon" href="favicon.ico">
  <link href="/admin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
  <link href="/admin/css/font-awesome.css?v=4.4.0" rel="stylesheet">

  <link href="/admin/css/animate.css" rel="stylesheet">
  <link href="/admin/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">


<div class="middle-box text-center animated fadeInDown">
  <h1>500</h1>
  <h3 class="font-bold">Internal Server Error</h3>
  <h3 class="font-bold">服务器出错啦，请联系管理员。</h3>
  <div class="error-desc">
    <div class="error-desc">
      <div id="btn_div">
      <#if errorMap??>
        <a data-toggle="collapse" data-parent="#accordion"
           href="#collapseOne" class="btn btn-danger m-t">错误信息</a>
      </#if>
      </div>
    </div>
    <div id="collapseOne" class="panel-collapse collapse">
      <div class="panel-body text-left font-bold error-msg">
        <#if errorMap??>
          <#assign keys=errorMap?keys/>
          <#list keys as key>
            <p class="col-xs-4 text-right">${key}</p><p class="col-xs-1 row">:</p><p class="col-xs-7">${errorMap[key]!''}</p>
          </#list>
        </#if>
      </div>
    </div>
  </div>
</div>

<!-- 全局js -->
<script src="/admin/js/jquery.min.js?v=2.1.4"></script>
<script src="/admin/js/bootstrap.min.js?v=3.3.6"></script>

<script>
  $(function(){
    if(window.parent === window){
      $("#btn_div").append("<a href='javascript:history.back();' class='btn btn-primary m-t'>" +
        "<i class='fa fa-reply'></i> 返回</a>");
    }else{
      $("#btn_div").append("<a href=\"javascript:window.parent.index.closeNav(\'"+location.pathname+"\');\" " +
        "class='btn btn-primary m-t'><i class='fa fa-close'></i> 关闭</a>");
    }
  });
</script>
</body>

</html>
