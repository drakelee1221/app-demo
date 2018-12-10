<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="panel panel-default">
  <div class="panel-heading">
    <div class="m-b-sm">
      <button onclick="pi.addOrEdit('add')" type="button" class="btn btn-info">
        <i class="fa fa-plus"></i>
        新增
      </button>
      <button onclick="pi.addOrEdit('edit')" type="button" class="btn btn-warning">
        <i class="fa fa-edit"></i>
        编辑
      </button>
      <button onclick="pi.delete()" type="button" class="btn btn-danger">
        <i class="fa fa-remove"></i>
        删除
      </button>
    </div>
    <form id="search_form" name="searchForm">
      <div class="form-inline">
        <div class="form-group">
          <label for="searchTplName" class="sr-only">模板名称</label>
          <input type="text" placeholder="模板名称" name="searchTplName" id="searchTplName" class="form-control">
        </div>
        <div class="form-group">
          <label for="searchTypeName" class="sr-only">模板类型</label>
          <select id="searchTypeName" name="searchTypeName" class="form-control">
            <option value="">全部类型</option>
            <#list templateTypes as type>
              <option value="${type}">${type}</option>
            </#list>
          </select>
        </div>
        <div class="form-group">
          <label for="searchContent" class="sr-only">内容</label>
          <input type="text" placeholder="内容" name="searchContent" id="searchContent" class="form-control">
        </div>
        <div class="form-group">
          <label for="searchStatus" class="sr-only">状态</label>
          <select id="searchStatus" name="searchStatus" class="form-control">
            <option value="-1">全部状态</option>
            <option value="0">已审核</option>
            <option value="1">未审核</option>
          </select>
        </div>
        <button type="button" class="btn btn-primary" onclick="pi.search()"><i class="fa fa-search"></i>查询</button>
        <button type="button" class="btn btn-white" onclick="pi.clearCondition()"><i class="fa fa-recycle"></i>清空条件
        </button>
      </div>
    </form>
  </div>
  <div class="panel-body">
    <table id="table_list"></table>
  </div>
</div>
  <div class="modal" id="templateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width: 65%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">关闭</span>
          </button>
          <h4 class="modal-title">
            <b id="modal_title">短信模板</b>
          </h4>
        </div>
        <div class="modal-body">
          <form class="panel-body form-horizontal" id="template_form" name = "templateForm">
            <input type="hidden" class="form-control" name="id" id="id"/>
            <div class="form-group">
              <label for="tplName" class="control-label">模板名称：</label>
              <div>
                <input type="text" class="form-control" placeholder="模板名称" id="tplName" name="tplName"
                       required="required"/>
              </div>
            </div>
            <div class="form-group">
              <label for="typeName" class="control-label">类型名称：</label>
              <div>
                <select id="typeName" name="typeName" class="form-control" placeholder="类型名称" required="required">
                  <#list templateTypes as type>
                    <option value="${type}">${type}</option>
                  </#list>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label for="content" class="control-label">内容：</label>
              <button type="button" class="btn btn-xs btn-primary" style="margin-bottom: 5px" id="addParamBtn">添加参数
              </button><font>将添加到光标所在位置，并自动$通配处理</font>
                <#list paramMap?keys as key1>
                  <div>
                    <font>${key1}属性常用参数：</font>
                    <#list paramMap[key1] as paramList>
                      <#list paramList?keys as key2>
                      <button style="margin-bottom: 5px;" type="button" class="btn btn-default btn-xs paramClick" data-type="${key1}" data="${key2}">${paramList[key2]}</button>
                      </#list>
                    </#list>
                   </div>
                </#list>
              <div>
                <textarea required="required" class="form-control" name="content" id="content" rows="4"></textarea>
              </div>
            </div>
            <div class="form-group">
              <label for="param" class="control-label">内容中的参数：</label>
              <button type="button" class="btn btn-xs btn-primary" style="margin-bottom: 5px" onclick="refreshParam()">刷新参数</button>
              <div>
                <table id="paramTab">

                </table>
              </div>
            </div>
            <div class="form-group">
              <label for="aliSmsId" class="control-label">阿里短信id：</label>
              <div>
                <input type="text" class="form-control" placeholder="阿里短信id" id="aliSmsId" name="aliSmsId"/>
              </div>
            </div>
            <div class="form-group">
              <label for="status" class="control-label">状态：</label>
              <div>
                <select id="status" name="status" class="form-control" placeholder="状态" required="required">
                  <option value="0">未审核</option>
                  <option value="1">已审核</option>
                </select>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="dealSaveBtn" onclick="pi.dealSave()"><i
            class="fa fa-save"></i>提交
          </button>
          <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
        </div>
      </div>
    </div>
  </div>

<#--模板参数-->
<div class="modal" id="paramModal" tabindex="-2" role="dialog" aria-hidden="true">
  <div class="modal-dialog" style="width: 50%;margin-top: 10%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">模板参数</b>
        </h4>
      </div>
      <div class="modal-body">
        <div>
          <table>
            <tr>
              <td>参数：</td>
              <td>
                <input type="text" class="form-control" id="param_code"/>
              </td>
              <td>名称：</td>
              <td>
                <input type="text" class="form-control" id="param_name"/>
              </td>
              <td>参数类型：</td>
              <td>
                <select id="param_type" class="form-control" disabled="disabled">
                  <option value="0">自动</option>
                  <option value="1" selected>手动</option>
                </select>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="confirmParam">确定
        </button>
        <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>
<#--/模板参数-->

</@htmlContent>

<@htmlJs>
  <script src="${ctx!}/admin/pub/js/operation/sms/template/index.js"></script>

  <@fancytree/>
</@htmlJs>