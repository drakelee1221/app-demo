<#include "/layout/pagelayout.ftl"/>

<@htmlContent>

  <div>字典数据</div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="m-b-sm" id="editDiv">
        <span class="label" style="color: red" id="dictName">未选择字典</span>
        - >
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
            <label for="searchDataName" class="sr-only">数据名称</label>
            <input type="text" placeholder="数据名称" name="searchDataName" id="searchDataName" class="form-control">
          </div>
          <div class="form-group">
            <label for="searchStatus" class="sr-only">状态</label>
            <div class="dictDiv" inputType="select" inputName="searchStatus" firstOption="全部" firstOptionValue="-1"
                 dictCode="status"></div>
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
  <div class="modal" id="dictionaryModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width: 65%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">关闭</span>
          </button>
          <h4 class="modal-title">
            <b id="modal_title">字典数据</b>
          </h4>
        </div>
        <div class="modal-body">
          <form class="panel-body form-horizontal" id="dictionary_form" name="dictionaryForm">
            <input type="hidden" class="form-control" name="id" id="id"/>
            <div class="form-group">
              <label for="dataName" class="control-label">数据名称：</label>
              <div>
                <input type="text" class="form-control" placeholder="数据名称" id="dataName" name="dataName"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="dataKey" class="control-label">数据key：</label>
              <div>
                <input type="text" class="form-control" placeholder="数据key" id="dataKey" name="dataKey"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="dataValue" class="control-label">数据value：</label>
              <div>
                <input type="text" class="form-control" placeholder="数据value" id="dataValue" name="dataValue"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="remarks" class="control-label">备注：</label>
              <div>
                <input type="text" class="form-control" placeholder="备注" id="remarks" name="remarks"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="status" class="control-label">状态：</label>
              <div class="dictDiv" inputType="select" inputName="status" inputRequired="required"
                   dictCode="status"></div>
            </div>

            <div class="form-group">
              <label for="orderNo" class="control-label">排序号：</label>
              <div>
                <input type="number" class="form-control" placeholder="排序号" id="orderNo" name="orderNo"
                       required="required"/>
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

</@htmlContent>

<@htmlJs>
  <script src="${ctx!}/admin/pub/js/sys/dictionary/data/index.js"></script>
  <script src="${ctx!}/admin/pub/js/sys/dictionary/data/util.js"></script>
  <script>
    dictUtil.initElement();
  </script>
  <@fancytree/>
</@htmlJs>