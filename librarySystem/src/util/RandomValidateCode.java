package util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public  class  RandomValidateCode {
	 
	    private int width = 30;// 图片宽  
	    private int height = 260;// 图片高  
	  
	   
	    /** 
	     * 生成随机图片 
	     */  
	    public void toImg(String mess) {
	    	 int wideth=50;
		     int height=260;
		     
		     BufferedImage img = new BufferedImage(height, wideth,
		       BufferedImage.TYPE_INT_RGB);//构造一个类型为预定义图像类型之一的 BufferedImage。
		     Graphics2D g2d = img.createGraphics();
		     g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,1.0f));  // 1.0f为透明度 ，值从0-1.0，依次变得不透明
		     g2d.setFont(new Font("宋体 ", 0, 30));
		     g2d.setColor(Color.WHITE);
		     g2d.fillRect(0, 0, img.getWidth(),img.getHeight());//填充制定的矩形
		     g2d.setColor(Color.BLACK);//将此图形上下文的当前颜色设置为指定颜色。
		     g2d.drawString(mess,15,35);

		     try {
		      OutputStream out = new BufferedOutputStream(new FileOutputStream("d:/cashcode.jpg"), 4096);
		      JPEGImageEncoder coder = JPEGCodec.createJPEGEncoder(out);
		      coder.encode(img);
		      out.close();
		     } catch (Exception e) {
		      e.printStackTrace();
		     }
		    }
	   
	}  