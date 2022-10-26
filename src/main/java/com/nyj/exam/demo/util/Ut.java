package com.nyj.exam.demo.util;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class Ut {

	public static boolean empty(Object obj) {
		if (obj == null) {
			return true;
		}

		if (obj instanceof String == false) {
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

		char[] list = new char[] { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q',
				'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };
		StringBuffer sb = new StringBuffer();
		Random random = new Random();

		for (int i = 0; i < length; i++) {
			int index = random.nextInt(list.length - 1);
			sb.append(list[index]);
		}

		return sb.toString();
	}

	public static String getDataStrLater(int seconds) {
		// 포맷변경 (년월일 시분초)
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println("---- sdformat ----" + sdformat);

		String dateStr = sdformat.format(System.currentTimeMillis() + seconds * 1000);
		System.out.println("---- dateStr ----" + dateStr);

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
		if (map.containsKey(attrName)) {
			return (String) map.get(attrName);
		}
		return defaultValue;
	}

	public static String getNowYearMonthDateStr() {
		LocalDate now = LocalDate.now();
		String today = now.toString();
		String nowstr = today.replaceAll("-", "");
		return nowstr;
	}

	public static String sha256(String pw, String salt) {
		String result = "";

		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update((pw + salt).getBytes());
			byte[] rs = md.digest();
			result = byteToString(rs);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return result;
	}

	public static String getSalt() {
		byte[] salt = new byte[10];

		// SecureRandom, byte 객체 생성
		SecureRandom sr = new SecureRandom();

		// 난수 생성
		sr.nextBytes(salt);

		return byteToString(salt);
	}

	public static String byteToString(byte[] temp) {
		// byte To String (10진수 문자열 변경)

		StringBuffer sb = new StringBuffer();
		for (byte i : temp) {
			sb.append(String.format("%02x", i));
		}
		return sb.toString();
	}

	public static String getFileExtFromFileName(String fileName) {
		int pos = fileName.lastIndexOf(".");
		String ext = fileName.substring(pos + 1);

		return ext;
	}

	public static String getFileExtTypeCodeFromFileName(String fileName) {
		String exe = getFileExtFromFileName(fileName).toLowerCase();

		switch (exe) {
		case "jpeg":
		case "jpg":
		case "gif":
		case "png":
			return "img";
		case "mp4":
		case "avi":
		case "mov":
			return "video";
		case "mp3":
			return "audio";
		}
		return "etc";

	}

	public static String getFileExtType2CodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
			return "jpg";
		case "gif":
			return ext;
		case "png":
			return ext;
		case "mp4":
			return ext;
		case "mov":
			return ext;
		case "avi":
			return ext;
		case "mp3":
			return ext;
		}

		return "etc";
	}

	public static Map<String, Object> mapOf(Object... args) {
		if (args.length % 2 != 0) {
			throw new IllegalArgumentException("인자를 짝수개 입력해주세요.");
		}

		int size = args.length / 2;

		Map<String, Object> map = new LinkedHashMap<>();

		for (int i = 0; i < size; i++) {
			int keyIndex = i * 2;
			int valueIndex = keyIndex + 1;

			String key;
			Object value;

			try {
				key = (String) args[keyIndex];
			} catch (ClassCastException e) {
				throw new IllegalArgumentException("키는 String으로 입력해야 합니다. " + e.getMessage());
			}

			value = args[valueIndex];

			map.put(key, value);
		}

		return map;
	}

	public static int getAsInt(Object object, int defaultValue) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof Double) {
			return (int) Math.floor((double) object);
		} else if (object instanceof Float) {
			return (int) Math.floor((float) object);
		} else if (object instanceof Long) {
			return (int) object;
		} else if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return defaultValue;
	}

	public static boolean deleteFile(String filePath) {
		 java.io.File ioFile = new java.io.File(filePath);
	        if (ioFile.exists()) {
	            return ioFile.delete();
	        }

        return true;
		
	}

}
