<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <script type="text/javascript">
      // 시스템별 서비스 요청 비중 구하기
      google.charts.load("current", {packages:["corechart"]});
            
      // 도넛 그래프 그리기
      google.charts.setOnLoadCallback(drawdonutChart);
      function drawdonutChart() {
    	  // 완료율 그래프 값 설정
          var data = google.visualization.arrayToDataTable([
            ['Label', 	'Rate'],
            ['완료',     ${comRate}],
            ['',   		${100-comRate}]
          ]);    	          
			
    	  // 그래프 옵션
          var options = {
            title: '시스템별 완료율',   // 그래프 제목
            pieHole: 0.4,		// 그래프 중앙 빈 부분 크기 설정

            tooltip: { trigger: 'none' },   // 도움말 제거   
            legend: 'none',					// 범례 여부(표시 안 함)
            slices: {
                0: { color: 'green', textStyle: {color: 'transparent'} },  			// 그래프 완료 부분 색 설정(미표시)
                1: { color: 'transparent' , textStyle: {color: 'transparent'}}		// 그래프 미완료 부분 색 설정(미표시)
            }
          };
		  
          // 완료율 그래프 그리기
          var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
          chart.draw(data, options);
                  
        }      		 
    </script>
    <div style="width:290px; height: 200px; overflow: hidden;" id="systemCom"> 
        <div id="donutchart" style="height: 250px; position: relative; top: -10px;"></div>	                                			                                			                                		   												
	    <div class="center">${comRate}%</div>
    </div>	
    