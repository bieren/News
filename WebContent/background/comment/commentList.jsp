<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(document).ready(function() {
    $("#checkedAll").click(function() {/* JQuery事件 */
	if($(this).prop("checked")==true){
	    $("input[name='commentIds']").prop("checked",true);
	}else{
	    $("input[name='commentIds']").prop("checked",false);
	}
    });
});


	function commentsDelete() {
	    var chk_value=[];
	    $('input[name="commentIds"]:checked').each(function() {//遍历添加ID
			chk_value.push($(this).val());
	    });
	    if(chk_value.length==0){
			alert("请选择要删除的评论");
			return;
	    }
	    var commentIds=chk_value.join(",");
	    
	    
	    if(confirm("确认要删除这些评论吗？")){
			$.post("comment?action=delete",{commentIds:commentIds},
				function(result) {
				    var result=eval('('+result+')');
				    if(result.success){
					alert("成功删除了"+result.delNums+"条评论！");
					window.location.href="${pageContext.request.contextPath }/comment?action=backList";
				    }else{
					alert(result.errorMsg);
				    }
			});
		}
	}



function commentDelete(commentId) {
    if(confirm("确认要删除这条评论吗？")){
	/* $.post(URL,data,callback); */
	$.post("comment?action=delete",{commentIds:commentId},
		function(result) {
		    var result=eval('('+result+')');
		    if(result.success){
			alert("删除成功！");
			window.location.href="${pageContext.request.contextPath }/comment?action=backList";
		    }else{
			alert(result.errorMsg);
		    }
		});
    }
}

</script>
<body>
	<div class="data_list backMain">

		<div class="dataHeader navi">${navCode }</div>
		<div class="search_content" style="vertical-align: middle;/* 垂直居中 */   padding-right: 20px;">
		
			<div style="float: left; padding-top: 5px; ">
				<button class="btn btn-mini btn-danger" style="height: 25px;" type="button" onclick="commentsDelete()" >批量删除</button>
			</div>
			<div style="float: right; ">
				<form style="margin-bottom: 0px;"  action="${pageContext.request.contextPath }/comment?action=backList" method="post">
					评论日期：
					<input style="width: 100px;" class="Wdate" onclick="WdatePicker()" type="text" id="s_bCommentDate" name="s_bCommentDate" 
						value="${s_bCommentDate}" /> 
					&nbsp;到&nbsp;
					<input style="width: 100px;"  class="Wdate" onclick="WdatePicker()" type="text"
						id="s_aCommentDate" name="s_aCommentDate"
						value="${s_aCommentDate }" /> 
					&nbsp;&nbsp;
					<button class="btn btn-mini btn-primary" style="height: 25px; margin-top: -9px;" type="submit">查询</button>
				</form>
			</div>
		</div>
		<div class="data_content" >
			<table class="table table-hover table-bordered">
				<tr>
					<th><input type="checkbox" id="checkedAll"  /></th>
					<th>序号</th>
					<th>评论内容</th>
					<th>评论主题</th>
					<th>评论时间</th>
					<th>操作</th>
				</tr>
				<c:forEach var="commentBack" items="${commentBackList }"
					varStatus="status">
					<tr>
						<td><input type="checkbox" name="commentIds" value="${commentBack.commentId }" /></td>
						<td>${status.index+1 }</td>
						<td><a title="${commentBack.content }">${fn:substring(commentBack.content,0,15) }...</a></td>
						<td><a title="${commentBack.newsTitle }"
							href="news?action=show&newsId=${commentBack.newsId }">${fn:substring(commentBack.newsTitle,0,15) }...</a></td>
						<td><fmt:formatDate value="${commentBack.commentDate }"
								type="date" pattern="yyyy-MM-dd" /></td>
						<td>
							<!--javascript:window.location用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面-->
							<button class="btn btn-mini btn-danger" type="button"
								onclick="commentDelete(${commentBack.commentId})">删除</button>
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