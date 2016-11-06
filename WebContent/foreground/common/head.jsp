<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function setDateTime(){
			var date=new Date();
			var day=date.getDay();
			var week;
			switch(day){
			case 0:week="星期日";break;
			case 1:week="星期一";break;
			case 2:week="星期二";break;
			case 3:week="星期三";break;
			case 4:week="星期四";break;
			case 5:week="星期五";break;
			case 6:week="星期六";break;
			}
			var today=date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日  "+week+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
			document.getElementById("today").innerHTML=today;
		}
		
		window.setInterval("setDateTime()", 1000);
		</script>
<!-- 此处调用C标签 -->
<div class="row-fluid">
	<div class="span8">
	<a href="goIndex">
		<img alt="" src="${pageContext.request.contextPath}/images/logo.png"></a>
	</div>
	<div class="span4" style="margin-top: 5px; float:right; ">
	
	<font id="today" class="currentDateTime"></font>
	<div style="float: right;"><script type="text/javascript" src="http://ip.chinaz.com/getip.aspx" ></script></div>
	
	</div>
</div>
<div class="row-fluid" >
	<div class="span12" >
		<div class="navbar" >
			<div class="navbar-inner"  >
				<a class="brand" href="goIndex" >首页</a>
				<ul class="nav" >
					<!-- 
					<li><a href="news?action=list&typeId=1">娱乐新闻</a></li>
					<li><a href="news?action=list&typeId=2">政治新闻</a></li>
					<li><a href="news?action=list&typeId=3">经济新闻</a></li>
					<li><a href="news?action=list&typeId=4">文化新闻</a></li>
					<li><a href="news?action=list&typeId=5">小道新闻</a></li>
					<li><a href="news?action=list&typeId=6">屌炸天新闻</a></li> 
					-->
					<!-- 导航条动态化 -->
					<c:forEach var="newsType" items="${newsTypeList }">
					<li><a href="news?action=list&typeId=${newsType.newsTypeId }">${newsType.typeName }</a></li>
					
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>



