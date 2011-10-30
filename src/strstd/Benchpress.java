package strstd;

public class Benchpress extends Standard {
	
	public Benchpress(boolean male, double bodyWeight, double weight, int rep) {
		super(male, bodyWeight, weight, rep);
		this.type="bp";
		
		
	}

	@Override
	public double calculateORM() {
		if(this.rep==1){
			this.oneRepMax=this.weight;
		}
		else
		this.oneRepMax = Mayhew.calculate();
		return this.oneRepMax;
	}

	@Override
	public void calculateStandards() {
		if(male){
			grades[0]=
				
				3.527*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
				-0.0044*Math.pow(bodyWeight, 2)
				+1.7024*bodyWeight
				-58.992;
				grades[1]=
					+4.672*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
					-0.005757*Math.pow(bodyWeight, 2)
					+2.2368*bodyWeight
					-80.453;
				grades[2]=
					+8.4353*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
					-0.008875*Math.pow(bodyWeight, 2)
					+3.1251*bodyWeight
					-123.81;
				grades[3]=
					1.13*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
					-0.0119*Math.pow(bodyWeight, 2)
					+4.1865*bodyWeight
					-162.05;
				grades[4]=
					1.427*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
					-0.014955*Math.pow(bodyWeight, 2)
					+5.2686*bodyWeight
					-206.48;
			
		}else{
			grades[0]=
				-0.0005*Math.pow(bodyWeight, 2)
				+0.516*bodyWeight
				+3.8699;
			grades[1]=
				-0.0007*Math.pow(bodyWeight, 2)
				+0.6904*bodyWeight
				+3.3041;
			grades[2]=
				-0.001*Math.pow(bodyWeight, 2)
				+0.8542*bodyWeight
				+0.1026;
			grades[3]=
				-0.0013*Math.pow(bodyWeight, 2)
				+1.1138*bodyWeight
				-0.986;
			grades[4]=
				-2*Math.pow(10, -5)*Math.pow(bodyWeight,3)
				+0.0074*Math.pow(bodyWeight, 2)
				+0.1262*bodyWeight
				+53.48;
		}
		
	}

	

}
