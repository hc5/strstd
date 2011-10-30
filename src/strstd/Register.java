package strstd;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.*;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;


public class Register extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String username = req.getParameter("u");
		String password = req.getParameter("p");
		String email = req.getParameter("e");
		boolean male = req.getParameter("g").equals("male");
		boolean lbs = req.getParameter("m").equals("lbs");
		 String challenge = (String) req.getParameter("recaptcha_challenge_field");
		  String response = (String) req.getParameter("recaptcha_response_field");
		  String remoteAddr = req.getRemoteAddr();
	      ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
	     
	      reCaptcha.setPrivateKey("6LdI87sSAAAAAO22DAIrM6By4goRhdI2LOpFSiy3");
	      ReCaptchaResponse reCaptchaResponse =
	          reCaptcha.checkAnswer(remoteAddr, challenge, response);
	      if(!reCaptchaResponse.isValid()){
	    	  resp.getWriter().print("Your captcha is wrong.. try again");
	    	  return;
	      }
	     
	      DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	      Transaction txn = datastore.beginTransaction();
	      try{
	    	  Entity user = new Entity("User",username.toLowerCase());
		      user.setProperty("name", username);
		      user.setProperty("pass",SHA1.SHA1(password));
		      user.setProperty("email", email);
		      user.setProperty("sex", male);
		      user.setProperty("lbs", lbs);
		      
	      datastore.put(user);
	      txn.commit();
	      } catch (Exception e) {

		      resp.getWriter().print("Registration failed, please try again!");
		}
	      finally{
	    	  if (txn.isActive()) {
	    	        txn.rollback();
	    	    }
	      }
	      resp.getWriter().print("Registration successful! You can login now");
	      
	}
}
