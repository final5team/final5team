<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <script type="text/javascript">
      // 시스템별 서비스 요청 비중 구하기
      google.charts.load("current", {packages:["corechart"]});
            
      // 도넛 그래프 그리기
      google.charts.setOnLoadCallback(drawdonutChart);
      function drawdonutChart() {
    	  // 지연율 그래프 값 설정
          var data2 = google.visualization.arrayToDataTable([
            ['Label', 	'Rate'],
            ['지연',     ${delRate}],
            ['',   		${100-delRate}]
          ]);
          
          // 그래프 옵션
          var options2 = {
            title: '시스템별 지연율',   // 그래프 제목
            pieHole: 0.4,		// 그래프 중앙 빈 부분 크기 설정

            tooltip: { trigger: 'none' },   // 도움말 제거   
            legend: 'none',					// 범례 여부(표시 안 함)
            slices: {
                0: { color: 'red', textStyle: {color: 'transparent'} },  			// 그래프 완료 부분 색 설정(미표시)
                1: { color: 'transparent' , textStyle: {color: 'transparent'}}		// 그래프 미완료 부분 색 설정(미표시)
            }
          };
          
          // 지연율 그래프 그리기
          var chart2 = new google.visualization.PieChart(document.getElementById('chart_div'));	
          chart2.draw(data2, options2);
                  
        }      		 
    </script>
    <div style="width:290px; height: 200px; overflow: hidden;" id="systemCom"> 
      	<div id="chart_div" style="height: 250px; position: relative; top: -10px;"></div>
		<div class="center">${delRate}%</div> 
    </div>	
    