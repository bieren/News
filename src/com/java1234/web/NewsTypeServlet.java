package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.java1234.dao.NewsDao;
import com.java1234.dao.NewsTypeDao;
import com.java1234.model.NewsType;
import com.java1234.util.DbUtil;
import com.java1234.util.NavUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

public class NewsTypeServlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    DbUtil dbUtil = new DbUtil();
    NewsTypeDao newsTypeDao = new NewsTypeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");

	if ("preSa11ve".equals(action)) { // 预添加
	    newsTypePreSa11ve(request, response);
	} else if ("sa11ve".equals(action)) { // 保存
	    newsTypeSa11ve(request, response);
	} else if ("backList".equals(action)) { // 查询
	    newsTypeBackList(request, response);
	} else if ("delete".equals(action)) { // 删除
	    newsTypeDelete(request, response);
	}

    }

    private void newsTypeSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	String newsTypeId = request.getParameter("newsTypeId");
	String typeName = request.getParameter("typeName");

	NewsType newsType = new NewsType(typeName);
	Connection con = null;

	if (StringUtil.isNotEmpty(newsTypeId)) {
	    // 当newsTypeId不为空时 进行更新操作 设置newsTypeId值
	    newsType.setNewsTypeId(Integer.parseInt(newsTypeId));
	}
	try {
	    con = dbUtil.getCon();
	    if (StringUtil.isNotEmpty(newsTypeId)) {
		// 当newsTypeId不为空时 进行更新操作
		newsTypeDao.newsTypeUpdate(con, newsType);
	    } else {
		newsTypeDao.newsTypeAdd(con, newsType);
	    }
	    request.setAttribute("mainPage", "/background/default.jsp");
	    request.getRequestDispatcher("/newsType?action=backList").forward(request, response);
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

    private void newsTypePreSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	Connection con = null;
	String newsTypeId = request.getParameter("newsTypeId");
	try {
	    con = dbUtil.getCon();
	    if (StringUtil.isNotEmpty(newsTypeId)) {
		// 当newsTypeId不为空时 进行更新操作 设置值
		NewsType newsType = newsTypeDao.getNewsTypeById(con, newsTypeId);
		request.setAttribute("newsType", newsType);
	    }
	    if (StringUtil.isNotEmpty(newsTypeId)) {// 设置小导航条
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻类别管理", "新闻类别修改"));
	    } else {
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻类别管理", "新闻类别添加"));
	    }
	    request.setAttribute("mainPage", "/background/newsType/newsTypeSa11ve.jsp");
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

    private void newsTypeBackList(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	Connection con = null;
	try {
	    con = dbUtil.getCon();
	    List<NewsType> newsTypeBackList = newsTypeDao.newsTypeList(con);
	    request.setAttribute("newsTypeBackList", newsTypeBackList);
	    request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻类别管理", "新闻类别维护"));
	    request.setAttribute("mainPage", "/background/newsType/newsTypeList.jsp");
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

    private void newsTypeDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	String newsTypeId = request.getParameter("newsTypeId");
	NewsDao newsDao = new NewsDao();
	Connection con = null;
	try {
	    con = dbUtil.getCon();
	    JSONObject result = new JSONObject();//
	    if (newsDao.existNewsWithNewsTypeId(con, newsTypeId)) {
		result.put("errorMsg", "此新闻类别下有新闻，此新闻类别删除失败！");
	    } else {
		int delNums = newsTypeDao.newsTypeDelete(con, newsTypeId);
		if (delNums > 0) {
		    result.put("success", true);
		} else {
		    result.put("errorMsg", "删除失败！");
		}
	    }
	    ResponseUtil.write(result, response);// 输出流
	    request.setAttribute("mainPage", "/background/default.jsp");
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
