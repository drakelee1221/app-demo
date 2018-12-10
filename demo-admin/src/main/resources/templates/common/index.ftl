<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="renderer" content="webkit">

  <title>XXX后台管理</title>

  <meta name="keywords" content="">
  <meta name="description" content="">

  <!--[if lt IE 9]>
  <meta http-equiv="refresh" content="0;ie.html"/>
  <![endif]-->

  <link rel="shortcut icon" href="favicon.ico">
  <link href="${ctx!}/admin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
  <link href="${ctx!}/admin/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
  <link href="${ctx!}/admin/css/animate.css" rel="stylesheet">
  <link href="${ctx!}/admin/css/style.css?v=4.1.0" rel="stylesheet">
  <link href="${ctx!}/admin/css/index.css" rel="stylesheet">
  <!-- GrowingIO Analytics code version 2.1 -->
  <!-- Copyright 2015-2018 GrowingIO, Inc. More info available at http://www.growingio.com -->


</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
  <!--左侧导航开始-->
  <nav class="navbar-default navbar-static-side" role="navigation">
    <div class="nav-close"><i class="fa fa-times-circle"></i>
    </div>
    <div class="sidebar-collapse">
      <ul class="nav" id="side-menu" style="display:none">
        <li>
          <div class="logo-slogan bg-info">
            <#--163 x 40-->
            <#--<img style="margin-top: 10px;" src="/admin/img/logo-slogan.png"/>-->
            <h2>XXX后台管理</h2>
          </div>
          <div class="logo-slogan-min bg-info">
            <#--48 x 48-->
            <#--<img style="margin-top: 0px;" src="/admin/img/logo.png"/>-->
          </div>
        </li>
        <li class="nav-header bg-info p-xs">
          <div class="dropdown profile-element">
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="font-bold block m-sm text-fff">
                                  <i class="fa fa-user"> </i>
                                  &nbsp;<span id="index_member_name">${memberToken.memberName!memberToken.account}</span>　
                                  <b class="caret"> </b>
                                </span>
            </a>
            <button class="navbar-minimalize btn btn-info" style="position:absolute;right:0;top:0" href="#"><i
              class="fa fa-bars"></i></button>
            <ul class="dropdown-menu fadeInRight m-t-xs text-success">
              <li><a class="J_menuItem" href="${ctx!}/admin/information">
                <i class="fa fa-edit"></i>
                修改资料</a>
              </li>
              <li class="divider"></li>
              <li><a href="/admin/logout">
                <i class="fa fa-power-off"></i>
                安全退出</a>
              </li>
            </ul>
          </div>
          <div class="logo-element" style="cursor:pointer">
            <button class="btn btn-info"><i class="fa fa-bars"></i></button>
          </div>
        </li>
        <li>
          <a href='javascript:$("#content-nav a:first").tab("show")'>
            <i class="fa fa-home"></i>
            <span class="nav-label">主页</span>
          </a>
        </li>
        <li class="line dk"></li>
      <#macro appTree app>
        <li>
          <#if app.directory == 1 && app.children?? && app.children?size gt 0>
            <a href="javascript:void(0)" title="${app.description}">
              <i class="${app.iconClass}"></i>
              <span class="nav-label">${app.name}</span><span class="fa arrow"></span>
            </a>
          </#if>
          <#if app.directory == 0>
            <a class="J_menuItem" href="${ctx!}${app.targetUrl}"
               id="${app.id}"><i class="${app.iconClass}"></i>
              <span class="nav-label">${app.name}</span>
            </a>
          </#if>
          <#if app.children?? && app.children?size gt 0>
            <ul class="nav nav-second-level">
              <#list app.children as child>
                  <@appTree app=child />
                </#list>
            </ul>
          </#if>
        </li>
      </#macro>
      <#list adminAuth.appInfoDtoList as app>
        <@appTree app=app />
      </#list>
      </ul>
    </div>
  </nav>
  <!--左侧导航结束-->
  <!--右侧部分开始-->
  <div id="page-wrapper" class="gray-bg dashbard-1">
    <div class="row border-bottom">
      <ul class="nav nav-tabs navbar-static-top" role="tablist" id="content-nav">
        <li role="presentation" class="active"
            onmouseleave='index.navLeave(this)' onmouseover='index.navOver(this)' data-href='${ctx!}/admin/home'>
          <a href="#tab_home" aria-controls="tab_home" role="tab" data-toggle="tab"><i class="fa fa-home"></i>主页</a>
          <button type='button' class='close main-if-refresh' onclick='index.refreshWindow("tab_home")'><i class='fa fa-refresh'></i></button>
        </li>
      </ul>
    </div>
    <div class="row J_mainContent tab-content" id="content-main">
      <iframe role="tabpanel" class="tab-pane active" id="tab_home" width="100%" height="100%"
              src="${ctx!}/admin/home" frameborder="0" seamless></iframe>
    </div>
  </div>
  <!--右侧部分结束-->
  <!--右侧右键菜单开始-->
  <div id="context-menu">
    <ul class="dropdown-menu" role="menu">
      <li><a tabindex="-1" class="dropdown-menu-other">关闭其他</a></li>
      <li><a tabindex="-1" class="dropdown-menu-all">关闭所有</a></li>
    </ul>
  </div>
  <!--右侧右键菜单结束-->
</div>

<!-- 全局js -->
<script src="${ctx!}/admin/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx!}/admin/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${ctx!}/admin/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="${ctx!}/admin/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/layer.min.js"></script>
<script src="${ctx!}/admin/js/bootstrap-contextmenu.js"></script>

<!-- 自定义js -->
<script src="${ctx!}/admin/js/hAdmin.js?v=4.1.0"></script>
<script src="${ctx!}/admin/js/index.js"></script>
<script src="${ctx!}/admin/js/jquery.payload.js"></script>

<!-- 第三方插件 -->
<script src="${ctx!}/admin/js/plugins/pace/pace.min.js"></script>


</body>

</html>
