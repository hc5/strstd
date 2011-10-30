package strstd;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.*;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;

@SuppressWarnings("serial")
public class StrengthstandardServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		resp.setContentType("text/plain");
		PrintWriter out = resp.getWriter();
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		Key key = KeyFactory.createKey("User", "1");
		String [] nd = new String[]{
				"1/15/2011",
				"1/16/2011",
				"1/17/2011",
				"1/19/2011",
				"1/20/2011",
				"1/23/2011",
				"1/25/2011",
				"1/26/2011",
				"1/27/2011",
				"1/28/2011",
				"1/29/2011",
				"1/30/2011",
				"1/31/2011",
				"2/01/2011",
				"2/02/2011",
				"2/03/2011",
				"2/05/2011",
				"2/07/2011",
				"2/08/2011",
				"2/09/2011",
				"2/10/2011",
				"2/11/2011",
				"2/12/2011",
				"2/15/2011",
				"2/16/2011",
				"2/18/2011",
				"2/20/2011",
				"2/21/2011",
				"2/22/2011",
				"2/23/2011",
				"2/24/2011",
				"2/28/2011",
				"3/01/2011",
				"3/02/2011",
				"3/03/2011",
				"3/05/2011",
				"3/06/2011",
				"3/07/2011",
				"3/08/2011",
				"3/10/2011",
				"3/12/2011",
				"3/13/2011",
				"3/14/2011",
				"3/15/2011",
				"3/16/2011",
				"3/17/2011",
				"3/18/2011",
				"3/19/2011",
				"3/20/2011",
				"3/21/2011",
				"3/25/2011",
				"3/26/2011",
				"3/27/2011",
				"3/28/2011"
		};
		double l[] = new double[nd.length];
		for(int i =0;i<l.length;i++)
			l[i]=110+i*2*Math.random();
		for(int i =0;i<nd.length;i++){
			try {
				testLift(key,formatter.parse(nd[i]),new Benchpress(true,l[i],100+i*Math.random(),5));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		for(int i =0;i<nd.length;i++){
			try {
				testLift(key,formatter.parse(nd[i]),new Squat(true,l[i],140+i*Math.random(),5));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		for(int i =0;i<nd.length;i++){
			try {
				testLift(key,formatter.parse(nd[i]),new Deadlift(true,l[i],140+i*Math.random(),5));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		for(int i =0;i<nd.length;i++){
			try {
				testLift(key,formatter.parse(nd[i]),new Press(true,l[i],50+i*Math.random(),5));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		for(int i =0;i<nd.length;i++){
			try {
				testWeight(key,formatter.parse(nd[i]),l[i]);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		for(int i =0;i<nd.length;i+=(int)(Math.random()*1000)%10){
			try {
				testNote(key,formatter.parse(nd[i]));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
	}
	public void testNote(Key trackKey,Date d){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Transaction txn = datastore.beginTransaction();
		try{

			Entity note = new Entity("Data",trackKey);
			note.setProperty("type","note");
			note.setProperty("string","Test"+Math.random());
			note.setProperty("date",d);
			datastore.put(note);
			txn.commit();
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			if (txn.isActive()) {
				System.out.print("1");
			}

		}
	}
	public void testLift(Key trackKey,Date d,Standard s){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Transaction txn = datastore.beginTransaction();
		try{
			Entity lift = new Entity("Data",trackKey);

			lift.setProperty("type", s.type);
			lift.setProperty("rep",s.rep);
			lift.setProperty("wt", s.weight);
			lift.setProperty("bw", s.bodyWeight);
			lift.setProperty("grade", s.grade());
			lift.setProperty("orm", s.oneRepMax);
			lift.setProperty("date",d);
			datastore.put(lift);
			txn.commit();
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			if (txn.isActive()) {
				System.out.print("1");
			}

		}
	}
	public void testWeight(Key trackKey,Date d,double wt){
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Transaction txn = datastore.beginTransaction();
		try{
			Entity weight = new Entity("Data",trackKey);

			weight.setProperty("type", "weight");
			weight.setProperty("weight", wt);
			weight.setProperty("date", d);
			datastore.put(weight);
			txn.commit();
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			if (txn.isActive()) {
				System.out.print("1");
			}

		}
	}
}
