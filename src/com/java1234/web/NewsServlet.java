package com.java1234.web;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.java1234.dao.CommentDao;
import com.java1234.dao.NewsDao;
import com.java1234.dao.NewsTypeDao;
import com.java1234.model.Comment;
import com.java1234.model.News;
import com.java1234.model.NewsType;
import com.java1234.model.PageBean;
import com.java1234.util.DateUtil;
import com.java1234.util.DbUtil;
import com.java1234.util.NavUtil;
import com.java1234.util.PageUtil;
import com.java1234.util.PropertiesUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

public class NewsServlet extends HttpServlet {

    /**
     * 各栏目servlet
     */
    private static final long serialVersionUID = 1L;

    DbUtil dbUtil = new DbUtil();
    NewsDao newsDao = new NewsDao();
    NewsTypeDao newsTypeDao = new NewsTypeDao();
    CommentDao commentDao = new CommentDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {

	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	if ("list".equals(action)) {
	    this.newsList(request, response);
	} else if ("show".equals(action)) {
	    this.newsShow(request, response);
	} else if ("preSa11ve".equals(action)) {
	    this.newsPreSa11ve(request, response);
	} else if ("sa11ve".equals(action)) {
	    this.newsSa11ve(request, response);
	}else if ("backList".equals(action)) {
	     newsBackList(request, response);	//后台查询
	} else if ("delete".equals(action)) {
	    newsDelete(request, response);		//删除
	}
	
	
	
	
    }

    private void newsShow(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	String newsId = request.getParameter("newsId");
	Connection con = null;
	try {
	    con = dbUtil.getCon();
	    News news = newsDao.getNewsById(con, newsId);
	    Comment s_comment=new Comment();
	    newsDao.newsClick(con, newsId);
	    s_comment.setNewsId(Integer.parseInt(newsId));
	    List<Comment> commentList=commentDao.commentList(con, s_comment,null,null,null);
	    
	    // news.setClick(news.getClick()+newsDao.newsClick(con, newsId));
	    String navCode = NavUtil.genNewsNavgation(news.getTypeName(), Integer.toString(news.getTypeId()),
		    news.getTitle());
	    
	    request.setAttribute("commentList", commentList);
	    request.setAttribute("news", news);
	    request.setAttribute("navCode", navCode);
	    request.setAttribute("upAndDownPageCode",
		    this.genUpAndDownPageCode(newsDao.getUpAndDownPageId(con, newsId)));
	    request.setAttribute("mainPage", "news/newsShow.jsp");
	    request.getRequestDispatcher("/foreground/newsTemp.jsp").forward(request, response);
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
    }

    public void newsList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String typeId = request.getParameter("typeId");
	String page = request.getParameter("page");
	if (StringUtil.isEmpty(page)) {
	    page = "1";
	}
	Connection con = null;
	News s_news = new News();
	if (StringUtil.isNotEmpty(typeId)) {
	    s_news.setTypeId(Integer.parseInt(typeId));
	}

	try {
	    con = dbUtil.getCon();
	    int total = newsDao.newsCount(con, s_news,null,null);
	    String pageCode = PageUtil.getUpAndDownPagation(total, Integer.parseInt(page),
		    Integer.parseInt(PropertiesUtil.getValue("pageSize")), typeId);
	    // PageBean实例化
	    PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil
		    .getValue("pageSize")));
	    List<News> newestNewsListWithType = newsDao.newsList(con, s_news, pageBean,null,null);
	    request.setAttribute("newestNewsListWithType", newestNewsListWithType);
	    NewsType newsType = newsTypeDao.getNewsTypeById(con, typeId);
	    String navCode = NavUtil.genNewsListNavigation(newsType.getTypeName(), typeId);
	    request.setAttribute("navCode", navCode);
	    request.setAttribute("pageCode", pageCode);
	    request.setAttribute("mainPage", "news/newsList.jsp");
	    request.getRequestDispatcher("/foreground/newsTemp.jsp").forward(request, response);
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
    }

    private String genUpAndDownPageCode(List<News> upAndDownPage) {
	News upNews = upAndDownPage.get(0);
	News downNews = upAndDownPage.get(1);
	StringBuffer upAndDownPageCode = new StringBuffer();
	if (upNews.getNewsId() == -1) {
	    upAndDownPageCode.append("<p>上一篇：没有了</p>");
	} else {
	    upAndDownPageCode.append("<p>上一篇：<a href='news?action=show&newsId=" + upNews.getNewsId() + "'>"
		    + upNews.getTitle() + "</a></p>");
	}

	if (downNews.getNewsId() == -1) {
	    upAndDownPageCode.append("<p>下一篇：没有了</p>");
	} else {
	    upAndDownPageCode.append("<p>下一篇：<a href='news?action=show&newsId=" + downNews.getNewsId() + "'>"
		    + downNews.getTitle() + "</a></p>");
	}

	return upAndDownPageCode.toString();
    }

    
    public void newsPreSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	Connection con = null;
	String newsId=request.getParameter("newsId");
	try {
	    con = dbUtil.getCon();
	    
	    if(StringUtil.isNotEmpty(newsId)){
		//当newsId不为空时  进行更新操作  设置值
		News news=newsDao.getNewsById(con, newsId);
		request.setAttribute("news", news);
	    }
	    List<NewsType> newsTypeList=newsTypeDao.newsTypeList(con);
	    request.setAttribute("newsTypeList", newsTypeList);//发送新闻类别列表
	    
	    if(StringUtil.isNotEmpty(newsId)){//设置小导航条
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻管理", "新闻维护"));
	    }else{
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻管理", "新闻添加"));
	    }
	    request.setAttribute("mainPage", "/background/news/newsSa11ve.jsp");
	    request.getRequestDispatcher("/background/mainTemp.jsp").forward(request, response);
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
    }
    
    
    @SuppressWarnings("unchecked")
    public void newsSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	//二进制流
	FileItemFactory factory =new DiskFileItemFactory();
	ServletFileUpload upload=new ServletFileUpload(factory);
	List<FileItem> items=null;
	try {
	    items=upload.parseRequest(request);
	} catch (Exception e) {
	    e.printStackTrace();
	}
	Iterator<FileItem> itr=items.iterator();//遍历器
	News news=new News();
	while(itr.hasNext()){
	    FileItem  item= (FileItem) itr.next();
	    if(item.isFormField()){
		//判断item封装的数据是一个普通文本表单字段，
		//还是一个文件上传表单字段，
		//如果是普通表单字段则返回true，否则返回false
		String fieldName=item.getFieldName();
		if("newsId".equals(fieldName)){
		    if(StringUtil.isNotEmpty(item.getString("utf-8"))){
			news.setNewsId(Integer.parseInt(item.getString("utf-8")));
		    }
		}
		if("title".equals(fieldName)){
		    news.setTitle(item.getString("utf-8"));
		}
		if("content".equals(fieldName)){
		    news.setContent(item.getString("utf-8"));
		}
		if("author".equals(fieldName)){
		    news.setAuthor(item.getString("utf-8"));
		}
		if("typeId".equals(fieldName)){
		    news.setTypeId(Integer.parseInt(item.getString("utf-8")));
		}
		if("isHead".equals(fieldName)){
		    news.setIsHead(Integer.parseInt(item.getString("utf-8")));
		}
		if("isImage".equals(fieldName)){
		    news.setIsImage(Integer.parseInt(item.getString("utf-8")));
		}
		
		if("isHot".equals(fieldName)){
		    news.setIsHot(Integer.parseInt(item.getString("utf-8")));
		}
		
		if("imageName".equals(fieldName)&&news.getImageName()==null){
		    //当接受到imageName并且news中imageName为空时
		    if(StringUtil.isNotEmpty(item.getString("utf-8"))){
			news.setImageName(item.getString("utf-8").split("/")[1]);
		    }
		}
	    }else  if(!"".equals(item.getName())){
		try {
		    String imageName=DateUtil.getCurrentDateStr();
		    news.setImageName(imageName+"."+item.getName().split("\\.")[1]);
		    String filePath=PropertiesUtil.getValue("imagePath")+imageName+"."+item.getName().split("\\.")[1];									
		    item.write(new File(filePath));
		} catch (Exception e) {
		    e.printStackTrace();
		}
	    }
	}
	
	Connection con=null;
	try {
	    con=dbUtil.getCon();
	    if(news.getNewsId()==0){
		newsDao.newsAdd(con, news);
	    }else {
		newsDao.newsUpdate(con, news);
	    }
	    
	    
	   // System.out.println("新闻添加成功");
	   // request.setAttribute("mainPage", "/background/default.jsp");
	    request.getRequestDispatcher("/news?action=backList").forward(request, response);
	    
	    
	} catch (Exception e) {
	    e.printStackTrace();
	}finally{
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
	
	
	
	
      }
      
    public void newsBackList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//String newsId = request.getParameter("newsId");
  	String page = request.getParameter("page");
  	String s_bPublishDate=request.getParameter("s_bPublishDate");
  	String s_aPublishDate=request.getParameter("s_aPublishDate");
  	String s_title=request.getParameter("s_title");
  	String s_author=request.getParameter("s_author");
  	
  	HttpSession session = request.getSession();
	
	if (StringUtil.isEmpty(page)) {
	    page = "1";
	    session.setAttribute("s_bPublishDate", s_bPublishDate);
	    session.setAttribute("s_aPublishDate", s_aPublishDate);
	    session.setAttribute("s_title", s_title);
	    session.setAttribute("s_author", s_author);
	} else {
	   
	    s_bPublishDate = (String) session.getAttribute("s_bPublishDate");
	    s_aPublishDate = (String) session.getAttribute("s_aPublishDate");
	    s_title = (String) session.getAttribute("s_title");
	    s_author = (String) session.getAttribute("s_author");
	}
	Connection con=null;
	News s_news=new News();//用作查询的对象s_news
	if(StringUtil.isNotEmpty(s_title)){
	    s_news.setTitle(s_title);
	}
	if(StringUtil.isNotEmpty(s_author)){
	    s_news.setAuthor(s_author);
	}
	try {
	    con = dbUtil.getCon();
	    int total = newsDao.newsCount(con, s_news, s_bPublishDate, s_aPublishDate);
	    String pageCode = PageUtil.getPagation(request.getContextPath() + "/news?action=backList", total,
		    Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("backPageSize")));

	    // PageBean实例化
	    PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil
		    .getValue("backPageSize")));

	    List<News> newsBackList = newsDao.newsList(con, s_news, pageBean, s_bPublishDate, s_aPublishDate);

	    request.setAttribute("pageCode", pageCode);
	    request.setAttribute("newsBackList", newsBackList);
	    request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻管理", "新闻维护"));
	    request.setAttribute("mainPage", "/background/news/newsList.jsp");
	    request.getRequestDispatcher("/background/mainTemp.jsp").forward(request, response);

	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
      }
    
    
    public void newsDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	
	String newsId = request.getParameter("newsId");
	Connection con = null;
	Boolean delFlag;
	try {
	    con = dbUtil.getCon();
	    int delNums = newsDao.newsDelete(con, newsId);
	    
	    if (delNums== 1) {
		delFlag=true;
	    } else {
		delFlag=false;
	    }
	    
	    ResponseUtil.write(delFlag, response);// 输出流
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
	
      }
    
    
}
