<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">

function newsDelete(newsId) {
    if(confirm("确认要删除这条新闻吗？")){
	/* $.post(URL,data,callback); */
	$.post("news?action=delete",{newsId:newsId},
		function(delFlag) {
		    var flag=eval('('+delFlag+')');
		    if(flag){
				alert("删除成功！");
				window.location.href="${pageContext.request.contextPath }/news?action=backList";
		    }else{
				alert("删除失败！请重试！");
		    }
		});
    }
}

</script>
<body>
	<div class="data_list backMain">

		<div class="dataHeader navi">${navCode }</div>
		<div class="search_content" style="vertical-align: middle;/* 垂直居中 */   padding-right: 20px;">
			
			<form action="${pageContext.request.contextPath }/news?action=backList" method="post" 
			 style="margin-bottom: 0px;width: 100%;">
				<table >
					<tr>
						<td width="70px;">
							<label>新闻标题：</label>
						</td>
						<td>
							<input  type="text" id="s_title" name="s_title" 
							value="${s_title}" />
						</td>
					</tr>
					<tr>
						<td width="70px;">
							<label>新闻作者：</label>
						</td>
						<td>
							<input  type="text" id="s_author" name="s_author" 
							value="${s_author}" />
						</td>
					</tr>
					<tr>
						<td width="70px;">
							
							<label>评论日期：</label>
						</td>
						<td>
							<input style="width: 100px;" class="Wdate" onclick="WdatePicker()" type="text" id="s_bPublishDate" name="s_bPublishDate" 
								value="${s_bPublishDate}" /> 
							&nbsp;到&nbsp;
							<input style="width: 100px;"  class="Wdate" onclick="WdatePicker()" type="text"
								id="s_aPublishDate" name="s_aPublishDate"
								value="${s_aPublishDate }" />
						</td>
					</tr>
					
					<tr>
						<td >
							<button class="btn btn-small btn-primary"  type="submit">查询</button>
						</td>
						<td>
							
						</td>
					</tr>
				</table>
				   
				
			</form>
			
		</div>
		<div class="data_content" >
			<table class="table table-hover table-bordered">
				<tr>
					<th>序号</th>
					<th>新闻标题</th>
					<th>新闻作者</th>
					<th>新闻类别</th>
					<th>发布时间</th>
					<th colspan="2" >操作</th>
				</tr>
				<c:forEach var="newsBack" items="${newsBackList }"
					varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td><a title="${newsBack.title }" target="_blank" href="${pageContext.request.contextPath }/news?action=show&newsId=${newsBack.newsId}">
							${fn:substring(newsBack.title,0,22) }</a></td>
						<td><a title="${newsBack.author}" >${newsBack.author }</a></td>
						<td><a title="${newsBack.typeName }" target="_blank"
							href="news?action=list&typeId=${newsBack.typeId }">
							${fn:substring(newsBack.typeName,0,4) }</a></td>
						<td><fmt:formatDate value="${newsBack.publishDate }"
								type="date" pattern="yyyy-MM-dd" /></td>
						<td style="width: 43px; margin-left: 7px; height: 22px; padding-right: 2px; padding-left: 8px; border-left-width: 1px; border-top-width: 1px; border-right-width: 11px;">
							<!--javascript:window.location.href用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面-->
							<button  class="btn btn-mini btn-info" type="button" 
							onclick="javascript:window.location.href='news?action=preSa11ve&newsId=${newsBack.newsId}'">修改 </button>&nbsp;&nbsp;
						</td>
						<td style="width: 43px; margin-left: 7px; height: 22px; padding-right: 2px; padding-left: 8px; border-left-width: 1px; border-top-width: 1px; border-right-width: 11px;">
							<button class="btn btn-mini btn-danger" type="button"
								onclick="newsDelete(${newsBack.newsId})">删除</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="pagination pagination-centered">
	  		<ul>
				${pageCode }
			</ul>
		</div>
	
	</div>
</body>
</html>