package myservlet;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import net.sf.json.JSONObject;



public class HttpRequestUtil {
	 /**
     * 发起http请求并获取结果
     * @param requestUrl 请求地址
     */
    public static JSONObject getXpath(String requestUrl){
        String res="";
        JSONObject object = null;
        StringBuffer buffer = new StringBuffer();
        try{
            URL url = new URL(requestUrl);
            HttpURLConnection urlCon= (HttpURLConnection)url.openConnection();
            System.out.println("==="+urlCon.getResponseCode());
            if(200==urlCon.getResponseCode()){
                InputStream is = urlCon.getInputStream();
                InputStreamReader isr = new InputStreamReader(is,"utf-8");
                BufferedReader br = new BufferedReader(isr);

                String str = null;
                while((str = br.readLine())!=null){
                    buffer.append(str);
                }
               
                br.close();
                isr.close();
                is.close();
                res = buffer.toString();
                System.out.println("res"+res);
                //JsonParser parse =new JsonParser();
                res=res.replaceAll("\\[", "");
                res=res.replaceAll("\\]", "");
                System.out.println("res"+res);
               object=JSONObject.fromObject(res);
                System.out.println("object"+object);
            }
        }catch(IOException e){
            e.printStackTrace();
        }
        return object;
    }
    public static JSONObject postDownloadJson(String path,JSONObject jsonParam){
        URL url = null;
        JSONObject jobject = null;
        try {
            url = new URL(path);
            HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
            httpURLConnection.setRequestMethod("POST");// 提交模式
            // conn.setConnectTimeout(10000);//连接超时 单位毫秒
            // conn.setReadTimeout(2000);//读取超时 单位毫秒
            // 发送POST请求必须设置如下两行
            // 设置允许输出
            httpURLConnection.setDoOutput(true);
            // 设置允许输入
            httpURLConnection.setDoInput(true);
            
         
            // 设置不用缓存
            httpURLConnection.setUseCaches(false);
                               
            // 设置维持长连接
            httpURLConnection.setRequestProperty("Connection", "Keep-Alive");
            // 设置文件字符集:
            httpURLConnection.setRequestProperty("Charset", "UTF-8");
            httpURLConnection.setRequestProperty("contentType", "application/json");
            // 开始连接请求
            httpURLConnection.connect();
            // 获取URLConnection对象对应的输出流
            PrintWriter printWriter = new PrintWriter(httpURLConnection.getOutputStream());
            // 发送请求参数
            printWriter.write(jsonParam.toString());//post的参数 xx=xx&yy=yy
            // flush输出流的缓冲
            printWriter.flush();
           
            if (HttpURLConnection.HTTP_OK ==  httpURLConnection.getResponseCode()){
				System.out.println("连接成功");
            //开始获取数据
            BufferedInputStream bis = new  BufferedInputStream(httpURLConnection.getInputStream());
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            int len;
            byte[] arr = new byte[1024];
            while((len=bis.read(arr))!= -1){
                bos.write(arr,0,len);
                bos.flush();
            }
            bos.close();
            String str=bos.toString();
            str=str.replaceAll("\\[", "");
            str=str.replaceAll("\\]", "");
            System.out.println("bos"+str);
            jobject=JSONObject.fromObject(str);
            return jobject;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobject;
    }
    public static void main(String args [] ) {
    	
    	JSONObject jsonParam = new JSONObject();
    	jsonParam.put("tag", "admin");
		jsonParam.put("location", "11111111111112");
		System.out.println("jsonParam"+jsonParam.toString());
        JSONObject res = null;
       //res = getXpath("http://localhost:8080/cashcodeDt/servletusers?loginName=admin&loginPwd=admin");
        res = postDownloadJson("http://localhost:8080/cashcodehz/dealtag",jsonParam);
        System.out.println(res);
       // System.out.println(res.get("banksn"));
        //System.out.println(res.get("username"));
    }
}
