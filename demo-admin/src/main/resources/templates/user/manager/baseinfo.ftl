<div style="">

<#-- 个人信息 -->
  <div style="width: 450px;height: auto;display:table;margin: 0px auto">
    <div class="col-xs-12 form-group" style="text-align: center">
      <img alt="头像" class="img-circle" id="avatar"
           style="width: 80px;height: 80px;"
           src="<#if userBaseInfo.avatarr!=null>${userBaseInfo.avatarr}<#elseif userBaseInfo.wxImg!=null>${userBaseInfo.wxImg}<#else>/admin/img/avatar.jpg</#if>">
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">姓名/昵称：</label>
        <div class="col-xs-8" style="text-align: left">${userBaseInfo.userNickName}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">性别：</label>
        <div class="col-xs-8" style="text-align: left">
          <#if userBaseInfo.gender==1>男
          <#elseif userBaseInfo.gender==2>女
          <#else>未知
          </#if>
        </div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">生日：</label>
        <div class="col-xs-8" style="text-align: left">${userBaseInfo.birth}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">手机号码：</label>
        <div class="col-xs-8" style="text-align: left">${userBaseInfo.phone}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">电子邮箱：</label>
        <div class="col-xs-8" style="text-align: left">${userBaseInfo.userEmail}</div>
      </div>
    </div>
  </div>

  <hr>

<#-- 公司信息 -->
  <div style="width: 450px;height: auto;display:table;margin: 0px auto">
    <div class="col-xs-12 form-group" style="text-align: center">
      <#if userCompanyInfo.logo??>
        <img alt="logo" class="img-circle" id="logo" style="width:80px;height:80px" src="${userCompanyInfo.logo}"/>
      </#if>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">企业名称：</label>
        <div class="col-xs-8" style="text-align: left">${userCompanyInfo.name}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">企业性质：</label>
        <div class="col-xs-8" style="text-align: left">${userCompanyInfo.nature}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">所在行业：</label>
        <div class="col-xs-8" style="text-align: left">${userCompanyInfo.industry}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">公司规模：</label>
        <div class="col-xs-8" style="text-align: left">${userCompanyInfo.scale}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">公司地址：</label>
        <div class="col-xs-8" style="text-align: left">${userCompanyInfo.address}</div>
      </div>
    </div>
    <div class="col-xs-12 form-group">
      <div>
        <label class="col-xs-4 control-label" style="text-align: right">联络电话：</label>
        <div class="col-xs-8" style="text-align: left">${userCompanyInfo.phone}</div>
      </div>
    </div>
  </div>

</div>