package strstd;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Bar extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		try{
		boolean lbs = Boolean.parseBoolean(req.getParameter("l"));
		boolean male = Boolean.parseBoolean(req.getParameter("m"));
		int rep = Integer.parseInt(req.getParameter("r"));
		double wt = Double.parseDouble(req.getParameter("w"));
		double bw = Double.parseDouble(req.getParameter("b"));
		String type = req.getParameter("t");
		Standard s = Standard.getStandard(type, lbs?bw:Converter.kgsToLbs(bw), lbs?wt:Converter.kgsToLbs(wt), male, rep);
		ArrayList<String> grades = new ArrayList<String>();
		for(double d:s.grades){
			grades.add("\""+Converter.c(d, lbs, true)+"\"");
		}
		resp.getWriter().print("{\"target\":\""+type+"\",\"data\":"+"{\"value\":\""+Converter.c(s.calculateORM(),lbs,true)+"\",\"grade\":"+s.grade()+",\"grades\":"+grades.toString()+"}}");
		}
		catch(Exception e){
		}
	}
}
