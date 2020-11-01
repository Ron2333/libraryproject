package filter;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class SessionFilter implements Filter {


	public void destroy() {
		// TODO 自动生成的方法存根
		
	}


	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO 自动生成的方法存根
		HttpServletRequest req = (HttpServletRequest) request;
		String username = (String)req.getSession().getAttribute("userID");
		String basePath = req.getRequestURI();
		 HttpServletResponse resp = (HttpServletResponse) response;
//		System.out.println(req.getRequestURI());
		if(username!=null||basePath.equals("/librarySystem/jm.jsp")||basePath.equals("/librarySystem/index.jsp")||basePath.equals("/librarySystem/")||basePath.equals("/librarySystem/indexlogin.jsp")) {
			//Session中含有用户名
			chain.doFilter(request, response);
		}else {
			//Session中没有用户名，跳转到登录页面
			req.getRequestDispatcher("sessionout.jsp").forward(req, resp);
			//resp.sendRedirect(req.getContextPath()+"/index.jsp");
			return;
		}
	}


	public void init(FilterConfig arg0) throws ServletException {
		// TODO 自动生成的方法存根
		
	}

}
