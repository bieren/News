package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import com.java1234.dao.CommentDao;
import com.java1234.model.Comment;
import com.java1234.model.PageBean;
import com.java1234.util.DbUtil;
import com.java1234.util.NavUtil;
import com.java1234.util.PageUtil;
import com.java1234.util.PropertiesUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

public class CommentServlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    DbUtil dbUtil = new DbUtil();

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
	if ("sa11ve".equals(action)) {
	    this.commentSa11ve(request, response);
	} else if ("backList".equals(action)) {
	    this.commentBackList(request, response);
	} else if ("delete".equals(action)) {
	    this.commentDelete(request, response);
	}

    }

    public void commentSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	String newsId = request.getParameter("newsId");
	String content = request.getParameter("content");
	String userIP = request.getRemoteAddr();
	Connection con = null;
	Comment comment = new Comment(Integer.parseInt(newsId), content, userIP);
	try {
	    con = dbUtil.getCon();
	    commentDao.commentAdd(con, comment);
	    request.getRequestDispatcher("news?action=show&newsId=" + newsId).forward(request, response);
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    try {
		dbUtil.closeCon(con);
	    } catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    }
	}
    }

    public void commentBackList(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	Connection con = null;
	String s_bCommentDate = request.getParameter("s_bCommentDate");
	String s_aCommentDate = request.getParameter("s_aCommentDate");
	HttpSession session = request.getSession();
	
	String page = request.getParameter("page");
	if (StringUtil.isEmpty(page)) {
	    page = "1";
	    session.setAttribute("s_bCommentDate", s_bCommentDate);
	    session.setAttribute("s_aCommentDate", s_aCommentDate);
	} else {
	    // 当page不为空时 默认进行分页操作 以下非常重要 否则 查询操作无法正常运行
	    /*
	     * 该sql语句为CommentDao.commentList(...)中调试输出 若s_bCommentDate
	     * s_aCommentDate不从session中获取 页面跳转时就会依次出现下列五行sql语句的2、3、4、5情况
	     * 
	     * SELECT * FROM t_comment t1,t_news t2 where t1.newsId=t2.newsId
	     * and TO_DAYS(t1.commentDate) >= TO_DAYS('2016-09-05') and
	     * TO_DAYS(t1.commentDate) <= TO_DAYS('2016-09-10') order by
	     * t1.commentDate desc Limit 0,7 SELECT * FROM t_comment t1,t_news
	     * t2 where t1.newsId=t2.newsId and TO_DAYS(t1.commentDate) >=
	     * TO_DAYS('2016-09-05') and TO_DAYS(t1.commentDate) <=
	     * TO_DAYS('2016-09-19') order by t1.commentDate desc Limit 0,7
	     * SELECT * FROM t_comment t1,t_news t2 where t1.newsId=t2.newsId
	     * order by t1.commentDate desc Limit 7,7 SELECT * FROM t_comment
	     * t1,t_news t2 where t1.newsId=t2.newsId order by t1.commentDate
	     * desc Limit 14,7 SELECT * FROM t_comment t1,t_news t2 where
	     * t1.newsId=t2.newsId order by t1.commentDate desc Limit 21,7
	     */
	    s_bCommentDate = (String) session.getAttribute("s_bCommentDate");
	    s_aCommentDate = (String) session.getAttribute("s_aCommentDate");
	}

	try {
	    con = dbUtil.getCon();
	    Comment s_comment = new Comment();
	    int total = commentDao.commentCount(con, s_comment, s_bCommentDate, s_aCommentDate);
	    String pageCode = PageUtil.getPagation(request.getContextPath() + "/comment?action=backList", total,
		    Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("backPageSize")));

	    // PageBean实例化
	    PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil
		    .getValue("backPageSize")));

	    List<Comment> commentBackList = commentDao.commentList(con, s_comment, pageBean, s_bCommentDate,
		    s_aCommentDate);

	    request.setAttribute("pageCode", pageCode);
	    request.setAttribute("commentBackList", commentBackList);
	    request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻评论管理", "新闻评论维护"));
	    request.setAttribute("mainPage", "/background/comment/commentList.jsp");
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

    private void commentDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	String commentIds = request.getParameter("commentIds");
	//CommentDao commentDao = new CommentDao();
	Connection con = null;
	try {
	    con = dbUtil.getCon();
	    JSONObject result = new JSONObject();
	    int delNums = commentDao.commentDelete(con, commentIds);
	    if (delNums > 0) {
		result.put("success", true);
		result.put("delNums", delNums);
	    } else {
		result.put("errorMsg", "删除失败！");
	    }
	    ResponseUtil.write(result, response);// 输出流
	    //request.setAttribute("mainPage", "/background/default.jsp");
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