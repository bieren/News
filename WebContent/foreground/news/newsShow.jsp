<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="data_list ">
	<div class="dataHeader navi">${navCode }</div>
	<div class="news_title">
		<h3>${news.title }</h3>
	</div>

	<div class="news_info">
		<span>发布时间：<fmt:formatDate value="${news.publishDate }"
				pattern="[yyyy-MM-dd HH:mm:ss]" type="date" />
		</span>&nbsp;&nbsp;&nbsp;&nbsp;作者：[${news.author }]&nbsp;&nbsp;&nbsp;&nbsp;新闻类别：[${news.typeName}]&nbsp;&nbsp;&nbsp;&nbsp;阅读次数：${news.click }
	</div>

	<div class="news_content">${news.content }</div>
	<div class="upDownPage">${upAndDownPageCode }</div>
	
</div>

<div class="data_list comment_list">
	<div class="dataHeader">用户评论</div>
		<div class="commentDatas">
		<c:forEach var="comment" items="${commentList }" >
			<div class="comment">
				
				<font>${comment.userIP }:</font>
				<font>&nbsp;&nbsp;${comment.content }</font>&nbsp;&nbsp;&nbsp;&nbsp;
				<span>[<fmt:formatDate value="${comment.commentDate }" pattern="yyyy-MM-dd HH:mm:ss" />]</span>
			</div>
		</c:forEach>
	</div>
</div>

<div class="publish_list">
	<form action="comment?action=sa11ve" method="post">
		<div>
			<input type="hidden" value="${news.newsId }" id="newsId" name="newsId"/><!-- 隐藏域 -->
			<textarea style="width: 98%;" rows="3" id="content" name="content"  ></textarea>
		</div>
		<div class="publishButton">
			<button class="btn btn-primary" type="submit">发表评论</button>
		</div>
	</form>
</div>

