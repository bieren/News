package com.java1234.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.java1234.model.News;
import com.java1234.model.PageBean;
import com.java1234.util.DateUtil;
import com.java1234.util.PropertiesUtil;
import com.java1234.util.StringUtil;

public class NewsDao {
    public List<News> newsList(Connection con, String sql) throws Exception {
	List<News> newsList = new ArrayList<News>();
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	while (rs.next()) {
	    News news = new News();
	    news.setNewsId(rs.getInt("newsId"));
	    news.setTitle(rs.getString("title"));
	    news.setContent(rs.getString("content"));
	    // 使用反射调用formatString(String str, String
	    // format)把String类型转化为yyyy-MM-dd hh:mm:ss格式的Date类型
	    news.setPublishDate(DateUtil.formatString(rs.getString("publishDate"), "yyyy-MM-dd hh:mm:ss"));
	    news.setAuthor(rs.getString("author"));
	    news.setTypeId(rs.getInt("typeId"));
	   
	    news.setClick(rs.getInt("click"));
	    news.setIsHead(rs.getInt("isHead"));
	    news.setIsImage(rs.getInt("isImage"));
	    // 此处 设置的图片名称包含路径直接可用
	    // properties配置文件中PropertiesUtil.gerValue("userImage")代表路径
	    news.setImageName(PropertiesUtil.getValue("userImage") + rs.getString("imageName"));
	    news.setIsHot(rs.getInt("isHot"));
	    newsList.add(news);
	}

	return newsList;
    }

    public List<News> newsList(Connection con, News s_news, PageBean pageBean,String s_bPublishDate,String s_aPublishDate) throws Exception {
	List<News> newsList = new ArrayList<News>();
	StringBuffer sb = new StringBuffer("select * from t_news t1,t_newsType t2 where t1.typeId=t2.newsTypeId");
	if (s_news.getTypeId() != -1) {
	    sb.append(" and t1.typeId=" + s_news.getTypeId());// 根据条件修改sb内字符串内容
							      // 完成能提取出typeId!=-1的数据库语句
	}
	if(StringUtil.isNotEmpty(s_news.getTitle())){
	    sb.append(" AND t1.title LIKE '%"+s_news.getTitle()+"%'");//对标题进行模糊查询
	}
	if(StringUtil.isNotEmpty(s_news.getAuthor())){
	    sb.append(" and t1.author LIKE '%"+s_news.getAuthor()+"%'");//对作者进行模糊查询
	}
	if(StringUtil.isNotEmpty(s_bPublishDate)){
	    sb.append(" AND TO_DAYS(t1.publishDate) >= TO_DAYS('"+s_bPublishDate+"')");
	}
	if(StringUtil.isNotEmpty(s_aPublishDate)){
	    sb.append(" AND TO_DAYS(t1.publishDate) <= TO_DAYS('"+s_aPublishDate+"')");
	}
	
	
	sb.append(" order by t1.publishDate desc ");// 继续拼接
	if (pageBean != null) {
	    sb.append("limit " + pageBean.getStart() + "," + pageBean.getPageSize());// 拼接结束
	}
	PreparedStatement pstmt = con.prepareStatement(sb.toString());// 字符串缓冲对象转换为字符串
	ResultSet rs = pstmt.executeQuery();
	while (rs.next()) {
	    News news = new News();
	    news.setNewsId(rs.getInt("newsId"));
	    news.setTitle(rs.getString("title"));
	    news.setContent(rs.getString("content"));
	    // 使用反射调用formatString(String str, String
	    // format)把String类型转化为yyyy-MM-dd hh:mm:ss格式的Date类型
	    news.setPublishDate(DateUtil.formatString(rs.getString("publishDate"), "yyyy-MM-dd hh:mm:ss"));
	    news.setAuthor(rs.getString("author"));
	    news.setTypeId(rs.getInt("typeId"));
	    news.setTypeName(rs.getString("typeName"));
	    news.setClick(rs.getInt("click"));
	    news.setIsHead(rs.getInt("isHead"));
	    news.setIsImage(rs.getInt("isImage"));
	    // 此处 设置的图片名称包含路径直接可用
	    // properties配置文件中PropertiesUtil.gerValue("userImage")代表路径
	    news.setImageName(PropertiesUtil.getValue("userImage") + rs.getString("imageName"));
	    news.setIsHot(rs.getInt("isHot"));
	    newsList.add(news);
	}
	return newsList;
    }

    public int newsCount(Connection con, News s_news,String s_bPublishDate,String s_aPublishDate) throws Exception {
	StringBuffer sb = new StringBuffer("select count(*) as total from t_news");// 获取总数语句
										   // 设置
										   // 总数="total"
	if (s_news.getTypeId() != -1) {
	    sb.append(" and typeId = " + s_news.getTypeId());
	    //sb.toString().replaceFirst("and", "where")
	    //把字符串中第一次出现相同于 第一个参数 的字符串 替换成 第二个参数
	}
	if(StringUtil.isNotEmpty(s_news.getTitle())){
	    sb.append(" and title LIKE '%"+s_news.getTitle()+"%'");//对标题进行模糊查询
	}
	if(StringUtil.isNotEmpty(s_news.getAuthor())){
	    sb.append(" and author LIKE '%"+s_news.getAuthor()+"%'");//对作者进行模糊查询
	}
	if(StringUtil.isNotEmpty(s_bPublishDate)){
	    sb.append(" and TO_DAYS(publishDate) >= TO_DAYS('"+s_bPublishDate+"')");
	}
	if(StringUtil.isNotEmpty(s_aPublishDate)){
	    sb.append(" and TO_DAYS(publishDate) <= TO_DAYS('"+s_aPublishDate+"')");
	}
	
	PreparedStatement pstmt = con.prepareStatement(sb.toString().replaceFirst("and", "where"));
	ResultSet rs = pstmt.executeQuery();
	if (rs.next()) {
	    return rs.getInt("total");
	} else {
	    return 0;
	}
    }
    
    public News getNewsById(Connection con,String newsId)throws Exception{
	News news =null;
	String sql="select * from t_news t1,t_newsType t2 where t1.typeId=t2.newsTypeId and t1.newsId=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, newsId);
	ResultSet rs = pstmt.executeQuery();
	news = new News();
	if (rs.next()) {
	    news.setNewsId(rs.getInt("newsId"));
	    news.setTitle(rs.getString("title"));
	    news.setContent(rs.getString("content"));
	    // 使用反射调用formatString(String str, String
	    // format)把String类型转化为yyyy-MM-dd hh:mm:ss格式的Date类型
	    news.setPublishDate(DateUtil.formatString(rs.getString("publishDate"), "yyyy-MM-dd hh:mm:ss"));
	    news.setAuthor(rs.getString("author"));
	    news.setTypeId(rs.getInt("typeId"));
	    news.setTypeName(rs.getString("typeName"));
	    news.setClick(rs.getInt("click"));
	    news.setIsHead(rs.getInt("isHead"));
	    news.setIsImage(rs.getInt("isImage"));
	    // 此处 设置的图片名称包含路径直接可用
	    // properties配置文件中PropertiesUtil.gerValue("userImage")代表路径
	    news.setImageName(PropertiesUtil.getValue("userImage") + rs.getString("imageName"));
	    news.setIsHot(rs.getInt("isHot"));
	}
	return news;
    }
    public int newsClick(Connection con,String newsId) throws Exception{
	String sql="update t_news set click=click+1 where newsId=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, newsId);
	    return pstmt.executeUpdate();//返回执行结果 更新后的数据
	
    }

    public List<News> getUpAndDownPageId(Connection con,String newsId) throws Exception{
	List<News>  upAndDownPage=new ArrayList<News>();
	String sql="SELECT * FROM t_news WHERE newsId<? ORDER BY newsId DESC LIMIT 1";//上一篇
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, newsId);
	ResultSet rs = pstmt.executeQuery();
	if (rs.next()) {
	    upAndDownPage.add(new News(rs.getInt("newsId"), rs.getString("title")));
	}else {
	    upAndDownPage.add(new News(-1, ""));//设置-1用于NewsServlet中判断
	}
	
	sql="SELECT * FROM t_news WHERE newsId>? ORDER BY newsId ASC LIMIT 1";//下一篇
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, newsId);
	rs = pstmt.executeQuery();
	if (rs.next()) {
	    upAndDownPage.add(new News(rs.getInt("newsId"), rs.getString("title")));
	}else {
	    upAndDownPage.add(new News(-1, ""));//设置-1用于NewsServlet中判断
	}
	return upAndDownPage;
    }
    
    public boolean existNewsWithNewsTypeId(Connection con,String typeId)throws Exception{
	//通过typeId查询是否有news存在  
	String sql="select * from t_news where typeId=?";
	PreparedStatement pstmt=con.prepareStatement(sql);
	pstmt.setString(1, typeId);
	ResultSet rs=pstmt.executeQuery();
	
	if (rs.next()) {
	    return true;
	} else {
	    return false;
	}
    }
    
    public int newsAdd(Connection con,News news)throws Exception{
	String sql="insert into t_news values(null,?,?,now(),?,?,0,?,?,?,?)";//8个坑
	PreparedStatement pstmt=con.prepareStatement(sql);
	pstmt.setString	(1, news.getTitle());
	pstmt.setString	(2, news.getContent());
	pstmt.setString	(3, news.getAuthor());
	pstmt.setInt		(4, news.getTypeId());
	pstmt.setInt		(5, news.getIsHead());
	pstmt.setInt		(6, news.getIsImage());
	pstmt.setString	(7, news.getImageName());
	pstmt.setInt		(8, news.getIsHot());
	
	return pstmt.executeUpdate();
    }
    
    public int newsUpdate(Connection con,News news)throws Exception{
   	String sql="update t_news set title=?,content=?,author=?,typeId=?,isHead=?,isImage=?,imageName=? ,isHot=? where newsId=?";
	PreparedStatement pstmt=con.prepareStatement(sql);
   	pstmt.setString	(1, news.getTitle());
	pstmt.setString	(2, news.getContent());
	pstmt.setString	(3, news.getAuthor());
	pstmt.setInt		(4, news.getTypeId());
	pstmt.setInt		(5, news.getIsHead());
	pstmt.setInt		(6, news.getIsImage());
	pstmt.setString	(7, news.getImageName());
	pstmt.setInt		(8, news.getIsHot());
	pstmt.setInt		(9, news.getNewsId());
	
	return pstmt.executeUpdate();
   	
       }

    public int newsDelete(Connection con,String newsId)throws Exception{
   	String sql="DELETE FROM t_news WHERE newsId=? ";
	PreparedStatement pstmt=con.prepareStatement(sql);
	pstmt.setString(1, newsId);
	return pstmt.executeUpdate();
   	
       }
    
    
    
    
    
}
