 function register(){
	 $("#regStatus").html('<img src="/images/load.gif" style="padding:10px" />');
	if($("#reregp").val()!=$("#regp").val()){
		$("#regStatus").html("Your passwords don't match");
		return;
	}
	
  	$.get("/namecheck?u="+$('#regu').val(),function(data){
	if(data=='OK'){
		var postdata = {
		u:$("#regu").val(),
		p:$("#regp").val(),
		e:$("#rege").val(),
		m:$("#unit").val(),
		g:$("#gender").val(),
		recaptcha_challenge_field:$("#recaptcha_challenge_field").val(),
		recaptcha_response_field:$("#recaptcha_response_field").val()
		}
		$.post("/register",postdata,function(data){
		$("#regStatus").html(data);
		
		setTimeout('window.location.reload()',1000);
		});
	}
	else{
	$("#regStatus").html("The username is already taken!");
	}
	});
  }
  function login(){
  $("#logStatus").html('<img src="/images/load.gif" style="padding:10px" />');
  	$.post("/login",{u:$("#logu").val(),p:$("#logp").val()},function(data){
	if(data=="success"){
		window.location="/";
	}
	else{
		$("#logStatus").html("Login failed");
	}
	});
  }
  
  
  function swap(el){
  $(el).hide();
  $("#"+el.innerHTML).show();
  }
  function swapback(el){
  console.log(el);
  $(el).hide();
  $("#"+el.id+"Span").show();
  }
  $(document).ready(function(){
   PreloadCaptcha();


  });
    function PreloadCaptcha() {
  showRecaptcha();
 }
  function showRecaptcha() {
    Recaptcha.create("6LdI87sSAAAAAEDXZ4zt2H9zJbVhcshxPHtZoioo", "dynamic_recaptcha_1", {
          theme: "custom",
          callback: Recaptcha.focus_response_field
    });
  }