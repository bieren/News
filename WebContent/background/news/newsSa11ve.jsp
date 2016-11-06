<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
$("document").ready(function() {
    if(document.getElementById("isImage").checked){//判断是否选中
	    $("#hdtp").show();
	}
});




    function checkForm() {
		var title = document.getElementById("title").value;
		var author = document.getElementById("author").value;
		var typeId = document.getElementById("typeId").value;
		/* var isImage=document.getElementById("isImage").checked;
		var picFile=document.getElementById("picFile").value; */
		var content = CKEDITOR.instances.content.getData();//固定写法
		
		
		if (title == null || title == "") {
		    document.getElementById("error").innerHTML = "新闻标题不能为空！";
		    return false;
		}else{
		    document.getElementById("error").innerHTML = "";
		}
		
		if (author == null || author == "") {
		    document.getElementById("error").innerHTML = "新闻作者不能为空！";
		    return false;
		}else{
		    document.getElementById("error").innerHTML = "";
		}
		
		if (typeId == null || typeId == "") {
		    document.getElementById("error").innerHTML = "新闻类别不能为空！";
		    return false;
		}else{
		    document.getElementById("error").innerHTML = "";
		}
		
		/* if (isImage){
		    if (picFile == null || picFile == "") {
			 	document.getElementById("imageError").innerHTML = "勾了幻灯还敢不选择图片？";
			    return false;
			}else{
			    document.getElementById("imageError").innerHTML = "";
			}
		} */
		
		if (content == null || content == "") {
		    document.getElementById("error").innerHTML = "新闻内容不能为空！";
		    return false;
		}else{
		    document.getElementById("error").innerHTML = "";
		}
		
		return true;
    }
     
    
    
    function checkChange() {
		if(document.getElementById("isImage").checked){//判断是否选中
		    $("#hdtp").show();
		}else{
		    file=document.getElementById("hdtp");
		    
		  	if (file.outerHTML) {// for IE, Opera, Safari, Chrome
	             file.outerHTML = file.outerHTML;
	        } else { // FF(包括3.5)
	             file.value = "";
	        }
		  	document.getElementById("imageError").innerHTML = "";
		    $("#hdtp").hide();
		}
    }
    
</script>
</head>

<body>
	<div class="data_list backMain">
		<div class="dataHeader navi">${navCode }</div>
		<div class="data_content">
			<form action="news?action=sa11ve" method="post"
				onsubmit="return checkForm();" enctype="multipart/form-data">
				<!-- 表单标签中设置enctype="multipart/form-data"来确保匿名上载文件的正确编码。  -->
				<table cellpadding="5" 	width="100%">
					<tr>
						<td width="70px;"><label>新闻标题：</label></td>
						<td><input class="input-xxlarge" type="text" id="title" name="title" value="${news.title }"/></td>
					</tr>
					<tr>
						<td><label>新闻作者：</label></td>
						<td><input  type="text" id="author" name="author" value="${news.author }"/></td>
					</tr>
					<tr>
						<td><label>新闻类别：</label></td>
						<td>
							<select id="typeId" name="typeId">
								<option value="">请选择新闻类别</option>
								<c:forEach var="newsType" items="${newsTypeList }">
									<!--
										<option value=" " ${newsType.newsTypeId==news.typeId?'selected':'' } ></option>
									-->
									<option value="${newsType.newsTypeId }" ${newsType.newsTypeId==news.typeId?'selected':'' } >${newsType.typeName }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td><label>新闻属性：</label></td>
						<td>
							<label class="checkbox inline">
							  <input type="checkbox" id="isHead" name="isHead" value="1" ${news.isHead==1?'checked':''} /> 头条
							</label>
							<label class="checkbox inline">
							  <input type="checkbox" id="isImage" name="isImage" onclick="checkChange()" value="1" ${news.isImage==1?'checked':''} /> 幻灯
							</label>
							<label class="checkbox inline">
							  <input type="checkbox" id="isHot" name="isHot" value="1" ${news.isHot==1?'checked':''} /> 热点
							</label>
						</td>
					</tr>
					
					<tr id="hdtp" style="display: none;">
						<td>
							<label>幻灯图片：</label>
						</td>
						<td>
							<input type="file" id="picFile" name="picFile"  />
							<input type="hidden" id="imageName" name="imageName" value="${news.imageName }" />
						</td>
					</tr>
					
					
					<tr>
						<td valign="top">	<!-- valign="top"上对齐 -->
							<label>新闻内容：</label>
						</td>
						<td>
							<textarea class="ckeditor" id="content" name="content" >${news.content }</textarea>
						</td>
					</tr>
					
					<tr>
						<td>
							<input type="hidden" id="newsId" name="newsId" value="${news.newsId }"/>
						</td>
						<td>
							<input class="btn btn-primary" type="submit" value="保存新闻"/>&nbsp;&nbsp;
							<input type="button" class="btn btn-primary" onclick="javascript:history.back()" value="返回"/>&nbsp;&nbsp;
							<font id="error" color="red">${error }</font><font id="imageError" color="red"></font>
						</td>
					</tr>
				</table>

			</form>

		</div>
	</div>
</body>
</html>
<!-- <script >
	if('${news.isImage}'==1){//当修改新闻的时候使图片上传按钮显示
	    //$("#hdtp").show();
	}
</script> -->
