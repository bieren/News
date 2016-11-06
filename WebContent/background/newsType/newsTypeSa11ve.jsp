<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
    function checkForm() {
	var typeName = document.getElementById("typeName").value;
	if (typeName == null || typeName == "") {
	    document.getElementById("error").innerHTML = "类别名称不能为空！";
	    return false;
	}
	return true;
    }
</script>
</head>

<body>
	<div class="data_list backMain">
		<div class="dataHeader navi">${navCode }</div>
		<div class="data_content">
			<form action="newsType?action=sa11ve" method="post"
				onsubmit="return checkForm();">
				<table cellpadding="5">
					<tr>
						<td><label>新闻类别名称：</label></td>
						<td><input type="text" id="typeName" name="typeName" value="${newsType.typeName }"/></td>
					</tr>
					
					<tr>
						<td><input type="hidden" id="newsTypeId" name="newsTypeId" value="${newsType.newsTypeId }"/></td>
						<td>
						<input class="btn btn-primary" type="submit" value="保存新闻类别"/>&nbsp;&nbsp;
						<input type="button" class="btn btn-primary" onclick="javascript:history.back()" value="返回"/>&nbsp;&nbsp;
						<font id="error" color="red">${error }</font>
						</td>
					</tr>
				</table>

			</form>

		</div>
	</div>
</body>
</html>