package com.java1234.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {
    public static String getValue(String key) {
	Properties prop = new Properties();
	// 通过输入流获取配置文件中的值
	InputStream in = new PropertiesUtil().getClass().getResourceAsStream("/news.properties");
	try {
	    prop.load(in);
	} catch (IOException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
	return prop.getProperty(key);
    }
}
