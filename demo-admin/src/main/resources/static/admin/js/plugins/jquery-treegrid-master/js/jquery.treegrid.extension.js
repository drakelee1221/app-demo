(function ($) {
    "use strict";

    $.fn.treegridData = function (options, param) {
        //如果是调用方法
        if (typeof options == 'string') {
            return $.fn.treegridData.methods[options](this, param);
        }

        //如果是初始化组件
        options = $.extend({}, $.fn.treegridData.defaults, options || {});
        var target = $(this);
        // debugger;
        //得到根节点
        target.getRootNodes = function (data) {
            var result = [];
            $.each(data, function (index, item) {
                if (item[options.parentColumn]==null || item[options.parentColumn]==undefined || item[options.parentColumn] == '0' || item[options.parentColumn]=="") {
                    result.push(item);
                }
            });
            return result;
        };
        var j = 0;
        //递归获取子节点并且设置子节点
        target.getChildNodes = function (data, parentNode, parentIndex, tbody) {
            $.each(data, function (i, item) {
                if (item[options.parentColumn] == parentNode[options.id]) {
                    var tr = $('<tr></tr>');
                    var nowParentIndex = (parentIndex + (j++) + 1);
                    // tr.addClass('treegrid-' + nowParentIndex);
                    // tr.addClass('treegrid-parent-' + parentIndex);

                    
                    tr.addClass('treegrid-' + item[options.id]);
                    tr.addClass('treegrid-parent-' + parentNode[options.id]);
                    //子节点构造表体
                    $.each(options.columns, function (index, column) {
                        var td = $('<td></td>');
                        td.text(item[column.field]);
                        
                        //格式化内容
                        if(column.formatter!=undefined){
                        	td.html(column.formatter.call(item[column.field],item));
                        }
                        
                        tr.append(td);
                    });
                    tbody.append(tr);
                    target.getChildNodes(data, item, nowParentIndex, tbody)

                }
            });
        };
        target.addClass('table');
        if (options.striped) {
            target.addClass('table-striped');
        }
        if (options.bordered) {
            target.addClass('table-bordered');
        }
        if (options.url) {
            $.ajax({
                type: options.type,
                url: options.url,
                data: options.ajaxParams,
                dataType: "JSON",
                success: function (data, textStatus, jqXHR) {
                    // // var BstpTable = new BstpTable();
                    //初始化右侧表格
                	if(data.length == 0){
                		$("#btn_add").show();
                	}
                     window.data = data;
                     
                   //  window.BstpTable.obj = $("#tb_departments");
                     //window.BstpTable.inint({})
                    // debugger;
                    //构造表头
                    //console.log(data);
                    
                    var thr = $('<tr></tr>');
                    $.each(options.columns, function (i, item) {
                        var th = $('<th style="padding:10px;"></th>');
                        th.text(item.title);
                        thr.append(th);
                    });
                    var thead = $('<thead></thead>');
                    thead.append(thr);
                    target.append(thead);

                    //根节点构造表体
                    var tbody = $('<tbody></tbody>');
                    var rootNode = target.getRootNodes(data);
                    //console.log(target);
                    // console.log(rootNode + "rootNode")
                    $.each(rootNode, function (i, item) {
                        var tr = $('<tr></tr>');

                        tr.addClass('treegrid-' + item[options.id]);

                        $.each(options.columns, function (index, column) {
                        	//根节点构造表体
                            var td = $('<td></td>');
                            td.text(item[column.field]);
                            
                            //格式化内容
                            if(column.formatter!=undefined){
                            	td.html(column.formatter.call(item[column.field],item));
                            }
                            
                            tr.append(td);
                        });
                        tbody.append(tr);
                        target.getChildNodes(data, item, (j + i), tbody);
                    });
                    target.append(tbody);
                    target.treegrid({
                        expanderExpandedClass: options.expanderExpandedClass,
                        expanderCollapsedClass: options.expanderCollapsedClass
                    });
                    if (!options.expandAll) {
                        target.treegrid('collapseAll');
                    }
                    
                    options.onLoadSuccess(data);
                    
                    
                    
                }
            });
        }
        else {
            //也可以通过defaults里面的data属性通过传递一个数据集合进来对组件进行初始化....有兴趣可以自己实现，思路和上述类似
        }
        return target;
    };

    $.fn.treegridData.methods = {
        getAllNodes: function (target, data) {
            return target.treegrid('getAllNodes');
        },
        
        //组件的其他方法也可以进行类似封装........
    };

    $.fn.treegridData.defaults = {
        id: 'id',
        parentColumn: 'parentId',
        data: [],    //构造table的数据集合
        type: "GET", //请求数据的ajax类型
        url: null,   //请求数据的ajax的url
        ajaxParams: {}, //请求数据的ajax的data属性
        expandColumn: null,//在哪一列上面显示展开按钮
        expandAll: true,  //是否全部展开
        striped: false,   //是否各行渐变色
        bordered: false,  //是否显示边框
        columns: [],
        expanderExpandedClass: 'glyphicon glyphicon-chevron-down',//展开的按钮的图标
        expanderCollapsedClass: 'glyphicon glyphicon-chevron-right',//缩起的按钮的图标
        onLoadSuccess: function (data) {
            return false;
        },
        
        
        
    };
})(jQuery);