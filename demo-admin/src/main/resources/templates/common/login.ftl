<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <title>麦积财税</title>
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link href="${ctx!}/admin/css/bootstrap.min.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
  <link href="${ctx!}/admin/css/animate.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/style.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/login.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/gradient-button.css" rel="stylesheet">
  <!--[if lt IE 9]>
  <meta http-equiv="refresh" content="0;ie.html"/>
  <![endif]-->
  <script>
    if (window.top !== window.self) {
      window.top.location = window.location;
    }
  </script>

</head>

<body class="signin">
<div class="signinpanel">
  <div class="row">
    <form method="post" action="${ctx!}/admin/login" id="frm" class="shadow">
      <div class="text-center m-b-lg">
        <#--<img src="/admin/img/logo-slogan-blue.png">-->
      </div>
      <div class="login-group">
        <label class="uname"></label>
        <input style="display:none">
        <input type="text" class="form-control" name="username" id="username" placeholder="用户名" autocomplete="off"/>
      </div>
      <div class="login-group">
        <label class="pword"></label>
        <input style="display:none">
        <input type="password" class="form-control" name="password" id="password" placeholder="密码" autocomplete="off"/>
      </div>
      <button onclick="loginSubmit();return false;" id="submit_button"
        class="subscribe_cta g-btn g-btn-primary g-btn-centred g-btn-fullWidth m-t-md">
        <div class="g-btn_wrap">
          <div class="t-shadow m-t-n-xxs">登&nbsp;&nbsp;&nbsp;&nbsp;录</div>
          <div class="g-btn_background"></div>
        </div>
      </button>
      <#--<div style="width: 100%;margin-left: 200px;margin-top: 5px"><a href="${ctx!}/admin/register" target="_blank">注册为服务人员</a></div>-->
      <#--<div style="width: 100%;margin-left: 200px;margin-top: 10px"><a href="${ctx!}/admin/register/servicer" target="_blank">服务人员注册</a></div>-->
      <#--<div style="width: 100%;margin-left: 200px;margin-top: 5px"><a href="${ctx!}/admin/register/org" target="_blank">企业注册</a></div>-->
    </form>

    <div class="m-t-lg t-shadow text-center">
      <label>XXX有限公司 © 2018</label>
    </div>
  </div>
<#--<div class="signup-footer">-->
<#--<div class="pull-left">-->
<#--</div>-->
<#--</div>-->
</div>

<!-- 全局js -->
<script src="${ctx!}/admin/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx!}/admin/js/bootstrap.min.js?v=3.3.6"></script>

<!-- 自定义js -->
<script src="${ctx!}/admin/js/content.js?v=1.0.0"></script>
<script src="${ctx!}/admin/js/jquery.payload.js"></script>

<!-- jQuery Validation plugin javascript-->
<script src="${ctx!}/admin/js/plugins/validate/jquery.validate.min.js"></script>
<script src="${ctx!}/admin/js/plugins/validate/messages_zh.min.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/layer.min.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/extend/layer.ext.js"></script>
<script src="${ctx!}/admin/js/gradient-button.js"></script>
<script type="text/javascript">
  $(function () {
    // 在键盘按下并释放及提交后验证提交表单
    $("#frm").validate({
      rules: {
        username: {
          required: true,
          minlength: 2
        },
        password: {
          required: true,
          minlength: 5
        }
      },
      messages: {
        username: {
          required: "请输入用户名",
          minlength: "用户名必需由两个字母组成"
        },
        password: {
          required: "请输入密码",
          minlength: "密码长度不能小于 6 个字母"
        }
      },
      submitHandler: function (form) {
        $("#submit_button").attr("disabled", true);
        form.submit();
      }
    });
    var errorMsg = '${errorMsg!}';
    if (errorMsg) {
      layer.alert(errorMsg, {icon: 2});
    }
    document.onkeydown = function (event) {
      var e = event || window.event || arguments.callee.caller.arguments[0];
      if (e && e.keyCode === 13) { // enter
        layer.close(1);
        if (errorMsg) {
          errorMsg = null;
          $("#username").focus();
        }
      }
    };

    $("#frm").keydown(function (e) {
      if (e.keyCode === 13) {
        loginSubmit();
      }
    });
  });
  function loginSubmit() {
    $('#frm').submit();
  }
</script>
</body>

</html>
