<#include "/layout/pagelayout.ftl"/>

<link href="${ctx!}/admin/pub/css/common/org_register.css" rel="stylesheet">
<@htmlContent>
 <form id="registerForm" name="registerForm" style="text-align: center">
   <table border=0 cellpadding=0 cellspacing=0 width=1047 style='border-collapse:
 collapse;table-layout:fixed;width:786pt;width: auto;margin: 0 auto;'>
     <tr height=70 style='mso-height-source:userset;height:52.5pt'>
       <td colspan=4 height=70 class=xl70 width=1047 style='height:52.5pt;
  width:786pt'>《麦积财税》合作企业信息登记表
       </td>
     </tr>
     <tr height=24 style='height:18.0pt'>
       <td colspan=4 height=24 class=xl69 width=1047 style='height:18.0pt;
  width:786pt'>企业基本信息
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>联系电话
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" required="required" id="contactPhone" name="contactPhone">
         </div>
       </td>
       <td class=xl68 width=146 style='border-top:none;border-left:none;width:110pt'><span style="color:red">*&nbsp;&nbsp;</span>短信验证码
       </td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control-static col-sm-6" required="required" id="smsCode" name="smsCode">
           <button id="getCode" type="button" class="btn btn-info btn-xs form-control-static col-sm-5 inline"
                   style="margin-left: 15px;">获取验证码
           </button>
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>企业名称
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" required="required" id="companyName" name="companyName">
         </div>
       </td>
       <td class=xl65 width=146 style='border-top:none;border-left:none;width:110pt'>企业信用代码</td>
       <td class=xl67 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" id="companyCode" name="companyCode">
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>营业执照
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div>
           <label title="上传营业执照" id="licenseAttachment" class="btn btn-primary btn-xs">
             上传
           </label>
         </div>
         <div id="licenseAttachmentDiv">

         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>法人姓名
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" required="required" id="legalPerson" name="legalPerson">
         </div>
       </td>
       <td class=xl68 width=146 style='border-top:none;border-left:none;width:110pt'><span style="color:red">*&nbsp;&nbsp;</span>法人身份证号
       </td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" required="required" id="idCard" name="idCard">
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>法人身份证
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div>
           <label title="上传法人身份证号" id="idCardAttachment" class="btn btn-primary btn-xs">
             上传
           </label>
         </div>
         <div id="idCardAttachmentDiv">

         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>注册地址
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" id="registAddress" name="registAddress">
         </div>
       </td>
       <td class=xl68 width=146 style='border-top:none;border-left:none;width:110pt'><span style="color:red">*&nbsp;&nbsp;</span>实际办公地址
       </td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" required="required" id="address" name="address">
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>成立日期
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" id="registDate" name="registDate" class="form-control layer-date" style="max-width: none"
                  required="required">
         </div>
       </td>
       <td class=xl68 width=146 style='border-top:none;border-left:none;width:110pt'><span style="color:red">*&nbsp;&nbsp;</span>企业规模
       </td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control-static" required="required" id="companyScale" name="companyScale">（人）
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;
  width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>所在地区
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <select class="form-control-static col-sm-4" name="firstRegion" id="firstRegion">
           </select>
           <select class="form-control-static col-sm-4" name="secondRegion" id="secondRegion">
           </select>
           <select class="form-control-static col-sm-4" name="locationRegion" id="locationRegion" required="required">
           </select>
         </div>
       </td>
       <td class=xl65 width=146 style='border-top:none;border-left:none;width:110pt'>企业官网</td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control" id="companyHomePage" name="companyHomePage">
         </div>
       </td>
     </tr>
     <tr height=24 style='height:18.0pt'>
       <td colspan=4 height=24 class=xl69 width=1047 style='height:18.0pt;
  width:786pt'>经营状况
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>业务地区
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div class="form-group" style="margin:0">
           <button type="button" class="btn btn-xs btn-primary" id="chooseServiceRegion">点击选择</button>
           <input type="hidden" placeholder="服务地区" required="required" id="serviceRegion"
                  name="serviceRegion">
           <input type="text" class="form-control" readonly="readonly" placeholder="服务地区" required="required"
                  id="serviceRegionName"
                  name="serviceRegionName">
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl68 width=120 style='height:15.75pt;border-top:none;width:90pt'><span style="color:red">*&nbsp;&nbsp;</span>主营业务
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
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

     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>年营业额
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control-static" id="businessVolume" name="businessVolume">（万元)
         </div>
       </td>
       <td class=xl65 width=146 style='border-top:none;border-left:none;width:110pt'>办公面积</td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control-static" id="companyArea" name="companyArea">（平方米)
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>销售人数
       </td>
       <td class=xl66 width=355 style='border-top:none;border-left:none;width:266pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control-static" id="salerNum" name="salerNum">（人）
         </div>
       </td>
       <td class=xl65 width=146 style='border-top:none;border-left:none;width:110pt'>业务人数</td>
       <td class=xl66 width=426 style='border-top:none;border-left:none;width:320pt'>
         <div class="form-group" style="margin:0">
           <input type="text" class="form-control-static" id="businessUsers" name="businessUsers">（人）
         </div>
       </td>
     </tr>
     <tr height=24 style='height:18.0pt'>
       <td colspan=4 height=24 class=xl69 width=1047 style='height:18.0pt;
  width:786pt'>产品信息
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>产品介绍
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div class="form-group" style="margin:0">
             <textarea class="form-control" rows="3" name="productIntroduction" id="productIntroduction"></textarea>
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>产品优势
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div class="form-group" style="margin:0">
             <textarea class="form-control" rows="3" name="productAdvantage" id="productAdvantage"></textarea>
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>其他说明
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div class="form-group" style="margin:0">
             <textarea class="form-control" rows="3" name="productOther" id="productOther"></textarea>
         </div>
       </td>
     </tr>
     <tr height=24 style='height:18.0pt'>
       <td colspan=4 height=24 class=xl69 width=1047 style='height:18.0pt;
  width:786pt'>其他信息
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>公司介绍
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div class="form-group" style="margin:0">
             <textarea class="form-control" rows="3" name="companyIntroduction" id="companyIntroduction"></textarea>
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>照片附件
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div>
           <label title="上传照片附件" id="attachment" class="btn btn-primary btn-xs">
             上传
           </label>
         </div>
         <div id="attachmentDiv">

         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td height=21 class=xl65 width=120 style='height:15.75pt;border-top:none;
  width:90pt'>备注说明
       </td>
       <td colspan=3 class=xl67 width=927 style='border-left:none;width:696pt'>
         <div class="form-group" style="margin:0">
             <textarea class="form-control" rows="3" name="remark" id="remark"></textarea>
         </div>
       </td>
     </tr>
     <tr height=21 style='height:15.75pt'>
       <td colspan=4 class=xl67 width=927 style='width:696pt'>
         <div class="form-group" style="margin:10px 0px">
           <input type="checkbox" checked id="user_protocol">
           <a href="https://www.he800.com/he800htv1.0.pdf" target="_blank">同意麦积财税平台合作协议（点击查看协议）</a>
         </div>
       </td>
     </tr>
     <tr height=110 style='height:82.5pt'>
       <td colspan=4 height=24 width=900 style='width:750pt'>
         <button type="button" id="submit" class="btn btn-lg btn-success">提交</button>
       </td>
     </tr>
   </table>
 </form>

<form id="attaForm" name="attaForm" method="post">
  <input type="file" style="display: none" dir="" id="file" name="file" enctype="multipart/form-data"
         accept="image/*"/>
</form>

<#--新增部门选择服务地区-->
<div class="modal" id="regionModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">选择地区</b>
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

</@htmlContent>
<script src="${ctx!}/admin/pub/js/common/org_register.js"></script>
<script src="${ctx!}/admin/pub/js/profession_mapping/save_region_tree.js"></script>
<script src="${ctx!}/admin/js/jquery.payload.js"></script>

<@htmlJs>


  <@fancytree/>
</@htmlJs>
