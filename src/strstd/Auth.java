package strstd;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.memcache.*;
import com.google.appengine.tools.admin.ConfirmationCallback.Response;

public class Auth implements Filter {
	private FilterConfig filterConfig;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		System.out.println("authenticating...");
		if(req instanceof HttpServletRequest){
			HttpServletRequest request = (HttpServletRequest)req;
			HttpSession session = request.getSession();
			
		}
		 chain.doFilter(req, resp);
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		  this.filterConfig = filterConfig;
		
	}

}
