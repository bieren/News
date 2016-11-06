<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="row-fluid">
	<div class="span12">
		<div class="link">
			<div class="linkHeader">友情链接</div>
			<div class="datas">
				<ul>
					<!-- 
					<li><a href="http://www.baidu.com" target="_blank">百度</a></li>
					<li><a href="http://www.oschina.net" target="_blank">开源中国</a></li>
					<li><a href="http://www.java1234.com" target="_blank">Java1234</a></li>
					<li><a href="2" target="_blank">超链7</a></li>
					<li><a href="http://www.csdn.com" target="_blank">CSDN</a></li>
					<li><a href="" target="_blank">超链2</a></li>
					<li><a href="" target="_blank">超链3</a></li>
					<li><a href="" target="_blank">超链4</a></li>
					<li><a href="" target="_blank">超链5</a></li> 
					-->
					<c:forEach var="link" items="${linkList }" >
					<li><a href="${link.linkUrl }" target="_blank" title="${link.linkEmail }">${link.linkName }</a></li> 
					</c:forEach>
					<li><a target="_blank" href="${pageContext.request.contextPath }/background/login.jsp">站长</a></li>
					
				</ul>
			</div>
		</div>
	</div>
</div>
