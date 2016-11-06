package com.java1234.util;

public class PageUtil {
    public static String getUpAndDownPagation(int totalNum,int currentPage,int pageSize,String typeId){
	/**********
	 int totalNum 		总记录数
	 int currentPage		当前页
	 int pageSize			每页的记录数
	 String typeId			Id
	 
	 
	 */
	int totalPage=totalNum%pageSize==0?totalNum/pageSize:totalNum/pageSize+1;
	StringBuffer pageCode=new StringBuffer();
	pageCode.append("<ul class='pager'>");
	if(currentPage==1){
	    pageCode.append(" <li  class='disabled'><a href='#'>上一页</a></li>");
	}else {
	    pageCode.append(" <li><a href='news?action=list&typeId="+typeId+"&page="+(currentPage-1)+"'><span style='color:#00FF00'>上一页</span></a></li>");
	}
	pageCode.append("&nbsp;&nbsp;");
	if(currentPage==totalPage){
	    pageCode.append(" <li  class='disabled'><a href='#'>下一页</a></li>");
	}else {
		pageCode.append(" <li><a href='news?action=list&typeId="+typeId+"&page="+(currentPage+1)+"'><span style='color:#00FF00'>下一页</span></a></li>");
	}
		pageCode.append("</ul>");
	
	return pageCode.toString();
    } 
    
    public static String getPagation(String targetUrl,int totalNum,int currentPage,int pageSize){
	/**********
	 String targetUrl  		页地址
	 int totalNum 		总记录数
	 int currentPage		当前页
	 int pageSize			每页的记录数
	 
	 */
	int totalPage=totalNum%pageSize==0?totalNum/pageSize:totalNum/pageSize+1;
	StringBuffer pageCode=new StringBuffer();
	pageCode.append(" <li ><a href='"+targetUrl+"&page=1'>首页</a></li>");
	
	if(currentPage==1){
	    pageCode.append(" <li  class='disabled'><a >上一页</a></li>");
	}else {
	    pageCode.append(" <li ><a  href='"+targetUrl+"&page="+(currentPage-1)+"'><span style='color:#00FF00'>上一页</span></a></li>");
	}
	
	for(int i=currentPage-2;i<=currentPage+2;i++){//定义显示多少页 i为页数
	    if(i<1||i>totalPage){
		continue;
	    }
	    if(i==currentPage){
		 //<li class="active"><a href="#">1</a></li>
		  pageCode.append(" <li class='active'><a ><strong>"+i+"</strong></a></li>");
	    }else {
		  pageCode.append(" <li><a  href='"+targetUrl+"&page="+i+"' >"+i+"</a></li>");
	    }
	}
	
	if(currentPage==totalPage){//定义下一页是否禁用
	    pageCode.append(" <li  class='disabled'><a >下一页</a></li>");
	}else {
	    pageCode.append(" <li ><a  href='"+targetUrl+"&page="+(currentPage+1)+"'><span style='color:#00FF00'>下一页</span></a></li>");
	}
	pageCode.append(" <li ><a href='"+targetUrl+"&page="+totalPage+"'>尾页</a></li>");
	return pageCode.toString();
    } 
    

}
