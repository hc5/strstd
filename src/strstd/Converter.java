package strstd;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Converter {
	public static double lbsToKgs(double lb){
		return lb/2.20462262;

	}
	public static double kgsToLbs(double kg){
		return kg*2.20462262;
	}
	public static int round5(int i){
		
		 return ((i % 5) >= 2.5) ?((i / 5) * 5 + 5 ):( (i / 5) * 5);
	}
	public static String getDate(){
		  DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
	        Date date = new Date();
	        return dateFormat.format(date);
	}
	public static String getDate(Date date){
		  DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
	      //  Date date = new Date();
	        return dateFormat.format(date);
	}
	public static String getJSDate(Date date){
		DateFormat month = new SimpleDateFormat("MM");
		int mm = Integer.parseInt(month.format(date))-1;
		DateFormat year = new SimpleDateFormat("yyyy");
		int yyyy = Integer.parseInt(year.format(date));
		DateFormat day = new SimpleDateFormat("dd");
		int dd = Integer.parseInt(day.format(date));
		String d = "Date.UTC("+yyyy+","+mm+","+(dd)+")";
		
		return d;
 	}
	public static  String c(double d,boolean lbs,boolean extension){
		if(extension)
		return lbs?(int)d+" lbs":(int)lbsToKgs(d)+" kgs";
		else
			return lbs?(int)d+"":(int)lbsToKgs(d)+"";
	}
	public static  String c(String d,boolean lbs,boolean extension){
		if(extension)
		return lbs?(int)Double.parseDouble(d)+" lbs":(int)lbsToKgs(Double.parseDouble(d))+" kgs";
		else
			return lbs?(int)Double.parseDouble(d)+"":(int)lbsToKgs(Double.parseDouble(d))+"";
	}
	public static  String c(Object d,boolean lbs,boolean extension){
		String ext;
		if(lbs)
			ext=" lbs";
		else
			ext=" kgs";
		if(!extension)
			ext="";
		try{
		
		return lbs?(int)Double.parseDouble((String)d)+ext:(int)lbsToKgs(Double.parseDouble((String)d))+ext;
		}
		catch(ClassCastException e){
			return lbs?((Double)d).intValue()+ext:(int)lbsToKgs((Double)d)+ext;
		}
	}
	public static String getSet(double orm, double percent, int rep,boolean lbs){
		return round5((int)(orm*percent))+" "+(lbs?"lbs":"kgs")+" x "+rep;
	
	}
	public static String getSet(double orm, double percent, int rep,String append,boolean lbs){
		return round5((int)(orm*percent))+" "+(lbs?"lbs":"kgs")+" x "+rep+append;
	}
}
