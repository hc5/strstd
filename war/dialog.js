function dialog(html,onConfirm){
	var bg = $("<div class='cover'></div>");
	var d = $("<div class='dialog'></div>");
	
	
	var layout = $("<table style='width:100%;height:100%' cellpadding=10></table>");
	var ok = $("<button id='confirm'>Okay</button>");
	var cancel = $("<button id='cancel'>Cancel</button>");
	var row = $("<tr></tr>");
	var oCell = $("<td style='text-align:center'></td>");
	var cCell = $("<td style='text-align:center'></td>");
	oCell.append(ok);
	cCell.append(cancel);
	
	row.append(oCell);
	row.append(cCell);
	var content = $("<tr><td colspan=2>"+html+"</td></tr>");
	layout.append(content);
	layout.append(row);
	d.append(layout);
	ok.click(function(){
		onConfirm();
		bg.remove();
		d.remove();
	});
	cancel.click(function(){
		bg.remove();
		d.remove();
	});
	$("body").append(bg);
	$("body").append(d);
}