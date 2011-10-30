package strstd;

import java.util.*;
import static org.apache.commons.lang.StringEscapeUtils.escapeHtml;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;

public class GetData extends Converter {
public Key user;
public double max = 5;
	public GetData(Key user) {
	super();
	this.user = user;
}
	public String getLiftGrade(String type){
		
		boolean lbs;
		StringBuilder sb = new StringBuilder();
		Query dataQuery = new Query("Data");
		if(user==null||type.length()==0||type==null)
			return "[]";
		dataQuery.setAncestor(user);
		dataQuery.addFilter("type", FilterOperator.EQUAL, type);
		dataQuery.addSort("date", SortDirection.ASCENDING);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		try {
			lbs = (Boolean) (datastore.get(user).getProperty("lbs"));
		List<Entity> data = datastore.prepare(dataQuery).asList(FetchOptions.Builder.withDefaults());
		sb.append("[");
		for(Entity e:data){
			String object = "{";
			Map<String,Object> properties = e.getProperties();
			object+="x:"+Converter.getJSDate((Date) properties.get("date"));
			object+=",";
			object+="y:"+properties.get("grade");
			object+=",";
			object+="name:"+"\"One rep max: "+c(properties.get("orm"),lbs,true)+"<br>"
			+properties.get("rep")+" x "+c(properties.get("wt"),lbs,true)+"<br>"
			+"at a bodyweight of "+c(properties.get("bw"),lbs,true)+"\",";
			object+="url:\""+KeyFactory.keyToString(e.getKey())+"\"";
			object+="}";
			sb.append(object);
			sb.append(",");
		}
		if(sb.length()>1)
		sb.setLength(sb.length()-1);
		sb.append("]");
		} catch (EntityNotFoundException e1) {
			return "[]";
		}
		return sb.toString();
	}
	public String getNotes(double n){
		if(n<0){
			n=max;
		}
		boolean lbs;
		StringBuilder sb = new StringBuilder();
		Query dataQuery = new Query("Data");
		if(user==null)
			return "[]";
		dataQuery.setAncestor(user);
		dataQuery.addFilter("type", FilterOperator.EQUAL, "note");
		dataQuery.addSort("date", SortDirection.ASCENDING);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		List<Entity> data = datastore.prepare(dataQuery).asList(FetchOptions.Builder.withDefaults());
		sb.append("[");
		for(Entity e:data){
			String object = "{";
			Map<String,Object> properties = e.getProperties();
			object+="x:"+Converter.getJSDate((Date) properties.get("date"));
			object+=",";
			object+="y:"+n;
			object+=",";
			object+="name:\""+(properties.get("string").toString())+"\",";
			
			object+="url:\""+KeyFactory.keyToString(e.getKey())+"\"";
			object+="}";
			sb.append(object);
			sb.append(",");
		}
		if(sb.length()>1)
		sb.setLength(sb.length()-1);
		sb.append("]");
		return sb.toString();
	}
public String getLift(String type){
		 
		boolean lbs;
		StringBuilder sb = new StringBuilder();
		Query dataQuery = new Query("Data");
		if(user==null||type.length()==0||type==null){
			
			return "[]";
		}
		dataQuery.setAncestor(user);
		dataQuery.addFilter("type", FilterOperator.EQUAL, type);
		dataQuery.addSort("date", SortDirection.ASCENDING);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		try {
			lbs = (Boolean) (datastore.get(user).getProperty("lbs"));
		List<Entity> data = datastore.prepare(dataQuery).asList(FetchOptions.Builder.withDefaults());
		sb.append("[");
		for(Entity e:data){
			
			String object = "{";
			Map<String,Object> properties = e.getProperties();
			if((Double)properties.get("orm")>max){
				max = (((Double)properties.get("orm")).intValue()/50+1)*50;
			}
			object+="x:"+Converter.getJSDate((Date) properties.get("date"));
			object+=",";
			object+="y:"+c(properties.get("orm"),lbs,false);
			object+=",";
			object+="name:"+"\"One rep max: "+c(properties.get("orm"),lbs,true)+"<br>"
			+properties.get("rep")+" x "+c(properties.get("wt"),lbs,true)+"<br>"
			+"at a bodyweight of "+c(properties.get("bw"),lbs,true)+"\",";
			object+="url:\""+KeyFactory.keyToString(e.getKey())+"\"";
			object+="}";
			sb.append(object);
			sb.append(",");
		}
		if(sb.length()>1)
		sb.setLength(sb.length()-1);
		sb.append("]");
		} catch (EntityNotFoundException e1) {
			e1.printStackTrace();
			return "[]";
		}
		return sb.toString();
	}
public String getBodyweight(){
	
	boolean lbs;
	StringBuilder sb = new StringBuilder();
	Query dataQuery = new Query("Data");
	if(user==null)
		return "[]";
	dataQuery.setAncestor(user);
	dataQuery.addFilter("type", FilterOperator.EQUAL, "weight");
	dataQuery.addSort("date", SortDirection.ASCENDING);
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	try {
		lbs = (Boolean) (datastore.get(user).getProperty("lbs"));
	List<Entity> data = datastore.prepare(dataQuery).asList(FetchOptions.Builder.withDefaults());
	sb.append("[");
	for(Entity e:data){
		String object = "{";
		Map<String,Object> properties = e.getProperties();
		if((Double)properties.get("weight")>max){
			max = (((Double)properties.get("weight")).intValue()/50+1)*50;
		}
		object+="x:"+Converter.getJSDate((Date) properties.get("date"));
		object+=",";
		object+="y:"+c(properties.get("weight"),lbs,false);
		object+=",";
		object+="name:\""+c(properties.get("weight"),lbs,true)+"\",";
		object+="url:\""+KeyFactory.keyToString(e.getKey())+"\"";
		object+="}";
		sb.append(object);
		sb.append(",");
	}
	if(sb.length()>1)
	sb.setLength(sb.length()-1);
	sb.append("]");
	} catch (EntityNotFoundException e1) {
		return "[]";
	}
	return sb.toString();
}
public Standard getLatestStandard(String type){
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Standard s = null;
	
	
	Query dataQuery = new Query("Data");
	dataQuery.setAncestor(user);
	dataQuery.addFilter("type", FilterOperator.EQUAL,type);
	dataQuery.addSort("date", SortDirection.DESCENDING);
	
	
	List<Entity> results = datastore.prepare(dataQuery).asList(FetchOptions.Builder.withLimit(1));
	if(results.size()==0)
		return null;
	Entity lift = results.get(0);
	s = Standard.getStandard(type,100,(Double)lift.getProperty("wt"),true,((Long)lift.getProperty("rep")).intValue());
	return s;
}
}
