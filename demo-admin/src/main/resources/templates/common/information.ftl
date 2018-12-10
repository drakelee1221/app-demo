<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="col-xs-12 col-md-6">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4>修改个人资料</h4>
    </div>
    <div class="panel-body">
      <div class="form-group">
        <label for="memberName" class="control-label">用户名称：</label>
        <div>
          <input type="text" class="form-control" id="memberName" value="${memberToken.memberName}"/>
        </div>
      </div>
      <div class="form-group">
        <label for="account" class="control-label">登录帐号：</label>
        <div>
          <input type="text" class="form-control" id="account" value="${memberToken.account}"/>
        </div>
      </div>
      <div class="form-group">
        <label class="control-label">登录密码：</label>
        <p>
          <input type="text" class="form-control" id="oldPwd" placeholder="旧密码"/>
        </p>
        <p>
          <input type="text" class="form-control" id="pwd" placeholder="新密码(大于6位)"/>
        </p>
      </div>
    </div>
    <div class="panel-footer text-center">
      <button onclick="im.submit()" type="button" class="btn btn-info" >
        <i class="fa fa-save"></i>
        保存
      </button>
    </div>
  </div>
</div>

</@htmlContent>

<@htmlJs>
<script>
  var im = {
    submit:function(){
      var op = $("#oldPwd").val().trim();
      var p = $("#pwd").val().trim();
      if(op.length > 0 || p.length > 0){
        if(p.length < 6){
          layer.alert("新密码长度不能小于6位！", {icon: 2});
          return;
        }
        if(op.length === 0){
          layer.alert("旧密码不能为空！", {icon: 2});
          return;
        }
      }
      var a = $("#account").val().trim();
      if(a.length > 0 && a.length < 5){
        layer.alert("登录帐号长度不能小于5位！", {icon: 2});
        return;
      }
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/information/update", {
        memberName:$("#memberName").val(),
        account:$("#account").val(),
        oldPwd:op,
        pwd:p
      }, function (rs) {
        layer.close(l);
        if (rs.success) {
          var parent = window.parent.$("#index_member_name");
          if(parent.length > 0){
            parent.html(rs.data.memberName);
          }
          layer.alert(rs.message, {icon: 1}, function(){
            if(parent.length > 0){
              window.parent.index.closeNav(location.pathname);
            }
            else{
              location.reload();
            }
          });
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    }
  };
</script>
</@htmlJs>