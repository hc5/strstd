package strstd;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.KeyFactory;


public class namecheck extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String id = req.getParameter("u").toLowerCase();
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 try {
			Entity user = datastore.get(KeyFactory.createKey("User", id));
			resp.getWriter().print("NO");
		} catch (EntityNotFoundException e) {
			resp.getWriter().print("OK");
		}
	}
}
