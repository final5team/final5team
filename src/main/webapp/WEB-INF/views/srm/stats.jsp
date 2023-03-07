<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      // 시스템별 서비스 요청 비중 구하기
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
    	// 시스템별 서비스 요청 값 설정  
        var data = google.visualization.arrayToDataTable([
          ['System', 'Number'],
          ['${systemSlice[0].systemName}',     ${systemSlice[0].sno}],
          ['${systemSlice[1].systemName}',     ${systemSlice[1].sno}],
          ['${systemSlice[2].systemName}',     ${systemSlice[2].sno}],
          ['${systemSlice[3].systemName}',     ${systemSlice[3].sno}]
        ]);
		
    	// 그래프 옵션
        var options = {
          title: '전체 서비스 요청 중 시스템별 비중'   // 그래프 제목
        };
        
		//그래프 그리기
        var chart = new google.visualization.PieChart(document.getElementById('3dchart'));
        chart.draw(data, options);
      }
      
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
            title: '전체 완료율',   // 그래프 제목
            pieHole: 0.4,		// 그래프 중앙 빈 부분 크기 설정

            tooltip: { trigger: 'none' },   // 도움말 제거   
            legend: 'none',					// 범례 여부(표시 안 함)
            slices: {
                0: { color: '#4ae095', textStyle: {color: 'transparent'} },  			// 그래프 완료 부분 색 설정(초록, 글자 미표시)
                1: { color: '#d4d4d4' , textStyle: {color: 'transparent'}}				// 그래프 미완료 부분 색 설정(회색, 글자 미표시)
            }
          };
		  
          // 완료율 그래프 그리기
          var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
          chart.draw(data, options);
          
          // 지연율 그래프 값 설정
          var data2 = google.visualization.arrayToDataTable([
            ['Label', 	'Rate'],
            ['지연',     ${delRate}],
            ['',   		${100-delRate}]
          ]);
          
          // 그래프 옵션
          var options2 = {
            title: '전체 지연율',   // 그래프 제목
            pieHole: 0.4,		// 그래프 중앙 빈 부분 크기 설정

            tooltip: { trigger: 'none' },   // 도움말 제거   
            legend: 'none',					// 범례 여부(표시 안 함)
            slices: {
                0: { color: '#fa6666', textStyle: {color: 'transparent'} },  			// 그래프 지연 부분 색 설정(빨강, 글자 미표시)
                1: { color: '#d4d4d4' , textStyle: {color: 'transparent'}}				// 그래프 미지연 부분 색 설정(회색, 글자 미표시)
            }
          };
          
          // 지연율 그래프 그리기
          var chart2 = new google.visualization.PieChart(document.getElementById('chart_div'));	
          chart2.draw(data2, options2);
        }      		 
      
      	  // 서비스 요청 처리 현황 비중 막대 그래프 그리기
	      google.charts.load('current', {'packages':['bar']});
	      google.charts.setOnLoadCallback(drawBarChart);
	
	      function drawBarChart() {
	    	  var data = google.visualization.arrayToDataTable([
	    	        ['', '접수중', '개발중', '테스트중', '유저테스트중',
	    	         '배포중', '완료' ],
	    	        ['요청', ${allState[0]}/${allState[6]}, ${allState[1]}/${allState[6]}, ${allState[2]}/${allState[6]}, 
	    	        	${allState[3]}/${allState[6]}, ${allState[4]}/${allState[6]}, ${allState[5]}/${allState[6]}]	    	      
	    	      ]);

	    	  // 그래프 옵션
	    	  var options = {	    	   		
	    	        height: 100,					// 그래프 높이
	    	        hAxis: {	 					// 그래프 가로축  설정	        	  
	    	        	  textStyle: {				// 그래프 글자 색
		    	        	    color: 'white'
		    	          },
	    	        	  format: 'percent',		// 그래프 비중 출력 형식(퍼센테이지)
	    	        	  baselineColor: 'white',	// 그래프 기본 축 색
	    	        	  gridlines: {				// 그래프 눈금 색
		    	        	    color: 'white'
	    	        	  }
	    	        	},
	    	        legend: {position: 'none' },	// 범례 여부(표시 안 함)
	    	        bar: { groupWidth: '100%' },	// 막대 그룹 너비(그룹 사이에 공백 없음)
	    	        bars: 'horizontal',				// 그래프 표시 형식(가로 막대)
	    	        isStacked: true					// 그래프 표시 형식(누적 여부: 누적 표시)

	    	      };
	
	    	// 그래프 그리기
	        var chart = new google.charts.Bar(document.getElementById('barchart_material'));	
	        chart.draw(data, google.charts.Bar.convertOptions(options));
	      }
	      
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
    <script>
    // 시스템별 완료율 보여주기
    function searchComSys(){
    	$.ajax({
			type: "GET", 							// 요청방식: GET
			url:"${pageContext.request.contextPath}/stats/comrate/"+$("#searchSystem").val(),		//URL+선택한 시스템 번호
			dataType:"html", 						// 데이터 타입: html
			success : function(result){
				$('#systemCom').html(result);		// 시스템별 완료율 그래프와 수치 	재출력	
			}
		});
    }
    
    // 시스템별 지연율 보여주기
    function searchDelSys(){
    	$.ajax({
			type: "GET", 							// 요청방식: GET
			url:"${pageContext.request.contextPath}/stats/delrate/"+$("#searchSysDel").val(),		//URL+선택한 시스템 번호
			dataType:"html", 						// 데이터 타입: html
			success : function(result){
				$('#systemDel').html(result);		// 시스템별 지연율 그래프와 수치 	재출력	
			}
		});
    }
    
    // 분기별 서비스 요청 추이 보여주기
    function searchCurve(){
    	$.ajax({
			type: "GET", 							// 요청방식: GET
			url:"${pageContext.request.contextPath}/stats/curve/"+$("#curveMonth").val(),		//URL+선택한 날짜(월)
			dataType:"html", 						// 데이터 타입: html
			success : function(result){
				$('#curveReq').html(result);		// 분기별 서비스 요청 추이 그래프와 수치 	재출력	
			}
		});
    }
    </script>
    
    <style>
    .nav.nav-tabs-bordered, .nav.tab-content {
	    border-style: solid;
	    border-width: 0 0 1px 0;
	    border-color: #85CE36;
	    padding: 10px 20px 0;
	}
	.center {
	  position: absolute;
	  top: 70%;
	  right: 70px;
	  width: 100%;
	  text-align: center;
	  font-size: 50px;
	  font-weight: bold;
	  color: orange;	 
	}
		
    </style>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
		
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
                <!-- End of Topbar -->

                <!-- 여기에 내용 담기 start -->
                <div class="container">  
                	<!-- Main(정적 페이지) -->             	
                	<div id="main">
	                	<!-- 첫째 줄 -->
						<div class="row">
							<div  class="col">
								 <div class="card shadow mb-4">
	                                <!-- Card Header - Dropdown -->
	                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                                    <h6 class="m-0 font-weight-bold text-primary">시스템별 요청 비중</h6>	                                    
	                                </div>
	                                <!-- Card Body -->
	                                <div class="card-body" style="width:300px; overflow: hidden;">
	                                    <div id="3dchart" style="width:400px; position: relative; left:-30px"></div>
	                                </div>
	                            </div>
							</div>
							<div  class="col">
								 <div class="card shadow mb-4">
	                                <!-- Card Header - Dropdown -->
	                                <div
	                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                                    <h6 class="m-0 font-weight-bold text-primary">완료율</h6>
	                                    <div class="dropdown no-arrow">	                                    	
											<select class="dropdown-toggle ml-4" data-toggle="dropdown" style="border-color: transparent; background-color: #F8F9FC; color: #60ADFF" name="searchSystem" id="searchSystem" onchange="searchComSys()">															
												<option value="0" class="text-center">전체</option>												   												   
												<c:forEach var="system" items="${systemList}">
													<option value="${system.sno}" class="text-center">${system.systemName}</option>
												</c:forEach>																																																			
											</select>	                                       	                                       
	                                    </div>
	                                </div>
	                                <!-- Card Body -->
	                                <div class="card-body">		                               
	                                	<div style="width:290px; height: 200px; overflow: hidden;" id="systemCom"> 	                                	
	                                		<div id="donutchart" style="height: 230px; position: relative; top: -10px;"></div>	                                			                                			                                		   												
	                                		<div class="center">${comRate}%</div>
	                                	</div>		                                		                               
	                                </div>
	                            </div>
							</div>
							<div  class="col">
								 <div class="card shadow mb-4">
	                                <!-- Card Header - Dropdown -->
	                                <div
	                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                                    <h6 class="m-0 font-weight-bold text-primary">지연율</h6>
	                                    <div class="dropdown no-arrow">	                                    	
											<select class="dropdown-toggle ml-4" data-toggle="dropdown" style="border-color: transparent; background-color: #F8F9FC; color: #60ADFF" name="searchSysDel" id="searchSysDel" onchange="searchDelSys()">															
												<option value="0" class="text-center">전체</option>												   												   
												<c:forEach var="system" items="${systemList}">
													<option value="${system.sno}" class="text-center">${system.systemName}</option>
												</c:forEach>																																																			
											</select>	                                       	                                       
	                                    </div>
	                                </div>
	                                <!-- Card Body -->
	                                <div class="card-body">
	                                	<div style="width:290px; height: 200px; overflow: hidden;" id="systemDel">		                                	
		                                	<div id="chart_div" style="height: 230px; position: relative; top: -10px;"></div>
		                                	<div class="center">${delRate}%</div> 
		                                </div>                                  
	                                </div>
	                            </div>
							</div>
						
						</div>
						
						<!-- 둘째줄 -->
						<div>										
							<!-- 예시 -->
							<div class="card sameheight-item shadow mb-4">
							    <div class="card-block">
							        <!-- Nav tabs -->
							        <div class="card-title-block">
										<h3 class="title ml-3 mt-3">
											서비스 요청 처리 현황
										</h3>
									</div>
									<!-- 태스크 별 탭 -->
							        <ul class="nav nav-tabs nav-tabs-bordered">
							            <li class="nav-item">
							            	<a href="#home" class="nav-link active" data-target="#home" data-toggle="tab" aria-controls="home" role="tab" >전체</a>
							            </li>
							            <li class="nav-item">
							            	<a href="#profile" class="nav-link" data-target="#profile" aria-controls="profile" data-toggle="tab" role="tab" >개발</a>
							            </li>
							            <li class="nav-item">
							            	<a href="" class="nav-link" data-target="#messages" aria-controls="messages" data-toggle="tab" role="tab" >테스트</a>
							            </li>
							            <li class="nav-item">
							            	<a href="" class="nav-link" data-target="#usertest" aria-controls="usertest" data-toggle="tab" role="tab" >품질  검토</a>
							            </li>
							            <li class="nav-item">
							            	<a href="" class="nav-link" data-target="#settings" aria-controls="settings" data-toggle="tab" role="tab" >배포</a>
							            </li>
							        </ul>
							
							        <!-- Tab panes -->
							        <div class="tab-content tabs-bordered">
							        	<!-- 전체 서비스 요청 처리 현황 -->
							        	
							            <div class="tab-pane in active" id="home"> 
							            
							            <div>
							        		<div class="m-3">
							        			<h5>전체 서비스 요청 처리 현황</h5>
							        			 <!-- 단계 카드들 -->
												<div class="row">
	
												    <div class="mb-4 m-2 ml-4">
										                <div class="card border-left-primary shadow h-100 py-2" style="width:140px">
										                     <div class="card-body">
										                          <div class="row no-gutters align-items-center">
										                               <div class="col mr-2">
										                                    <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">접수</div>
										                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${allState[0]} 건</div>
										                               </div>
										                               <div class="col-auto">
										                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
										                               </div>
										                           </div>
										                        </div>
										                  </div>
										             </div>
										                        
										             <div class="mb-4 m-2">
										                 <div class="card border-left-success shadow h-100 py-2" style="width:140px">
										                     <div class="card-body">
										                          <div class="row no-gutters align-items-center">
										                              <div class="col mr-2">
										                                  <div class="text-sm font-weight-bold text-success text-uppercase mb-1">개발</div>
										                                  <div class="h5 mb-0 font-weight-bold text-gray-800">${allState[1]} 건</div>
										                              </div>
										                          	  <div class="col-auto">
										                                  <i class="fas fa-pen fa-2x text-gray-300"></i>
										                              </div>
										                          </div>
										                      </div>
										                  </div>
										              </div>
										
										              <div class="mb-4 m-2">
										                   <div class="card border-left-info shadow h-100 py-2" style="width:140px">
										                        <div class="card-body">
										                             <div class="row no-gutters align-items-center">
										                                  <div class="col mr-2">
										                                      <div class="text-sm font-weight-bold text-info text-uppercase mb-1">테스트 </div>									                                   									                                                
										                                      <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${allState[2]} 건</div>									                                                							                                                									                                          
										                                  </div>
										                                   <div class="col-auto">
										                                       <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
										                                   </div>
										                                </div>
										                            </div>
										                       </div>
										                 </div>
								
								                        <div class="mb-4 m-2">
								                            <div class="card border-left-warning shadow h-100 py-2" style="width:150px">
								                                <div class="card-body">
								                                    <div class="row no-gutters align-items-center">
								                                        <div class="col mr-2">
								                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">품질 검토</div>
								                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${allState[3]} 건</div>
								                                        </div>
								                                        <div class="col-auto">
								                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
								                        </div>
										                        
								                        <div class="mb-4 m-2">
								                            <div class="card border-left-danger shadow h-100 py-2" style="width:140px">
								                                <div class="card-body">
								                                    <div class="row no-gutters align-items-center">
								                                        <div class="col mr-2">
								                                            <div class="text-sm font-weight-bold text-danger text-uppercase mb-1">배포</div>
								                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${allState[4]} 건</div>
								                                        </div>
								                                        <div class="col-auto">
								                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
								                        </div>
								                        
								                        <div class="mb-4 m-2">
								                            <div class="card border-left-secondary shadow h-100 py-2" style="width:140px">
								                                <div class="card-body">
								                                    <div class="row no-gutters align-items-center">
								                                        <div class="col mr-2">
								                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">완료</div>
								                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${allState[5]} 건</div>
								                                        </div>
								                                        <div class="col-auto">
								                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
								                        </div>
	       
												  </div>
							        		
							        		</div>
							        		<div>
							        			<div id="barchart_material"></div>
							        		</div>
							        								        	
							        	</div>
							            
							            
							            
							            </div>
							            <div class="tab-pane fade" id="profile">
							            	<div class="m-3">
							            		<h5>개발 현황</h5>
							            		<div>
								            		<!-- 단계 카드들 -->
													<div class="row">															   
											                        
											             <div class="col mb-4">
											                 <div class="card border-left-success shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                              <div class="col mr-2">
											                                  <div class="text-sm font-weight-bold text-success text-uppercase mb-1">개발 대기</div>
											                                  <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[0][0]-stateTask[0][1]} 건 </div>
											                              </div>
											                          	  <div class="col-auto">
											                                  <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
											                              </div>
											                          </div>
											                      </div>
											                  </div>
											              </div>
	
									                        <div class="col mb-4">
									                            <div class="card border-left-warning shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">개발 중</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[0][1]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
									                        
									                        <div class="col mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">개발 완료</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[0][2]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
		       
													  </div>
							            		</div>
							            	</div>
							             
							            </div>
							            <div class="tab-pane fade" id="messages">
							                <div class="m-3">
							            		<h5>테스트 현황</h5>
							            		<div>
								            		<!-- 단계 카드들 -->
													<div class="row">														   
											                        
											             <div class="col mb-4">
											                 <div class="card border-left-success shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                              <div class="col mr-2">
											                                  <div class="text-sm font-weight-bold text-success text-uppercase mb-1">테스트 대기</div>
											                                  <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[1][0]-stateTask[1][1]} 건</div>
											                              </div>
											                          	  <div class="col-auto">
											                                  <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
											                              </div>
											                          </div>
											                      </div>
											                  </div>
											              </div>
	
									                        <div class="col mb-4">
									                            <div class="card border-left-warning shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">테스트 중</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[1][1]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
									                        
									                        <div class="col mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">테스트 완료</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[1][2]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
		       
													  </div>
							            		</div>
							            	</div>
							            </div>
							             <div class="tab-pane fade" id="usertest">
							                <div class="m-3">
							            		<h5>품질 검토 현황</h5>
							            		<div>
								            		<!-- 단계 카드들 -->
													<div class="row">		
													     
											             <div class="col mb-4">
											                 <div class="card border-left-success shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                              <div class="col mr-2">
											                                  <div class="text-sm font-weight-bold text-success text-uppercase mb-1">검토 대기</div>
											                                  <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[2][0]-stateTask[2][1]} 건</div>
											                              </div>
											                          	  <div class="col-auto">
											                                  <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
											                              </div>
											                          </div>
											                      </div>
											                  </div>
											              </div>
	
									                        <div class="col mb-4">
									                            <div class="card border-left-warning shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">검토 중</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[2][1]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
									                        
									                        <div class="col mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">검토 완료</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[2][2]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
		       
													  </div>
							            		</div>
							            	</div>
							            </div>
							            <div class="tab-pane fade" id="settings">
							              <div class="m-3">
							            		<h5>배포 현황</h5>
							            		<div>
								            		<!-- 단계 카드들 -->
													<div class="row">		
													      
											             <div class="col mb-4">
											                 <div class="card border-left-success shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                              <div class="col mr-2">
											                                  <div class="text-sm font-weight-bold text-success text-uppercase mb-1">배포 대기</div>
											                                  <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[3][0]-stateTask[3][1]} 건</div>
											                              </div>
											                          	  <div class="col-auto">
											                                  <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
											                              </div>
											                          </div>
											                      </div>
											                  </div>
											              </div>
	
									                        <div class="col mb-4">
									                            <div class="card border-left-warning shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">배포 중</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[3][1]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
									                        
									                        <div class="col mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">배포 완료</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[3][2]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
		       
													  </div>
							            		</div>
							            	</div>
							            </div>
							        </div>
							    </div>
							    <!-- /.card-block -->
							</div>
							<!-- /.card -->
							<!-- 예시 -->										
						</div>
						
						<!-- 셋째 줄 -->
						<div>
	
							<div class="card sameheight-item shadow mb-4">
							    <div class="card-block">
							        <!-- Nav tabs -->
							        <div class="card-title-block row">
										<div class="col">
											<h3 class="title ml-3 mt-3">
												서비스 요청 추이
											</h3>
										</div>
										<div class="col text-right">
											<label> 시작 날짜 : </label>
											<input type="month" id="curveMonth" step=3 onchange="searchCurve()">
										</div>
									</div>
							        <div class="tab-content tabs-bordered">
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
							        </div>
								</div>
							</div>
	
						</div>
									
					</div>
					<!-- end of Main -->
                </div>
                <!-- 여기에 내용 담기 end -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

</body>

</html>
