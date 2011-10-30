
<%@ page import="com.google.appengine.api.memcache.*"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.*" %>
<script type="text/javascript"
	src="http://api.recaptcha.net/js/recaptcha_ajax.js"></script>
<script type="text/javascript" src="/user.js"></script>
<div id="signup" style="display: none">
	<div class="cover" onclick="$('#signup').hide()"></div>
	<div class="signUpBox">
		<table width="100%" cellpadding="10px">
			<tr>
				<td>Username:</td>
				<td><input type="text" id="regu" value=""
					onClick="this.value=''" />
				</td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" id="regp" value=""
					onclick="this.value=''" />
				</td>
			</tr>
			<tr>
				<td>Re-enter password:</td>
				<td><input type="password" id="reregp" value=""
					onclick="this.value=''" />
				</td>
			</tr>
			<tr>
				<td>Email(optional):</td>
				<td><input type="text" value="" id="rege"
					onclick="this.value=''" /></td>
			</tr>
			<tr>
				<td>Measurement:</td>
				<td><select name="measure" id="unit"><option value="lbs">Imperial(lb)</option>
  <option value="kgs">Metric(kg)</option></select></td>
			</tr>
			<tr>
				<td>Gender:</td>
				<td><select name="sex" id="gender"><option value="male">Male</option>
  <option value="saab">Female</option></select></td>
			</tr>
			<tr>
				<td colspan="2">

					<div id="recaptcha_image"
						style="margin: 7px; border-style: solid; border-color: #333333; border-width: 1px;"></div>
				</td>
			</tr>
			<tr>
				<td>Human Check:</td>
				<td><input type="text" style="margin-top: 5px"
					id="recaptcha_response_field" name="recaptcha_response_field" /></td>
			</tr>
		</table>
		<br /> <br />
		<center>
			<button style="margin-top: 5px;" onClick="register()">Register</button>
		</center>
		<center><span id="regStatus"></span></center>
	</div>
</div>
<div id="login" style="display: none">
	<div class="cover" onclick="$('#login').hide()"></div>
	<div class="signUpBox">
		<table width="100%">
			<tr>
				<td>username:</td>
				<td><center><input type="text" id="logu" /></center>
				</td>
			</tr>
			<tr>
				<td>password:</td>
				<td><center><input type="password" id="logp" /></center>
				</td>
			</tr>
			<tr><td colspan="2"><br><center><span id="logStatus" style="font-size:12px;color:#F22"></span></center></td></tr>


		</table>
		<br /> <br />
		<center>
			<button style="margin-top: 5px;" onClick="login()">Login</button>
		</center>
	</div>
</div>
<div id="userBar">
	<%
		
		String currentUser=null;
		Key key = null;
		boolean male=true;
		boolean lbs=true;
		try{
		Cookie[] cookies = null;
	
		cookies= request.getCookies();
	
		if(session.getAttribute("currentUser")==null){
			for (Cookie c : cookies) {
				if (c.getName().equalsIgnoreCase("sessionId")) {
					String sid = c.getValue();
					MemcacheService ms = MemcacheServiceFactory
							.getMemcacheService();
					Object result = ms.get(sid);

					if (result != null) {
						 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
						String id = result.toString().toLowerCase();
						try {
							Entity user = datastore.get(KeyFactory.createKey("User", id));
							session.setAttribute("currentUser", user.getProperty("name"));						
							session.setAttribute("id", user.getKey());							
							session.setAttribute("loggedIn", true);
							session.setAttribute("lbs", user.getProperty("lbs"));						
							session.setAttribute("sex", user.getProperty("sex"));
							
						} catch (EntityNotFoundException e) {
							e.printStackTrace();
						}						
					}
				}
			}
		}
		
		if(session.getAttribute("currentUser")!=null){
			currentUser = (String)session.getAttribute("currentUser");
			lbs = (Boolean)session.getAttribute("lbs");
			male = (Boolean)session.getAttribute("sex");
			key = (Key)session.getAttribute("id");
		}

		}
		catch(Exception e){
		
		}
		if (currentUser==null) {
	%>
	You're not logged in! <span class='jslink'
		onclick="$('#login').show()">log in</span> or <span class='jslink'
		onclick="$('#signup').show()">register</span>
	<%
		} else {
	%>
	Welcome, <%=currentUser%>
	| <a href='/logout' class='jslink'>Log
		Out</a>
	<%
		}
	%>
</div>