package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.java1234.dao.LinkDao;
import com.java1234.model.Link;
import com.java1234.util.DbUtil;
import com.java1234.util.NavUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

public class LinkServlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    DbUtil dbUtil = new DbUtil();
    LinkDao linkDao=new LinkDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	    IOException {
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");

	if ("preSa11ve".equals(action)) {
	    linkPreSa11ve(request, response);
	} else if ("sa11ve".equals(action)) {
	    linkSa11ve(request, response);	//����
	} else if ("backList".equals(action)) {
	    linkBackList(request, response);	//��ѯ
	} else if ("delete".equals(action)) {
	    linkDelete(request, response);	//ɾ��
	}

    }

    public void linkPreSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	Connection con = null;
	String linkId=request.getParameter("linkId");
	try {
	    con = dbUtil.getCon();
	    if(StringUtil.isNotEmpty(linkId)){
		//��linkId��Ϊ��ʱ  ���и��²���  ����ֵ
		Link link=linkDao.getLinkById(con, linkId);
		request.setAttribute("link", link);
	    }
	    if(StringUtil.isNotEmpty(linkId)){//����С������
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("�������ӹ���", "���������޸�"));
	    }else{
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("�������ӹ���", "�����������"));
	    }
	    request.setAttribute("mainPage", "/background/link/linkSa11ve.jsp");
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

    public void linkSa11ve(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	String linkId=request.getParameter("linkId");
	String linkName=request.getParameter("linkName");
	String linkUrl=request.getParameter("linkUrl");
	String linkEmail=request.getParameter("linkEmail");
	String orderNum=request.getParameter("orderNum");
	Link link=new Link(linkName, linkUrl, linkEmail, Integer.parseInt(orderNum));
	Connection con = null;
	
	if(StringUtil.isNotEmpty(linkId)){
	    //��linkId��Ϊ��ʱ  ���и��²���  ����linkIdֵ
	    link.setLinkId(Integer.parseInt(linkId));
	}
	try {
	    con = dbUtil.getCon();
	    if(StringUtil.isNotEmpty(linkId)){
		//��linkId��Ϊ��ʱ  ���и��²��� 
		linkDao.linkUpdate(con, link);
	    }else{
		linkDao.linkAdd(con, link);
	    }
	        request.setAttribute("mainPage", "/background/default.jsp");
	        request.getRequestDispatcher("/link?action=backList").forward(request, response);
		//request.getRequestDispatcher("/background/mainTemp.jsp").forward(request,response);
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

    public void linkBackList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String sql="select * from t_link order by orderNum ";
	Connection con = null;
        try {
        	con = dbUtil.getCon();
        	List<Link> linkBackList=linkDao.linkList(con, sql);
        	request.setAttribute("linkBackList", linkBackList);
		request.setAttribute("navCode", NavUtil.genNewsManageNavigation("�������ӹ���", "��������ά��"));
	        request.setAttribute("mainPage", "/background/link/linkList.jsp");
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

    public void linkDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String linkId=request.getParameter("linkId");
	Connection con = null;
	try {
	   con = dbUtil.getCon();
	   JSONObject result=new JSONObject();//
	  int delNums= linkDao.linkDelete(con, linkId);
	  if(delNums>0){
	      result.put("success", true);
	  }else {
	      result.put("errorMsg", "ɾ��ʧ��");
	}
	  ResponseUtil.write(result, response);//�����
	  
	   request.setAttribute("mainPage", "/background/default.jsp");
	   //request.getRequestDispatcher("/background/mainTemp.jsp").forward(request,response);
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
