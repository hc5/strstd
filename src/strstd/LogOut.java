package strstd;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

public class LogOut extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		Cookie[]cookies = req.getCookies();
		for(Cookie c:cookies){
			if(c.getName().equalsIgnoreCase("sessionId")){
				MemcacheService ms = MemcacheServiceFactory.getMemcacheService();
				ms.delete(c.getValue());
			}
		}
		req.getSession().removeAttribute("currentUser");
		req.getSession().removeAttribute("loggedIn");
		req.getSession().removeAttribute("id");
		req.getSession().removeAttribute("lbs");
		req.getSession().removeAttribute("male");
		Cookie c = new Cookie("sessionId","");
		c.setMaxAge(0);
		resp.addCookie(c);
		resp.sendRedirect("/");
		
	}
}
