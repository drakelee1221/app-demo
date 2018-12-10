<#include "/layout/pagelayout.ftl"/>

<link href="${ctx!}/admin/pub/css/common/servicer_register.css" rel="stylesheet">
<@htmlContent>
   <form id="registerForm" name="registerForm" style="text-align: center">
     <table border=0 cellpadding=0 cellspacing=0 width=900
            style='border-collapse:collapse;table-layout:fixed;width:750pt;width: auto;margin: 0 auto;'>
       <tr height=70 style='mso-height-source:userset;height:52.5pt'>
         <td colspan=4 height=70 class=xl65 width=900 style='height:52.5pt;width:750pt'>《麦积财税》服务人员信息登记表</td>
       </tr>
       <tr height=24 style='height:18.0pt'>
         <td colspan=4 height=24 class=xl68 width=900 style='height:18.0pt;width:750pt'><span style="color: red">人员类型</span></td>
       </tr>
       <tr height=21 style='height:60.0pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>人员类型
         </td>
         <td class=xl70 width=447 colspan="3"  style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="radio" class="radio-button" required="required" id="userTypeManager"
                    name="userType" value="2">&nbsp;&nbsp;&nbsp;<label for="userTypeManager"><span style="font-weight:bold;font-size: 20px;color: red">客户经理（商务人员）</span>&nbsp;&nbsp;</label>
             <input type="radio" class="radio-button" required="required" id="userTypeService"
                    name="userType" value="3">&nbsp;&nbsp;&nbsp;<label for="userTypeService"><span style="font-weight:bold;font-size: 20px;color: red">服务专员（工商或会计）</span></label>
           </div>
         </td>
       </tr>
       <tr height=24 style='height:18.0pt'>
         <td colspan=4 height=24 class=xl68 width=900 style='height:18.0pt;width:750pt'>基本信息</td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>登录手机号
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="loginPhone" name="loginPhone">
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'>
           <#--<span style="color:red">*&nbsp;&nbsp;</span>-->
           短信验证码
         </td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <#--<input type="text" class="form-control-static col-sm-6" required="required" id="smsCode" name="smsCode">-->
             <#--<button id="getCode" type="button" class="btn btn-info btn-xs form-control-static col-sm-5 inline" style="margin-left: 15px;">获取验证码-->
             <#--</button>-->
             暂无需验证
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>登录密码
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="loginPwd" name="loginPwd">
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>确认密码
         </td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="confirmPwd" name="confirmPwd">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>姓名
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="userName" name="userName">
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>性别
         </td>
         <td class=xl70 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="radio" class="radio-button" required="required" id="gender_male"
                    name="gender" value="1">&nbsp;&nbsp;&nbsp;男&nbsp;&nbsp;
             <input type="radio" class="radio-button" required="required" id="gender_female"
                    name="gender" value="2">&nbsp;&nbsp;&nbsp;女
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>身份证号
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="idCard" name="idCard">
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>出生日期
         </td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" id="birthday" name="birthday" class="form-control layer-date" style="max-width: none"
                    required="required">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>身份证附件
         </td>
         <td colspan=3 class=xl66 width=714 style='border-left:none;width:536pt;text-align: center;'>
           <div>
             <label title="上传身份证" id="idCardAttachment" class="btn btn-primary btn-xs">
               上传
             </label>
           </div>
           <div id="idCardAttachmentDiv">

           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>民族
         </td>
         <td class=xl70 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <select class="form-control" name="nation" id="nation" required="required">
               <option value="汉族" selected>汉族</option>
               <option value="其他">其他</option>
             </select>
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>婚姻状况
         </td>
         <td class=xl70 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="radio" class="radio-button" required="required" id="marriaged"
                    name="marriage" value="未婚">未婚&nbsp;&nbsp;
             <input type="radio" class="radio-button" placeholder="请选择婚姻状况(必填)" required="required" id="marriaging"
                    name="marriage" value="已婚">已婚
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>联系电话1
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="firstContactPhone"
                    name="firstContactPhone">
           </div>
         </td>
         <td class=xl69 width=145 style='border-top:none;border-left:none;width:109pt'>联系电话2</td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" id="secondContactPhone" name="secondContactPhone">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>紧急联系人
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="urgencyContact" name="urgencyContact">
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>紧急联系人电话
         </td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="urgencyContactPhone"
                    name="urgencyContactPhone">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>所在地区
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <select class="form-control-static col-sm-4" name="firstRegion" id="firstRegion">
             </select>
             <select class="form-control-static col-sm-4" name="secondRegion" id="secondRegion">
             </select>
             <select class="form-control-static col-sm-4" name="region" id="region" required="required">
             </select>
           </div>
         </td>
         <td class=xl69 width=145 style='border-top:none;border-left:none;width:109pt'>家庭住址</td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" id="homeAddress" name="homeAddress">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl69 width=126 style='height:15.75pt;border-top:none;
  width:95pt'>电子邮箱
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" id="email" name="email">
           </div>
         </td>
         <td class=xl69 width=145 style='border-top:none;border-left:none;width:109pt'>最高学历</td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" id="education" name="education">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl69 width=126 style='height:15.75pt;border-top:none;
  width:95pt'>毕业学校
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" id="school" name="school">
           </div>
         </td>
         <td class=xl69 width=145 style='border-top:none;border-left:none;width:109pt'>所学专业</td>
         <td class=xl66 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" id="major" name="major">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl69 width=126 style='height:15.75pt;border-top:none;
  width:95pt'>学历证书
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div>
             <label title="上传学历证书" id="educationAttachment" class="btn btn-primary btn-xs">
               上传
             </label>
           </div>
           <div id="educationAttachmentDiv">

           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl69 width=126 style='height:15.75pt;border-top:none;
  width:95pt'>资格证书
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div>
             <label title="上传资格证书" id="qualificationAttachment" class="btn btn-primary btn-xs">
               上传
             </label>
           </div>
           <div id="qualificationAttachmentDiv">

           </div>
         </td>
       </tr>
       <tr height=24 style='height:18.0pt'>
         <td colspan=4 height=24 class=xl68 width=900 style='height:18.0pt;width:750pt'>工作信息</td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>从业年限
         </td>
         <td class=xl66 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <select class="form-control" name="workYear" id="workYear" required="required">
             </select>
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>擅长行业
         </td>
         <td class=xl70 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="text" class="form-control" required="required" id="industry" name="industry">
           </div>
         </td>
       </tr>
       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>服务上限
         </td>
         <td class=xl70 width=358 style='border-top:none;border-left:none;width:269pt'>
           <div class="form-group" style="margin:0">
             <select class="form-control" name="maxService" id="maxService" required="required">
             </select>
           </div>
         </td>
         <td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'><span style="color:red">*&nbsp;&nbsp;</span>目前工作状态
         </td>
         <td class=xl70 width=447 style='border-top:none;border-left:none;width:335pt'>
           <div class="form-group" style="margin:0">
             <input type="radio" class="radio-button" required="required" id="partTime"
                    name="workStatus" value="兼职">兼职&nbsp;&nbsp;
             <input type="radio" class="radio-button" required="required" id="fullTime"
                    name="workStatus" value="专职">专职
           </div>
         </td>
       </tr>

       <tr height=24 style='height:18.0pt'>
         <td colspan=4 height=24 class=xl68 width=900 style='height:18.0pt;width:750pt'>系统信息</td>
       </tr>

       <tr height=21 style='height:15.75pt'>
         <td height=21 class=xl69 width=126 style='height:15.75pt;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>头像
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div>
             <label title="上传头像" id="avatar" class="btn btn-primary btn-xs">
               上传
             </label>
           </div>
           <div id="avatarDiv">

           </div>
         </td>
       </tr>
       <#--<tr height=40 style='mso-height-source:userset;height:30.0pt'>-->
         <#--<td height=40 class=xl69 width=126 style='height:30.0pt;border-top:none;-->
  <#--width:95pt'>受邀码-->
         <#--</td>-->
         <#--<td height=21 class=xl71 width=126 style='height:15.75pt;border-top:none;-->
  <#--width:95pt'>-->
           <#--<div class="form-group" style="margin:0">-->
             <#--<input type="text" class="form-control" placeholder="输入则关联企业，不输入则关联系统默认" id="code"-->
                    <#--name="code">-->
           <#--</div>-->
         <#--</td>-->
         <#--<td class=xl71 width=145 style='border-top:none;border-left:none;width:109pt'>企业名字(不填)-->
         <#--</td>-->
         <#--<td class=xl70 width=447 style='border-top:none;border-left:none;width:335pt' id="companyName">-->

         <#--</td>-->
       <#--</tr>-->
       <tr height=24 style='height:18.0pt'>
         <td colspan=4 height=24 class=xl68 width=900 style='height:18.0pt;width:750pt'>机构选择</td>
       </tr>
       <tr height=107 style='mso-height-source:userset;height:auto'>
         <td height=107 class=xl71 width=126 style='height:auto;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>机构选择
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div class="form-group" style="margin:0">
             <button type="button" class="btn btn-xs btn-primary" id="chooseServiceRegion">点击选择</button>
             <input type="hidden" placeholder="机构选择" required="required" id="code"
                    name="code">
             <input type="text" class="form-control" readonly="readonly" placeholder="机构" required="required"
                    id="orgName"
                    name="orgName">
           </div>
         </td>
       </tr>
       <tr height=24 style='height:18.0pt'>
         <td colspan=4 height=24 class=xl68 width=900 style='height:18.0pt;width:750pt'>服务信息</td>
       </tr>
       <tr height=107 style='mso-height-source:userset;height:50px'>
         <td height=107 class=xl71 width=126 style='height:auto;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>服务地区
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div class="form-group" style="margin:0">
               <input type="checkbox" value="1040800" name="serviceRegionBox" custname="北碚">北碚</input>
               <input type="checkbox" value="1043800" name="serviceRegionBox" custname="沙坪坝">沙坪坝</input>
               <input type="checkbox" value="1040700" name="serviceRegionBox" custname="渝北">渝北</input>
               <input type="checkbox" value="1043500" name="serviceRegionBox" custname="大渡口">大渡口</input>
               <input type="checkbox" value="1044000" name="serviceRegionBox" custname="南岸">南岸</input>
               <input type="checkbox" value="1043900" name="serviceRegionBox" custname="九龙坡">九龙坡</input>
               <input type="checkbox" value="1043700" name="serviceRegionBox" custname="江北">江北</input>
               <input type="checkbox" value="1041200" name="serviceRegionBox" custname="渝中">渝中</input>
               <input type="checkbox" value="1040900" name="serviceRegionBox" custname="巴南">巴南</input>

               <input type="checkbox" value="d42695e6-7722-48a2-8490-e4bc9ca88596" name="serviceRegionBox" custname="两江新区">两江新区</input>
               <input type="checkbox" value="09579f35-276f-4af0-992e-37bffb35e776" name="serviceRegionBox" custname="经开区">经开区</input>
               <input type="checkbox" value="15b82047-9011-4b30-a086-1a798bac4a6f" name="serviceRegionBox" custname="高新区">高新区</input>
               <input type="checkbox" value="1041300" name="serviceRegionBox" custname="万州">万州</input>

             <input type="hidden" placeholder="服务地区" required="required" id="serviceRegion"
                    name="serviceRegion">
           </div>
         </td>
       </tr>
       <tr height=107 style='mso-height-source:userset;height:auto'>
         <td height=107 class=xl71 width=126 style='height:auto;border-top:none;
  width:95pt'><span style="color:red">*&nbsp;&nbsp;</span>擅长服务
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div class="form-group" style="margin:0">
             <button type="button" class="btn btn-xs btn-primary" id="chooseProducts">点击选择</button>
             <input type="hidden" required="required" id="products"
                    name="products">
             <input type="text" class="form-control" readonly="readonly" placeholder="产品" required="required"
                    id="productsName"
                    name="productsName">
           </div>
         </td>
       </tr>
       <tr height=110 style='mso-height-source:userset;height:auto'>
         <td height=110 class=xl69 width=126 style='height:auto;border-top:none;
  width:95pt'>个性签名
         </td>
         <td colspan=3 class=xl70 width=714 style='border-left:none;width:536pt'>
           <div class="form-group" style="margin:0">
             <textarea class="form-control" rows="3" name="intro" id="intro"></textarea>
           </div>
         </td>
       </tr>
       <tr height=110 style='mso-height-source:userset;height:auto'>
         <td colspan=4 class=xl70 width=714 style='width:536pt'>
           <div class="form-group" style="margin:10px 0px">
             <input type="checkbox" checked id="user_protocol">
             <a href="https://www.he800.com/he800htv1.0.pdf" target="_blank">同意麦积财税平台合作协议（点击查看协议）</a>
           </div>
         </td>
       </tr>
       <tr height=110 style='height:82.5pt'>
         <td colspan=4 height=24 width=900 style='width:750pt'>
           <button type="button" id="submit" class="btn btn-lg btn-success" style="width:200px">提交</button>
         </td>
       </tr>
       <tr height=110 style='height:82.5pt'></tr>
     </table>
   </form>

<form id="attaForm" name="attaForm" method="post">
  <input type="file" style="display: none" dir="" id="file" name="file" enctype="multipart/form-data"
         accept="image/*"/>
</form>

<#--新增部门选择服务地区-->
<div class="modal" id="regionModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">选择机构</b>
        </h4>
      </div>
      <div class="modal-body">
        <div id="save-region-tree" class="region-tree"></div>
      </div>
      <div class="modal-footer ">
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;"
                onclick="confirmRegion()">确定
        </button>
        <button type="button" class="btn btn-danger block m-b" style="float: left;margin-right: 20px"
                onclick="clearSelect('save-region-tree')">清除
        </button>
      </div>
    </div>
  </div>
</div>
<#--/新增部门选择服务地区-->

<div class="modal" id="productModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">选择擅长产品</b>
        </h4>
      </div>
      <div class="modal-body">
        <div id="product_list"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;"
                onclick="confirmProduct()">确定
        </button>
        <button type="button" class="btn btn-danger block m-b" style="float: left;margin-right: 20px"
                onclick="clearProductSelect()">清除
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="photoClipModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="width: 600px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">头像裁剪(鼠标拖动、滚轮缩放)</b>
        </h4>
      </div>
      <div class="modal-body">
        <div id="clipArea" style="height: 300px;width: 100%"></div>
        <br>
        <input type="file" id="avatarFile" style="margin: 20px;float: left">
        <button id="clipBtn" class="btn btn-danger" style="margin: 20px;">裁剪</button>
        <div id="avatarView" style="margin: 0 auto;width: 150px;height: 150px;background-color: #666;"></div>
        <form id="avatarForm" name="avatarForm"> </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;" onclick="confirmAvatar()">确定</button>
      </div>
    </div>
  </div>
</div>

</@htmlContent>

<#--图片裁剪-->
<script src="${ctx!}/admin/pub/js/common/photo_clip/hammer.min.js"></script>
<script src="${ctx!}/admin/pub/js/common/photo_clip/iscroll-zoom-min.js"></script>
<script src="${ctx!}/admin/pub/js/common/photo_clip/lrz.all.bundle.js"></script>
<script src="${ctx!}/admin/pub/js/common/photo_clip/PhotoClip.js"></script>
<#--/图片裁剪-->

<script src="${ctx!}/admin/pub/js/common/servicer_register.js"></script>
<#--<script src="${ctx!}/admin/pub/js/profession_mapping/save_region_tree.js"></script>-->
<script src="${ctx!}/admin/js/jquery.payload.js"></script>

<@htmlJs>


  <@fancytree/>
</@htmlJs>
