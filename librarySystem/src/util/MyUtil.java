package util;

import java.io.ByteArrayOutputStream;

public class MyUtil {

	//转化字符串为十六进制编码  
	public static String toHexString(String s) {  
	   String str = "";  
	   for (int i = 0; i < s.length(); i++) {  
	    int ch = (int) s.charAt(i);  
	    String s4 = Integer.toHexString(ch);  
	    str = str + s4;  
	   }  
	   return str;  
	}  
	// 转化十六进制编码为字符串  
	public static String toStringHex1(String s) {  
	   byte[] baKeyword = new byte[s.length() / 2];  
	   for (int i = 0; i < baKeyword.length; i++) {  
	    try {  
	     baKeyword[i] = (byte) (0xff & Integer.parseInt(s.substring(i * 2, i * 2 + 2), 16));  
	    } catch (Exception e) {  
	     e.printStackTrace();  
	    }  
	   }  
	   try {  
	    s = new String(baKeyword, "utf-8");// UTF-16le:Not  
	   } catch (Exception e1) {  
	    e1.printStackTrace();  
	   }  
	   return s;  
	}  
	// 转化十六进制编码为字符串  
	public static String toStringHex2(String s) {  
	   byte[] baKeyword = new byte[s.length() / 2];  
	   for (int i = 0; i < baKeyword.length; i++) {  
	    try {  
	     baKeyword[i] = (byte) (0xff & Integer.parseInt(s.substring(  
	       i * 2, i * 2 + 2), 16));  
	    } catch (Exception e) {  
	     e.printStackTrace();  
	    }  
	   }  
	   try {  
	    s = new String(baKeyword, "utf-8");// UTF-16le:Not  
	   } catch (Exception e1) {  
	    e1.printStackTrace();  
	   }  
	   return s;  
	}  
	public static void main(String[] args) {  
	   System.out.println("----"); 
	   System.out.println(toStringHex2("3039"));  
	   System.out.println(toStringHex2("3031"));
	   System.out.println(toStringHex2("3032"));
	   System.out.println(toStringHex2("3033"));
	   System.out.println(toStringHex2("3036333139313132373135343832363A323A353A31333A61646D696E3A6668790D0A"));
	   System.out.println(toStringHex1("3237"));  
	   System.out.println("----"); 
	   System.out.println(toHexString("27"));
//	   String str="1481B68B3131";
//	   System.out.println(str.substring(0, 9));
//	   System.out.println(str.substring(str.length()-4, str.length()));
	}  
	/* 
	* 16进制数字字符集 
	*/  
	private static String hexString = "0123456789ABCDEF";  
	/* 
	* 将字符串编码成16进制数字,适用于所有字符（包括中文） 
	*/  
	public static String encode(String str) {  
	   // 根据默认编码获取字节数组  
	   byte[] bytes = str.getBytes();  
	   StringBuilder sb = new StringBuilder(bytes.length * 2);  
	   // 将字节数组中每个字节拆解成2位16进制整数  
	   for (int i = 0; i < bytes.length; i++) {  
	    sb.append(hexString.charAt((bytes[i] & 0xf0) >> 4));  
	    sb.append(hexString.charAt((bytes[i] & 0x0f) >> 0));  
	   }  
	   return sb.toString();  
	}  
	/* 
	* 将16进制数字解码成字符串,适用于所有字符（包括中文） 
	*/  
	public static String decode(String bytes) {  
	   ByteArrayOutputStream baos = new ByteArrayOutputStream(  
	     bytes.length() / 2);  
	   // 将每2位16进制整数组装成一个字节  
	   for (int i = 0; i < bytes.length(); i += 2)  
	    baos.write((hexString.indexOf(bytes.charAt(i)) << 4 | hexString  
	      .indexOf(bytes.charAt(i + 1))));  
	   return new String(baos.toByteArray());  
	}  

}
