<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${_APP_NAME_!'麦积财税'}</title>
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="shortcut icon" href="favicon.ico">
  <link href="${ctx!}/admin/css/plugins/chosen/chosen.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
  <link href="${ctx!}/admin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
  <link href="${ctx!}/admin/css/animate.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/style.css?v=4.1.0" rel="stylesheet">
  <!--jquery-->
  <script src="${ctx!}/admin/js/jquery.min.js"></script>
  <script src="${ctx!}/admin/js/jquery.serializejson.min.js"></script>
  <script src="${ctx!}/admin/js/jquery.form.min.js"></script>

  <!-- Chosen -->
  <script src="${ctx!}/admin/js/plugins/chosen/chosen.jquery.js"></script>
  <!--bootstrap-->
  <script src="${ctx!}/admin/js/bootstrap.min.js"></script>
  <!-- Peity -->
  <script src="${ctx!}/admin/js/plugins/peity/jquery.peity.min.js"></script>
  <!-- layer -->
  <script src="${ctx!}/admin/js/plugins/layer/layer.min.js"></script>
  <!-- 自定义js -->
  <script src="${ctx!}/admin/js/content.js"></script>
  <script src="${ctx!}/admin/js/jquery.payload.js"></script>
  <!--jquery validate-->
  <script src="${ctx!}/admin/js/plugins/validate/jquery.validate.min.js"></script>
  <script src="${ctx!}/admin/js/plugins/validate/messages_zh.min.js"></script>
  <script type="text/javascript">
    var ctx = "";
    <#if (ctx)?? && ctx != "">
    ctx = ${ctx};
    </#if>
  </script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
<#macro htmlContent>
  <#nested>
</#macro>
</div>
<#macro htmlJs>
  <#nested>
</body>
</html>
</#macro>