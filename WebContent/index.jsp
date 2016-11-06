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

<body >
	<div class="container" style="width: 1020px;">
		<jsp:include page="/foreground/common/head.jsp"></jsp:include>
		<div class="row-fluid">
			<div class="span9">
				<div>
					<DIV style="width: 330px; height: 228px;" class="tuhuo">
						<A href="" target="_blank"><IMG
							style="width: 330px; height: 208px;" id="fou_img" src=""></A>

						<!-- <A
							href="news?action=show&newsId=104"> <IMG
							style="display: none;" class="tu_img"
							src="userImage/5bb7f039628e2b.jpg" width="330" height="208" />
						</A> <A href="news?action=show&newsId=103"> <IMG
							style="display: none;" class="tu_img"
							src="userImage/20140313111448.jpg" width="330" height="208" />
						</A> <A href="news?action=show&newsId=102"> <IMG
							style="display: none;" class="tu_img"
							src="userImage/20140313110011.jpg" width="330" height="208" />
						</A> <A href="news?action=show&newsId=52"> <IMG
							style="display: none;" class="tu_img"
							src="userImage/20140313084123.jpg" width="330" height="208" />
						</A> <A href="news?action=show&newsId=51"> <IMG
							style="display: none;" class="tu_img"
							src="userImage/20140313065252.jpg" width="330" height="208" />
						</A> -->
						<!-- 轮播图片动态化 -->
						<c:forEach var="imageNews" items="${imageNewsList }">
							<A href="news?action=show&newsId=${imageNews.newsId }"> <IMG
								style="display: none;" class="tu_img"
								src="${imageNews.imageName }" width="330" height="208" />
							</A>
						</c:forEach>
						<!-- 轮播图片标题动态化 -->
						<c:forEach var="imageNews" items="${imageNewsList }">
							<P style="height: 20px;" class="tc">
								<A href="news?action=show&newsId=${imageNews.newsId }"
									<%-- ${fn:substring(imageNews.title,0,18)}字符串截取18个字符 --%>
						target="_blank"
									title="${imageNews.title}">${fn:substring(imageNews.title,0,18)}
								</A>
							</P>
						</c:forEach>
						<!-- 
						<P style="height: 20px;" class="tc"><A href="news?action=show&newsId=104" target="_blank" title="南丰李浩白 天天上班玩游戏 竟然...">南丰李浩白 天天上班玩游戏 竟然...</A></P>
						<P style="height: 20px;" class="tc">
							<A href="news?action=show&newsId=103" target="_blank"
								title="昆明火车站暴恐案直击:暴徒见人就砍现场混乱血腥">昆明火车站暴恐案直击:暴徒见人就砍现</A>
						</P>
						<P style="height: 20px;" class="tc">
							<A href="news?action=show&newsId=102" target="_blank"
								title="西安幼儿园被指近3年都给孩子吃过药">西安幼儿园被指近3年都给孩子吃过药</A>
						</P>
						<P style="height: 20px;" class="tc">
							<A href="news?action=show&newsId=52" target="_blank"
								title="娱乐新闻1">娱乐新闻1</A>
						</P>
						<P style="height: 20px;" class="tc">
							<A href="news?action=show&newsId=51" target="_blank"
								title="马来西亚巫师作法再寻失联飞机：这次更奇葩">马来西亚巫师作法再寻失联飞机：这次更</A>
						</P> -->
						<UL>
							<LI class="fouce">1</LI>
							<LI>2</LI>
							<LI>3</LI>
							<LI>4</LI>
							<LI>5</LI>
						</UL>
					</DIV>
				</div>
				<div class="newsHeader_list">
					<div class="newsHeader">
						<h3>
							<a href="news?action=show&newsId=${headNews.newsId}"
								title="${headNews.title}">${fn:substring(headNews.title,0,6)}</a>
						</h3>
						<p>
							${fn:substring(headNews.content,0,30)}...<a
								href="news?action=show&newsId=${headNews.newsId}">[查看全文]</a>
						</p>
					</div>
					<div class="currentUpdate">
						<div class="currentUpdateHeader">最近更新</div>
						<div class="currentUpdateDatas">
							<table width="100%">
								<!-- <tr>
									<td width="50%"><a href="news?action=show&newsId=105"
										title="吊">吊</a></td>
									<td width="50%"><a href="news?action=show&newsId=104"
										title="南丰李浩白 天天上班玩游戏 竟然...">南丰李浩白 天天上班玩游戏 竟然...</a></td>
								</tr>
								<tr>
									<td width="50%"><a href="news?action=show&newsId=103"
										title="昆明火车站暴恐案直击:暴徒见人就砍现场混乱血腥">昆明火车站暴恐案直击:暴</a></td>
									<td width="50%"><a href="news?action=show&newsId=102"
										title="西安幼儿园被指近3年都给孩子吃过药">西安幼儿园被指近3年都给</a></td>
								</tr>
								<tr>
									<td width="50%"><a href="news?action=show&newsId=94"
										title="小道新闻1">小道新闻1</a></td>
									<td width="50%"><a href="news?action=show&newsId=95"
										title="小道新闻5">小道新闻5</a></td>
								</tr>
								<tr>
									<td width="50%"><a href="news?action=show&newsId=96"
										title="小道新闻5">小道新闻5</a></td>
									<td width="50%"><a href="news?action=show&newsId=97"
										title="小道新闻5">小道新闻5</a></td>
								</tr> -->
								<!-- 最近更新模块动态化 -->
								<c:forEach var="newestNews" items="${newestNewsList }"
									varStatus="status">
									<c:if test="${status.index%2==0 }">
										<tr>
									</c:if>
									<td width="50%"><a
										href="news?action=show&newsId=${newestNews.newsId }"
										title="${newestNews.title }">${fn:substring(newestNews.title,0,10)}</a>
									</td>
									<c:if test="${status.index%2==1 }">
										</tr>
									</c:if>

								</c:forEach>
							</table>
						</div>

					</div>
				</div>
			</div>
			<div class="span3">
				<div class="data_list hotspot_news_list">
					<div class="dataHeader">热点新闻</div>
					<div class="datas">
						<ul>
							<!-- 
							<li><a href="news?action=show&newsId=104"
								title="南丰李浩白 天天上班玩游戏 竟然...">南丰李浩白 天天上班玩游戏 竟然...</a></li>
							<li><a href="news?action=show&newsId=103"
								title="昆明火车站暴恐案直击:暴徒见人就砍现场混乱血腥">昆明火车站暴恐案直击:暴徒见人</a></li>
							<li><a href="news?action=show&newsId=102"
								title="西安幼儿园被指近3年都给孩子吃过药">西安幼儿园被指近3年都给孩子吃</a></li>
							<li><a href="news?action=show&newsId=53" title="娱乐新闻2">娱乐新闻2</a></li>
							<li><a href="news?action=show&newsId=52" title="娱乐新闻1">娱乐新闻1</a></li>
							<li><a href="news?action=show&newsId=51"
								title="马来西亚巫师作法再寻失联飞机：这次更奇葩">马来西亚巫师作法再寻失联飞机：</a></li>
							<li><a href="news?action=show&newsId=50"
								title="汪峰是互联网上名副其实的King">汪峰是互联网上名副其实的Kin</a></li>
							<li><a href="news?action=show&newsId=49" title="2133啊">2133啊</a></li> -->
							
							
							<!-- 热点新闻模块动态化 -->
							<c:forEach var="hotSpotNews" items="${hotSpotNewsList }">
								<li><a
									href="news?action=show&newsId=${hotSpotNews.newsId }"
									title="${hotSpotNews.title }">${fn:substring(hotSpotNews.title,0,15)}</a></li>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
		</div>
		<c:forEach var="allIndexNews" items="${allIndexNewsList }"
			varStatus="allStatus">
			<c:if test="${allStatus.index%3==0 }">
				<div class="row-fluid" >
			</c:if>

			<c:forEach var="indexNews" items="${allIndexNews }"
				varStatus="oneStatus">
				<c:if test="${oneStatus.first }">
					<div class="span4">
						<div class="data_list news_list">
							<div class="dataHeader">${newsTypeList.get(allStatus.index).typeName }
							<%-- ${newsTypeList.get(allStatus.index).typeName }获取新闻类别名称 --%>
								<span class="more"> <a
									href="news?action=list&typeId=${newsTypeList.get(allStatus.index).newsTypeId }">更多...</a>
								</span>
							</div>
							<div class="datas">
								<ul>
				</c:if>
				
				<li><fmt:formatDate value="${indexNews.publishDate }" pattern="MM-dd" type="date"/>&nbsp;<a href="news?action=show&newsId=${indexNews.newsId }"
					title="${indexNews.title }">${fn:substring(indexNews.title,0,18) }...</a>
				</li>
				
				
				<c:if test="${oneStatus.last}">
								</ul>
							</div>
						</div>
					</div>
				</c:if>


		</c:forEach>

		<c:if test="${allStatus.index%3==2 || allStatus.last }">
			</div>
		</c:if>
	</c:forEach>
	
	

	<!-- 
	
	<div class="row-fluid">
		<div class="span4">
			<div class="data_list news_list">
				<div class="dataHeader">
					娱乐新闻<span class="more"><a href="news?action=list&typeId=1">更多...</a></span>
				</div>
				<div class="datas">
					<ul>
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
					</ul>
				</div>
			</div>
		</div>
		<div class="span4">
			<div class="data_list news_list">
				<div class="dataHeader">
					政治新闻<span class="more"><a href="news?action=list&typeId=2">更多...</a></span>
				</div>
				<div class="datas">
					<ul>
						<li>03-13&nbsp;<a href="news?action=show&newsId=71"
							title="政治新闻2">政治新闻2</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=72"
							title="政治新闻3">政治新闻3</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=73"
							title="政治新闻4">政治新闻4</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=74"
							title="政治新闻5">政治新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=75"
							title="政治新闻6">政治新闻6</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=76"
							title="政治新闻7">政治新闻7</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=77"
							title="政治新闻8">政治新闻8</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=51"
							title="马来西亚巫师作法再寻失联飞机：这次更奇葩">马来西亚巫师作法再寻失联飞机：这次更</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="span4">
			<div class="data_list news_list">
				<div class="dataHeader">
					经济新闻<span class="more"><a href="news?action=list&typeId=3">更多...</a></span>
				</div>
				<div class="datas">
					<ul>
						<li>03-13&nbsp;<a href="news?action=show&newsId=78"
							title="经济新闻1">经济新闻1</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=79"
							title="经济新闻3">经济新闻3</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=80"
							title="经济新闻3">经济新闻3</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=81"
							title="经济新闻4">经济新闻4</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=82"
							title="经济新闻5">经济新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=83"
							title="经济新闻6">经济新闻6</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=84"
							title="经济新闻7">经济新闻7</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=85"
							title="经济新闻8">经济新闻8</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span4">
			<div class="data_list news_list">
				<div class="dataHeader">
					文化新闻<span class="more"><a href="news?action=list&typeId=4">更多...</a></span>
				</div>
				<div class="datas">
					<ul>
						<li>03-13&nbsp;<a href="news?action=show&newsId=86"
							title="文化新闻1">文化新闻1</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=87"
							title="文化新闻4">文化新闻4</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=88"
							title="文化新闻4">文化新闻4</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=89"
							title="文化新闻4">文化新闻4</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=90"
							title="文化新闻5">文化新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=91"
							title="文化新闻6">文化新闻6</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=92"
							title="文化新闻7">文化新闻7</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=93"
							title="文化新闻8">文化新闻8</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="span4">
			<div class="data_list news_list">
				<div class="dataHeader">
					小道新闻<span class="more"><a href="news?action=list&typeId=5">更多...</a></span>
				</div>
				<div class="datas">
					<ul>
						<li>03-13&nbsp;<a href="news?action=show&newsId=103"
							title="昆明火车站暴恐案直击:暴徒见人就砍现场混乱血腥">昆明火车站暴恐案直击:暴徒见人就砍现</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=102"
							title="西安幼儿园被指近3年都给孩子吃过药">西安幼儿园被指近3年都给孩子吃过药</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=94"
							title="小道新闻1">小道新闻1</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=95"
							title="小道新闻5">小道新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=96"
							title="小道新闻5">小道新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=97"
							title="小道新闻5">小道新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=98"
							title="小道新闻5">小道新闻5</a></li>
						<li>03-13&nbsp;<a href="news?action=show&newsId=99"
							title="小道新闻6">小道新闻6</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="span4">
			<div class="data_list news_list">
				<div class="dataHeader">
					屌炸天新闻<span class="more"><a href="news?action=list&typeId=6">更多...</a></span>
				</div>
				<div class="datas">
					<ul>
						<li>03-14&nbsp;<a href="news?action=show&newsId=105"
							title="吊">吊</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div> 
	-->
	<jsp:include page="/foreground/common/link.jsp"></jsp:include>
	<jsp:include page="/foreground/common/foot.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
    //Js代码存放在这里是为了确保页面元素加载完毕才执行Js代码
    var auto;
    var index = 0;
    $('.tuhuo ul li').hover(function() {
	clearTimeout(auto);
	index = $(this).index();
	move(index);
    }, function() {
	auto = setTimeout('autogo(' + index + ')', 3000);
    });

    function autogo() {
	if (index < 5) {
	    move(index);
	    index++;
	} else {
	    index = 0;
	    move(index);
	    index++;
	}
    }
    function move(l) {
	var src = $('.tu_img').eq(index).attr('src');
	$("#fou_img").css({
	    "opacity" : "0"
	});
	$('#fou_img').attr('src', src);
	$('#fou_img').stop(true).animate({
	    opacity : '1'
	}, 1000);
	$('.tuhuo ul li').removeClass('fouce');
	$('.tuhuo ul li').eq(index).addClass('fouce');
	$('.tuhuo p').hide();
	$('.tuhuo p').eq(index).show();
	var ao = $('.tuhuo p').eq(index).children('a').attr('href');
	$('#fou_img').parent('a').attr("href", ao);
    }
    autogo();
    setInterval('autogo()', 3000);
</script>
</html>
