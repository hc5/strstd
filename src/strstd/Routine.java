package strstd;
import static strstd.Converter.*;
public class Routine {
	public double orm;
	public double error;
	public double trueOrm=-1;
	public String [] warmUp = new String []{"40% x 5","50% x 5", "60% x 3"};
	public String [][] routine = new String [][]
	{{"65% x 3","75% x 3","85% x 5+"}
	,{"70% x 3","80% x 3","90% x 3+"}
	,{"75% x 5","85% x 3","95% x 1+"}
	,{"40% x 5","50% x 5","60% x 5"}};
	public String bbb = "5 x 10 at 50%";
	public void setOrm(double orm,boolean error,boolean lbs){
		trueOrm = orm;
		if(error)
			this.error=0.1;
		else
			this.error=0;
		this.orm = orm*(1-this.error);
		orm = orm*(1-this.error);
		if(!lbs){
			this.orm = lbsToKgs(this.orm);
			orm = lbsToKgs(orm);
		}
		warmUp = new String[]{getSet(orm,0.4,5,lbs),getSet(orm,0.5,5,lbs),getSet(orm,0.6,3,lbs)};
		routine = new String [][]
		{{getSet(orm,0.65,5,lbs),getSet(orm,0.75,5,lbs),getSet(orm,0.85,5,"+",lbs)}
		,{getSet(orm,0.7,3,lbs),getSet(orm,0.8,3,lbs),getSet(orm,0.9,3,"+",lbs)}
	    ,{getSet(orm,0.75,5,lbs),getSet(orm,0.85,3,lbs),getSet(orm,0.95,1,"+",lbs)}
		,{getSet(orm,0.4,5,lbs),getSet(orm,0.5,5,lbs),getSet(orm,0.6,5,lbs)}};
		bbb = "5 x 10 at "+round5((int)(orm*0.5))+" "+(lbs?"lbs":"kgs");
	}
	
}
