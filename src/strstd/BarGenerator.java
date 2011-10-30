package strstd;

public class BarGenerator {
	public static String make(String width,double val,double grade,double[]grades,boolean lbs){
		String bar = "";
		bar+="<div style='width:"+width+"px;padding-left:30px;padding-right:30px'>";
		bar+="<table style='width:100%'>";
		bar+="<tr><td>";
		bar+="<div class='barBg'>";
		bar+="<div class='label"+((int)(grade/4.0*100)<=7?"2":"")+"'>"+(int)(lbs?val:Converter.lbsToKgs(val))+" "+(lbs?"lbs":"kgs")+"</div>";
		bar+="<div class='divider' style='left:25%'>&nbsp;</div>";
		bar+="<div class='divider' style='left:50%'>&nbsp;</div>";
		bar+="<div class='divider' style='left:75%'>&nbsp;</div>";
		bar+="<div class='bar' style='width:"+(int)(grade/4.0*100)+"%'>&nbsp;</div>";
		bar+="</div>";
		bar+="</td>";
		bar+="</tr>";
		bar+="<tr>";
		bar+="<td>";
		bar+="<div style='position:relative;font-family:Arial;color:#555;'>";
		bar+="<span class='marker' style='left:0%;position:absolute;margin-left:-32px;'><center>Untrained<br><span class='grades'>("+(int)(lbs?grades[0]:Converter.lbsToKgs(grades[0]))+" "+(lbs?"lbs":"kgs")+")</span></center></span>";
		bar+="<span class='marker' style='left:25%;position:absolute;margin-left:-25px'><center>Novice<br><span class='grades'>("+(int)(lbs?grades[1]:Converter.lbsToKgs(grades[1]))+" "+(lbs?"lbs":"kgs")+")</span></center></span>";
		bar+="<span class='marker' style='left:50%;position:absolute;margin-left:-43px'><center>Intermediate<br><span class='grades'>("+(int)(lbs?grades[2]:Converter.lbsToKgs(grades[2]))+" "+(lbs?"lbs":"kgs")+")</span></center></span>";
		bar+="<span class='marker' style='left:75%;position:absolute;margin-left:-35px'><center>Advanced<br><span class='grades'>("+(int)(lbs?grades[3]:Converter.lbsToKgs(grades[3]))+" "+(lbs?"lbs":"kgs")+")</span></center></span>";
		bar+="<span class='marker' style='left:100%;position:absolute;margin-left:-50px;width:90px'><center>Elite<br><span class='grades'>("+(int)(lbs?grades[4]:Converter.lbsToKgs(grades[4]))+(lbs?"lbs":"kgs")+")</span></center></span>";
		bar+="</div>";
		bar+="</td>";
		bar+="</tr>";
		bar+="</table>";
		bar+="</div><br><br>";
		
		return bar;
			
	}
	public static String make(String width, String id){
		String bar = "";
		bar+="<div id='"+id+"' style='width:"+width+"px;padding-left:30px;padding-right:30px;display:none'>";
		bar+="<span class='subtitle'>One Rep Max:</span><br>";
		bar+="<table style='width:100%'>";
		bar+="<tr><td>";
		bar+="<div class='barBg'>";
		bar+="<div class='label' id='lab'></div>";
		bar+="<div class='divider' style='left:25%'>&nbsp;</div>";
		bar+="<div class='divider' style='left:50%'>&nbsp;</div>";
		bar+="<div class='divider' style='left:75%'>&nbsp;</div>";
		bar+="<div class='bar' style='width:0%'>&nbsp;</div>";
		bar+="</div>";
		bar+="</td>";
		bar+="</tr>";
		bar+="<tr>";
		bar+="<td>";
		bar+="<div style='position:relative;font-family:Arial;color:#555;'>";
		bar+="<span class='marker' style='left:0%;position:absolute;margin-left:-32px;'><center>Untrained<br>(<span class='grades'></span>)</center></span>";
		bar+="<span class='marker' style='left:25%;position:absolute;margin-left:-25px'><center>Novice<br>(<span class='grades'></span>)</center></span>";
		bar+="<span class='marker' style='left:50%;position:absolute;margin-left:-43px'><center>Intermediate<br>(<span class='grades'></span>)</center></span>";
		bar+="<span class='marker' style='left:75%;position:absolute;margin-left:-35px'><center>Advanced<br>(<span class='grades'></span>)</center></span>";
		bar+="<span class='marker' style='left:100%;position:absolute;margin-left:-50px;width:90px'><center>Elite<br>(<span class='grades'></span>)</center></span>";
		bar+="</div>";
		bar+="</td>";
		bar+="</tr>";
		bar+="</table>";
		bar+="<br><br></div>";
		
		return bar;
			
	}
}
