package strstd;

import java.util.regex.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
* Static convenience methods for common web-related tasks.
*/
public final class WebUtils {
  
  /**
  * Validate the form of an email address.
  *
  * <P>Return <tt>true</tt> only if 
  *<ul> 
  * <li> <tt>aEmailAddress</tt> can successfully construct an 
  * {@link javax.mail.internet.InternetAddress} 
  * <li> when parsed with "@" as delimiter, <tt>aEmailAddress</tt> contains 
  * two tokens which satisfy {@link hirondelle.web4j.util.Util#textHasContent}.
  *</ul>
  *
  *<P> The second condition arises since local email addresses, simply of the form
  * "<tt>albert</tt>", for example, are valid for 
  * {@link javax.mail.internet.InternetAddress}, but almost always undesired.
  */
  public static boolean isValidEmailAddress(String aEmailAddress){
    if (aEmailAddress == null) return false;
    boolean result = true;
    try {
      InternetAddress emailAddr = new InternetAddress(aEmailAddress);
      emailAddr.validate();
      if ( ! hasNameAndDomain(aEmailAddress) ) {
        result = false;
      }
    }
    catch (AddressException ex){
      result = false;
    }
    return result;
  }

  private static boolean hasNameAndDomain(String aEmailAddress){
    String[] tokens = aEmailAddress.split("@");
    return 
     tokens.length == 2 &&
     tokens[0].length()>0 && 
     ( tokens[1] ).length()>0 ;
  }
  
  //..elided
}