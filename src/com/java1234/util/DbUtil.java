package com.java1234.util;

import java.sql.Connection;
import java.sql.DriverManager;
public class DbUtil {

    public Connection getCon() throws Exception {
	Class.forName(PropertiesUtil.getValue("jdbcName"));
	Connection con=DriverManager.getConnection(PropertiesUtil.getValue("dbUrl"), PropertiesUtil.getValue("dbUserName"), PropertiesUtil.getValue("dbPassword"));
	
	return con;
    }
    
    public void closeCon(Connection con) throws Exception {
	if(con!=null){
		con.close();
	}
    }
    public static void main(String[] args) {
	DbUtil dbUtil=new DbUtil();
	Connection con=null;
	try {
	    con=dbUtil.getCon();
	    System.out.println("OK");
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
	try {
	    dbUtil.closeCon(con);
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
    }
}
