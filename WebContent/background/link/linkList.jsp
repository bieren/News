<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

function linkDelete(linkId) {
    if(confirm("确认要删除这条友情链接吗？")){
	/* $.post(URL,data,callback); */
	$.post("link?action=delete",{linkId:linkId},
		function(result) {
		    var result=eval('('+result+')');
		    if(result.success){
			alert("删除成功！");
			window.location.href="${pageContext.request.contextPath }/link?action=backList";
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
		<div class="data_content">
			<table class="table table-hover table-bordered">
				<tr>
					<th>序号</th>
					<th>链接名称</th>
					<th>链接地址</th>
					<th>联系人邮箱</th>
					<th>排列顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach var="linkBack" items="${linkBackList }"
					varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>${linkBack.linkName }</td>
						<td>${linkBack.linkUrl}</td>
						<td>${linkBack.linkEmail }</td>
						<td>${linkBack.orderNum }</td>
					<td><!--javascript:window.location用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面-->
						<button class="btn btn-mini btn-info" type="button" onclick="javascript:window.location='link?action=preSa11ve&linkId=${linkBack.linkId}'">修改 </button>&nbsp;&nbsp;
						<button class="btn btn-mini btn-danger" type="button" onclick="linkDelete(${linkBack.linkId})">删除 </button>
					</td>
					
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>