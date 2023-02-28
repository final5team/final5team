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
          title: '전체 서비스 요청 중 시스템별 비중',   // 그래프 제목
          is3D: true						// 그래프 형식(3D 그래프)
        };
        
		//그래프 그리기
        var chart = new google.visualization.PieChart(document.getElementById('3dchart'));
        chart.draw(data, options);
      }
      
      // 완료율 도넛 그래프 그리기
      google.charts.setOnLoadCallback(drawdonutChart);
      function drawdonutChart() {
    	  // 완료율 그래프 값 설정
          var data = google.visualization.arrayToDataTable([
            ['Task', 	'Rate'],
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
                0: { color: 'green', textStyle: {color: 'transparent'} },  			// 그래프 완료 부분 색 설정(미표시)
                1: { color: 'transparent' , textStyle: {color: 'transparent'}}		// 그래프 미완료 부분 색 설정(미표시)
            }
          };
		  
          // 그래프 그리기
          var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
          chart.draw(data, options);
        }
      
		  // 지연율 게이지 그래프 그리기
	      google.charts.load('current', {'packages':['gauge']});
	      google.charts.setOnLoadCallback(drawGageChart);
	
	      function drawGageChart() {
	
	        var data = google.visualization.arrayToDataTable([
	          ['Label', 'Value'],
	          ['지연율', ${delRate}],
	        ]);
			
	        // 그래프 옵션
	        var options = {
	          width: 500, height: 150,			// 그래프 크기 설정
	          redFrom: 80, redTo: 100,			// 위험 (붉은 색으로 표시된 부분) 범위 설정
	          yellowFrom: 55, yellowTo: 80,		// 주의 (노란 색으로 표시된 부분) 범위 설정
	          minorTicks: 5						// 보조 눈금
	        };
	        
			// 그래프 그리기
	        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));	
	        chart.draw(data, options);           
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
	          ['월', '요청', '완료'],
	          ['01월',  ${SRChange['1']},	${SRComChange['1']}],
	          ['02월',  ${SRChange['2']},	${SRComChange['2']}],
	          ['03월',  ${SRChange['3']},	${SRComChange['3']}],
	          ['04월',  ${SRChange['4']},	${SRComChange['4']}],
	          ['05월',  ${SRChange['5']},	${SRComChange['5']}],
	          ['06월',  ${SRChange['6']},	${SRComChange['6']}],
	          ['07월',  ${SRChange['7']},	${SRComChange['7']}],
	          ['08월',  ${SRChange['8']},	${SRComChange['8']}],
	          ['09월',  ${SRChange['9']},	${SRComChange['9']}],
	          ['10월',  ${SRChange['10']},	${SRComChange['10']}],
	          ['11월',  ${SRChange['11']},	${SRComChange['11']}],
	          ['12월',  ${SRChange['12']},	${SRComChange['12']}]
	        ]);

	    	// 그래프 옵션
	        var options = {
	          title: '전체 서비스 요청 및 완료',  		//그래프 제목
	          curveType: 'function',  			//그래프 선 설정(부드러운 선)
	          legend: { position: 'bottom' }    //범례 위치 (하단 위치)
	        };
	        
			// 그래프 그리기
	        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
	        chart.draw(data, options);
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
	  top: 40%;
	  width: 100%;
	  text-align: center;
	  font-size: 20px;
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
                	<div id="main">
	                	<!-- 첫째 줄 -->
						<div class="row">
							<div  class="col-lg-4">
								 <div class="card shadow mb-4">
	                                <!-- Card Header - Dropdown -->
	                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                                    <h6 class="m-0 font-weight-bold text-primary">시스템별 요청 비중</h6>
	                                    <div class="dropdown no-arrow">
	                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
	                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
	                                        </a>
	                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
	                                            aria-labelledby="dropdownMenuLink">
	                                            <div class="dropdown-header">Dropdown Header:</div>
	                                            <a class="dropdown-item" href="#">Action</a>
	                                            <a class="dropdown-item" href="#">Another action</a>
	                                            <div class="dropdown-divider"></div>
	                                            <a class="dropdown-item" href="#">Something else here</a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- Card Body -->
	                                <div class="card-body">
	                                    <div id="3dchart"></div>
	                                </div>
	                            </div>
							</div>
							<div  class="col-lg-4">
								 <div class="card shadow mb-4">
	                                <!-- Card Header - Dropdown -->
	                                <div
	                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                                    <h6 class="m-0 font-weight-bold text-primary">완료율</h6>
	                                    <div class="dropdown no-arrow">
	                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
	                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
	                                        </a>
	                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
	                                            aria-labelledby="dropdownMenuLink">
	                                            <div class="dropdown-header">Dropdown Header:</div>
	                                            <a class="dropdown-item" href="#">Action</a>
	                                            <a class="dropdown-item" href="#">Another action</a>
	                                            <div class="dropdown-divider"></div>
	                                            <a class="dropdown-item" href="#">Something else here</a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- Card Body -->
	                                <div class="card-body">
		                                <div class="row">
		                                	<div class="col-md-7"> 
		                                		<div id="donutchart"></div>
		                                		<div class="center">${comRate}%</div>
		                                	</div>
		                                	<div class="col-md-5">
		                                		<p style="color: green">Task</p>
			                                	<p>개발: ${comRateTask['developer']}%</p>
			                                	<p>테스트: ${comRateTask['tester']}%</p>
			                                	<p>유저: ${comRateTask['usertester']}%</p>
			                                	<p>배포: ${comRateTask['distributor']}%</p>
		                                	</div>
		                                </div>
	                                </div>
	                            </div>
							</div>
							<div  class="col-lg-4">
								 <div class="card shadow mb-4">
	                                <!-- Card Header - Dropdown -->
	                                <div
	                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                                    <h6 class="m-0 font-weight-bold text-primary">지연율</h6>
	                                    <div class="dropdown no-arrow">
	                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
	                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
	                                        </a>
	                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
	                                            aria-labelledby="dropdownMenuLink">
	                                            <div class="dropdown-header">Dropdown Header:</div>
	                                            <a class="dropdown-item" href="#">Action</a>
	                                            <a class="dropdown-item" href="#">Another action</a>
	                                            <div class="dropdown-divider"></div>
	                                            <a class="dropdown-item" href="#">Something else here</a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- Card Body -->
	                                <div class="card-body" style="height:240px">
	                                	<div class="row">
		                                	<div class="col-md-7"> 
		                                		<div id="chart_div" style="width: 400px; height: 120px;" class="ml-4 mt-3"></div> 
		                                	</div>
		                                	<div class="col-md-5">
		                                		<p style="color: green">Task</p>
			                                	<p>개발: ${delRateTask['developer']}%</p>
			                                	<p>테스트: ${delRateTask['tester']}%</p>
			                                	<p>유저: ${delRateTask['usertester']}%</p>
			                                	<p>배포: ${delRateTask['distributor']}%</p>
		                                	</div>
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
							            	<a href="" class="nav-link" data-target="#usertest" aria-controls="usertest" data-toggle="tab" role="tab" >유저테스트</a>
							            </li>
							            <li class="nav-item">
							            	<a href="" class="nav-link" data-target="#settings" aria-controls="settings" data-toggle="tab" role="tab" >배포</a>
							            </li>
							        </ul>
							
							        <!-- Tab panes -->
							        <div class="tab-content tabs-bordered">
							        	<!-- 전체 서비스 요청 처리 현황 -->
							        	<div>
							        		<div class="m-3">
							        			<h5>전체 서비스 요청 처리 현황</h5>
							        			 <!-- 단계 카드들 -->
												<div class="row">
	
												    <div class="col-xl-2 col-md-6 mb-4">
										                <div class="card border-left-primary shadow h-100 py-2">
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
										                        
										             <div class="col-xl-2 col-md-6 mb-4">
										                 <div class="card border-left-success shadow h-100 py-2">
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
										
										              <div class="col-xl-2 col-md-6 mb-4">
										                   <div class="card border-left-info shadow h-100 py-2">
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
								
								                        <div class="col-xl-2 col-md-6 mb-4">
								                            <div class="card border-left-warning shadow h-100 py-2">
								                                <div class="card-body">
								                                    <div class="row no-gutters align-items-center">
								                                        <div class="col mr-2">
								                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">유저 테스트</div>
								                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${allState[3]} 건</div>
								                                        </div>
								                                        <div class="col-auto">
								                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
								                        </div>
										                        
								                        <div class="col-xl-2 col-md-6 mb-4">
								                            <div class="card border-left-danger shadow h-100 py-2">
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
								                        
								                        <div class="col-xl-2 col-md-6 mb-4">
								                            <div class="card border-left-secondary shadow h-100 py-2">
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
							            <div class="tab-pane fade in active" id="home"> 
							            </div>
							            <div class="tab-pane fade" id="profile">
							            	<div class="m-3">
							            		<h5>개발 현황</h5>
							            		<div>
								            		<!-- 단계 카드들 -->
													<div class="row">
		
													    <div class="col-xl-3 col-md-6 mb-4">
											                <div class="card border-bottom-primary shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                               <div class="col mr-2">
											                                    <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">현재</div>
											                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[0][0]} 건</div>
											                               </div>
											                               <div class="col-auto">
											                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
											                               </div>
											                           </div>
											                        </div>
											                  </div>
											             </div>
											                        
											             <div class="col-xl-3 col-md-6 mb-4">
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
	
									                        <div class="col-xl-3 col-md-6 mb-4">
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
									                        
									                        <div class="col-xl-3 col-md-6 mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">기처리</div>
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
		
													    <div class="col-xl-3 col-md-6 mb-4">
											                <div class="card border-bottom-primary shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                               <div class="col mr-2">
											                                    <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">현재</div>
											                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[1][0]} 건</div>
											                               </div>
											                               <div class="col-auto">
											                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
											                               </div>
											                           </div>
											                        </div>
											                  </div>
											             </div>
											                        
											             <div class="col-xl-3 col-md-6 mb-4">
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
	
									                        <div class="col-xl-3 col-md-6 mb-4">
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
									                        
									                        <div class="col-xl-3 col-md-6 mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">기처리</div>
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
							            		<h5>유저테스트 현황</h5>
							            		<div>
								            		<!-- 단계 카드들 -->
													<div class="row">
		
													    <div class="col-xl-3 col-md-6 mb-4">
											                <div class="card border-bottom-primary shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                               <div class="col mr-2">
											                                    <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">현재</div>
											                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[2][0]} 건</div>
											                               </div>
											                               <div class="col-auto">
											                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
											                               </div>
											                           </div>
											                        </div>
											                  </div>
											             </div>
											                        
											             <div class="col-xl-3 col-md-6 mb-4">
											                 <div class="card border-left-success shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                              <div class="col mr-2">
											                                  <div class="text-sm font-weight-bold text-success text-uppercase mb-1">테스트 대기</div>
											                                  <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[2][0]-stateTask[2][1]} 건</div>
											                              </div>
											                          	  <div class="col-auto">
											                                  <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
											                              </div>
											                          </div>
											                      </div>
											                  </div>
											              </div>
	
									                        <div class="col-xl-3 col-md-6 mb-4">
									                            <div class="card border-left-warning shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-warning text-uppercase mb-1">테스트 중</div>
									                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[2][1]} 건</div>
									                                        </div>
									                                        <div class="col-auto">
									                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
									                                        </div>
									                                    </div>
									                                </div>
									                            </div>
									                        </div>
									                        
									                        <div class="col-xl-3 col-md-6 mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">기처리</div>
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
		
													    <div class="col-xl-3 col-md-6 mb-4">
											                <div class="card border-bottom-primary shadow h-100 py-2">
											                     <div class="card-body">
											                          <div class="row no-gutters align-items-center">
											                               <div class="col mr-2">
											                                    <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">현재</div>
											                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${stateTask[3][0]} 건</div>
											                               </div>
											                               <div class="col-auto">
											                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
											                               </div>
											                           </div>
											                        </div>
											                  </div>
											             </div>
											                        
											             <div class="col-xl-3 col-md-6 mb-4">
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
	
									                        <div class="col-xl-3 col-md-6 mb-4">
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
									                        
									                        <div class="col-xl-3 col-md-6 mb-4">
									                            <div class="card border-left-secondary shadow h-100 py-2">
									                                <div class="card-body">
									                                    <div class="row no-gutters align-items-center">
									                                        <div class="col mr-2">
									                                            <div class="text-sm font-weight-bold text-secondary text-uppercase mb-1">기처리</div>
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
							        <div class="card-title-block">
										<h3 class="title ml-3 mt-3">
											서비스 요청 추이
										</h3>
									</div>
							        <div class="tab-content tabs-bordered">
							        	<div class="m-3">
							        		<div id="curve_chart"></div>						        		
							        	</div>
							        </div>
								</div>
							</div>
	
						</div>
				
					
					</div>
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
