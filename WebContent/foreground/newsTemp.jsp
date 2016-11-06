<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>屌炸天新闻</title>
<link href="${pageContext.request.contextPath}/style/news.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-responsive.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/bootstrap/js/jQuery.js"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
</head>

<body>
	<div class="container" style="width: 1020px;">
		<jsp:include page="/foreground/common/head.jsp"></jsp:include>
		<div class="row-fluid">
			<div class="span8">
				<jsp:include page="${mainPage }"></jsp:include>
			</div>
			<div class="span4">
				<div class="data_list right_news_list">
					<div class="dataHeader">最新新闻</div>
					<div class="datas">
						<ul>
							<!-- 
						<li>03-14&nbsp;<a href="news?action=show&newsId=104"
							title="南丰李浩白 天天上班玩游戏 竟然...">南丰李浩白 天天上班玩游戏 竟然...</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=64"
							title="娱乐新闻3">娱乐新闻3</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=65"
							title="娱乐新闻4">娱乐新闻4</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=66"
							title="娱乐新闻5">娱乐新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=67"
							title="娱乐新闻6">娱乐新闻6</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=68"
							title="娱乐新闻7">娱乐新闻7</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=69"
							title="娱乐新闻8">娱乐新闻8</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=53"
							title="娱乐新闻2">娱乐新闻2</a></li>
							 -->

							<c:forEach var="newestNews" items="${newestNewsList }">
								<li><fmt:formatDate value="${newestNews.publishDate }"
										pattern="MM-dd" type="date" />&nbsp;<a
									href="news?action=show&newsId=${newestNews.newsId }"
									title="${newestNews.title }">${fn:substring(newestNews.title,0,22) }</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="data_list right_news_list">
					<div class="dataHeader">热门新闻</div>
					<div class="datas">
						<ul>
							<c:forEach var="hotNews" items="${hotNewsList }">
								<li><fmt:formatDate value="${hotNews.publishDate }"
										pattern="MM-dd" type="date" />&nbsp;<a
									href="news?action=show&newsId=${hotNews.newsId }"
									title="${hotNews.title }">${fn:substring(hotNews.title,0,22) }</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/foreground/common/foot.jsp"></jsp:include>
	</div>
</body>
</html>
