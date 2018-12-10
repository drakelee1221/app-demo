$(function () {
  $.get(ctx+"/admin/home/chart/data",function(res){
    $("#users").html(formatNumber(res.data.users));
    $("#orderAmount").html(formatNumber(res.data.orderAmount,2,',', true));
    $("#todayOrders").html(formatNumber(res.data.todayOrders));
    $("#todayAmount").html(formatNumber(res.data.todayAmount,2,',', true));
    $("#companies").html(formatNumber(res.data.companies));
    $("#todayRecharge").html(formatNumber(res.data.todayRecharge ,2));
  });

  var lineChart = echarts.init(document.getElementById("echarts-line-chart"));

  $.get(ctx + "/admin/home/chart/register", function (res) {
    var lineoption = {
      tooltip: {
        trigger: 'axis'
      },
      /*legend: {
        data:['最高气温']
      },*/
      grid: {
        x: 40,
        x2: 40,
        y2: 24
      },
      calculable: true,
      xAxis: [
        {
          type: 'category',
          boundaryGap: false,
          data: res.data.xAxis
        }
      ],
      yAxis: [
        {
          type: 'value',
          axisLabel: {
            formatter: '{value}'
          }
        }
      ],
      series: [
        {
          name: '注册人数',
          type: 'line',
          data: res.data.yAxis
        }
      ]
    };
    lineChart.setOption(lineoption);
    $(window).resize(lineChart.resize);
  });

  $.get(ctx+"/admin/home/chart/operationdata",function(res){
    $("#callme").html(formatNumber(res.data.callme));
    $("#complains").html(formatNumber(res.data.complains));
    $("#consults").html(formatNumber(res.data.consults));
    $("#notice").html(formatNumber(res.data.notice));
    $("#supply").html(formatNumber(res.data.supply));
    $("#demand").html(formatNumber(res.data.demand));
    $("#unorder").html(formatNumber(res.data.unorder));
  });

  $.get(ctx+"/admin/home/chart/logindata",function(res){
    $("#sevenDaysManager").html(formatNumber(res.data.sevenDaysManager));
    $("#fifteenDaysManager").html(formatNumber(res.data.fifteenDaysManager));
    $("#thirtyDaysManager").html(formatNumber(res.data.thirtyDaysManager));
    $("#fifteenDaysUser").html(formatNumber(res.data.fifteenDaysUser));
    $("#sevenDaysUser").html(formatNumber(res.data.sevenDaysUser));
    $("#thirtyDaysUser").html(formatNumber(res.data.thirtyDaysUser));
  });
});
