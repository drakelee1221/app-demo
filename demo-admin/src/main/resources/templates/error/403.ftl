<!DOCTYPE html>
<!--
  ~ Copyright (c) 2017.  mj.he800.com Inc. All rights reserved.
  -->

<html>

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">


  <title>403-资源未授权</title>
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
  <h1>403</h1>
  <h3 class="font-bold">Forbidden</h3>
  <h3 class="font-bold">资源页面未授权</h3>
  <div class="error-desc">
    <div class="error-desc">
      <div id="btn_div">
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
