package strstd;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class Remove extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String id = (String)req.getParameter("point");
		Key remove = KeyFactory.stringToKey(id);
		if(((Key)(req.getSession().getAttribute("id"))).equals(remove.getParent())){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.delete(remove);
		}
	}
}
