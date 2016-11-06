<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

function newsTypeDelete(newsTypeId) {
    if(confirm("确认要删除此新闻类别吗？")){
	/* $.post(URL,data,callback); */
	$.post("newsType?action=delete",{newsTypeId:newsTypeId},
		function(result) {
		    var result=eval('('+result+')');
		    if(result.success){
			alert("删除成功！");
			window.location.href="${pageContext.request.contextPath }/newsType?action=backList";
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
					<th>新闻类别名称</th>
					<th>操作</th>
				</tr>
				<c:forEach var="newsTypeBack" items="${newsTypeBackList }"
					varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>${newsTypeBack.typeName }</td>
					<td><!--javascript:window.location用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面-->
						<button class="btn btn-mini btn-info" type="button" onclick="javascript:window.location='newsType?action=preSa11ve&newsTypeId=${newsTypeBack.newsTypeId}'">修改 </button>&nbsp;&nbsp;
						<button class="btn btn-mini btn-danger" type="button" onclick="newsTypeDelete(${newsTypeBack.newsTypeId})">删除 </button>
					</td>
					
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>