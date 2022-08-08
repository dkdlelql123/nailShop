package com.nyj.exam.demo.util;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class Ut {

	public static boolean empty(Object obj) {
		if(obj == null) {
			return true;
		}
		
		if(obj instanceof String == false) {
			return true;
		}
		
		String str = (String) obj;
		
		return str.trim().length() == 0;
		
	}

	public static String f(String format, Object... args) {
		return String.format(format, args);
	}

	public static String jsHistoryBack(String msg) {
		if (msg == null) {
			msg = "";
		}
		return Ut.f("""
				<script>
				const msg = '%s'.trim();
				if ( msg.length > 0 ) {
				    alert(msg);
				}
				history.back();
				</script>
				""", msg);
	} 

	public static String jsReplace(String msg, String uri) {
		if (msg == null) {
			msg = "";
		}
		if (uri == null) {
			uri = "/";
		}
		return Ut.f("""
				<script>
				const msg = '%s'.trim();
				if ( msg.length > 0 ) {
				    alert(msg);
				}
								
				location.replace('%s');
				</script>
				""", msg, uri);
	 }
	
	 public static String getUriEncoded(String str) {
        try {
            return URLEncoder.encode(str, "UTF-8");
        } catch (Exception e) {
            return str;
        }
    }

	public static String getTempPassword(int length) {

		 char[] list = new char[]{'a', 'b', 'c', 'd', 'e', 'f','g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
		 StringBuffer sb = new StringBuffer();
		 Random random = new Random();
		 
		 for (int i = 0; i < length; i++) {
			 int index = random.nextInt(list.length-1);
			 sb.append(list[index]);
		 }
		
		return sb.toString();
	}

	public static String getDataStrLater(int seconds) { 
		// 포맷변경 (년월일 시분초)
		SimpleDateFormat  sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		System.out.println("---- sdformat ----"+sdformat);

		String dateStr = sdformat.format(System.currentTimeMillis() + seconds * 1000);
		System.out.println("---- dateStr ----"+dateStr);   
		
		return dateStr;		 
	} 
	
	public static Map<String, String> getParamMap(HttpServletRequest request) {
		Map<String, String> param = new HashMap<>();

		Enumeration<String> parameterNames = request.getParameterNames();

		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);

			param.put(paramName, paramValue);
		}

		return param;
	}

	public static String getStrAttr(Map map, String attrName, String defaultValue) {
		if(map.containsKey(attrName)) {
			return (String)map.get(attrName);
		}
		return defaultValue;
	}
	
}
