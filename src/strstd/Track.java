package strstd;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Transaction;
import static org.apache.commons.lang.StringEscapeUtils.escapeHtml;
public class Track extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		try{
		ArrayList<Standard> lifts = new ArrayList<Standard>();
		String [] szLifts = new String[]{"bp","ohp","squat","dl"};
		Key trackKey = (Key)req.getSession().getAttribute("id");
		if(req.getParameter("wt")!=null){
			double wt = Double.parseDouble((String) req.getParameter("wt"));
			if( !(Boolean)(req.getSession().getAttribute("lbs")))
				wt = Converter.kgsToLbs(wt);
			for(String s:szLifts){
				if(req.getParameter(s)!=null){
					double weight =  Double.parseDouble((String) req.getParameter(s+"wt"));
					if( !(Boolean)(req.getSession().getAttribute("lbs")))
						weight = Converter.kgsToLbs(weight);
					lifts.add(Standard.getStandard(s, wt,weight, (Boolean)(req.getSession().getAttribute("sex")), Integer.parseInt((String) req.getParameter(s+"rep"))));
				}
			}
			for(Standard s:lifts){
				s.setBodyWeight(wt);
			}
			Date date=null;
			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			try {
				date = formatter.parse((String) req.getParameter("date"));
			} catch (ParseException e) {
				resp.getWriter().print("1");
				e.printStackTrace();
			}
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Transaction txn = datastore.beginTransaction();
			try{			
				Entity weight = new Entity("Data","weight"+date.getTime(),trackKey);
				weight.setProperty("type", "weight");
				weight.setProperty("weight", wt);
				weight.setProperty("date", date);
				datastore.put(weight);
				for(Standard s:lifts){
					Entity lift = new Entity("Data",s.type+date.getTime(),trackKey);
					lift.setProperty("type", s.type);
					lift.setProperty("rep",s.rep);
					lift.setProperty("wt", s.weight);
					lift.setProperty("bw", s.bodyWeight);
					lift.setProperty("grade", s.grade());
					lift.setProperty("orm", s.oneRepMax);
					lift.setProperty("date",date);
					datastore.put(lift);
				}
				txn.commit();
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally{
				if (txn.isActive()) {
					txn.rollback();
					resp.getWriter().print("1");
				}
				else{
					resp.getWriter().print("0");
				}
			}
		}
		else{
			Date date=null;
			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			try {
				date = formatter.parse((String) req.getParameter("date"));
			} catch (ParseException e) {
				resp.getWriter().print("1");
				e.printStackTrace();
			}
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Transaction txn = datastore.beginTransaction();
			try{
				if(req.getParameter("notes")!=null){
					Entity note = new Entity("Data",trackKey);
					note.setProperty("type","note");
					note.setProperty("string",escapeHtml((String)req.getParameter("notes")));
					note.setProperty("date", date);
					datastore.put(note);
				}
				txn.commit();
			}
			finally{
				if (txn.isActive()) {
					txn.rollback();
					resp.getWriter().print("1");
				}
				else{
					resp.getWriter().print("0");
				}
			}
		}
		}
	
	catch(Exception e){
		resp.getWriter().print("1");
	}
	}
}
