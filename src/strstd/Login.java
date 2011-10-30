package strstd;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.google.appengine.api.datastore.*;
import com.google.appengine.api.memcache.Expiration;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;



public class Login extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		
		try {
			String id = req.getParameter("u").toLowerCase();
			String password = SHA1.SHA1(req.getParameter("p"));
			 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Entity user = datastore.get(KeyFactory.createKey("User", id));
			if(password.equals(user.getProperty("pass"))){
				
				String sessionId = SHA1.SHA1(id+Calendar.getInstance().getTime().getTime());
				Cookie c = new Cookie("sessionId",sessionId);
				resp.addCookie(c);
				resp.setContentType("text/plain");
				MemcacheService ms = MemcacheServiceFactory.getMemcacheService();
				Date currentDate = Calendar.getInstance().getTime();
				currentDate.setTime(currentDate.getTime()+1814000000);
				ms.put(sessionId, user.getProperty("name"),Expiration.onDate(currentDate));
				req.getSession().setAttribute("currentUser", user.getProperty("name"));
				req.getSession().setAttribute("id", user.getKey());
				req.getSession().setAttribute("loggedIn", true);
				req.getSession().setAttribute("lbs", user.getProperty("lbs"));
				req.getSession().setAttribute("sex", user.getProperty("sex"));
				resp.getWriter().print("success");
			}
			else{
				resp.setContentType("text/plain");
				resp.getWriter().print("wrong pass");
			}
		} catch (NoSuchAlgorithmException e) {
		
			e.printStackTrace();
		} catch (EntityNotFoundException e) {
			resp.setContentType("text/plain");
			resp.getWriter().print("failure");
		}
	}
}
