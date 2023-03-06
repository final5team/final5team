<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <script type="text/javascript">
      // 시스템별 서비스 요청 추이 구하기
      google.charts.load("current", {packages:["corechart"]});
            
      // 서비스 요청 추이 꺾은 선 그래프 그리기
      google.charts.setOnLoadCallback(drawLineChart);

      function drawLineChart() {
    	  // 월별 값 설정
        var data = google.visualization.arrayToDataTable([
          ['월', '${systemList[0].systemName}', '${systemList[1].systemName}', '${systemList[2].systemName}', '${systemList[3].systemName}'],
          ['${SRChangeMonth}월',  ${SRChange[0][0]}, ${SRChange[1][0]},  ${SRChange[2][0]},  ${SRChange[3][0]}],
          ['${SRChangeMonth+1}월',  ${SRChange[0][1]}, ${SRChange[1][1]},  ${SRChange[2][1]},  ${SRChange[3][1]}],
          ['${SRChangeMonth+2}월',  ${SRChange[0][2]}, ${SRChange[1][2]},  ${SRChange[2][2]},  ${SRChange[3][2]}]	         
        ]);

    	// 그래프 옵션
        var options = {
          title: '분기별 서비스 요청 추이',  			//그래프 제목
          curveType: 'function',  				//그래프 선 설정(부드러운 선)
          legend: { position: 'bottom' }   		//범례 위치 (하단 위치)
        };
        
		// 그래프 그리기
        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
        chart.draw(data, options);
                  
        }      		 
    </script>
    <div class="m-3" id="curveReq">
     	<div id="curve_chart"></div>	
     	<div class="text-center">
     		<h5>
	     		<c:if test="${SRChangeMonth==1}">1</c:if>
	     		<c:if test="${SRChangeMonth==4}">2</c:if>
	     		<c:if test="${SRChangeMonth==7}">3</c:if>
	     		<c:if test="${SRChangeMonth==10}">4</c:if>
     			분기
     		</h5>
     	</div>					        		
    </div>	
    