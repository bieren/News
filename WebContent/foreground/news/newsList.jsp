<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="data_list ">
<div class="dataHeader navi">${navCode }</div>
	<div class="datas news_type_list">
		<ul>
			<c:forEach var="newestNewsWithType" items="${newestNewsListWithType }">
				<li>
					<span>
						<fmt:formatDate value="${newestNewsWithType.publishDate }" pattern="【yyyy-MM-dd】" type="date"/>
					</span>
					&nbsp;&nbsp;
					<a href="news?action=show&newsId=${newestNewsWithType.newsId }"
					title="${newestNewsWithType.title }">${fn:substring(newestNewsWithType.title,0,42) }</a>
				</li>
			</c:forEach>
		</ul>
		<div>${pageCode }</div>
	</div>
</div>

