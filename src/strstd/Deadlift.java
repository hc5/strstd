package strstd;

public class Deadlift extends Standard {

	public Deadlift(boolean male, double bodyWeight, double weight, int rep) {
		super(male, bodyWeight, weight, rep);
		this.type="dl";
		
	}

	@Override
	public double calculateORM() {
		if(this.rep==1){
			this.oneRepMax=this.weight;
		}
		else
		this.oneRepMax = Wathan.calculate()+(this.weight*0.1>20?20:this.weight*0.1);
		return this.oneRepMax;
	}

	@Override
	public void calculateStandards() {
		if(male){
			grades[0]=
			
			4.43*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
			-0.00527*Math.pow(bodyWeight, 2)
			+2.0165*bodyWeight
			-71.395;
			grades[1]=
				+8.88*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
				-0.0103*Math.pow(bodyWeight, 2)
				+3.855*bodyWeight
				-130.05;
			grades[2]=
				+1.358*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
				-0.0141*Math.pow(bodyWeight, 2)
				+4.9374*bodyWeight
				-196.35;
			grades[3]=
				2.166*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
				-0.0211*Math.pow(bodyWeight, 2)
				+6.8675*bodyWeight
				-244.99;
			grades[4]=
				3.48*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
				-0.0309*Math.pow(bodyWeight, 2)
				+9.2055*bodyWeight
				-315.39;
			
		}else{
			grades[0]=
				-0.0007*Math.pow(bodyWeight, 2)
				+0.6452*bodyWeight
				+1.4775;
			
			grades[1]=
				-0.0014*Math.pow(bodyWeight, 2)
				+1.1982*bodyWeight
				+2.5718;
			grades[2]=
				-0.0019*Math.pow(bodyWeight, 2)
				+1.4912*bodyWeight
				-4.022;
			grades[3]=
				-0.0038*Math.pow(bodyWeight, 2)
				+2.1859*bodyWeight
				-0.8684;
			grades[4]=
				-0.0015*Math.pow(bodyWeight, 2)
				+1.6*bodyWeight
				+87.805;
		}
		
	}



}
