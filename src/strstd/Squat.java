package strstd;

public class Squat extends Standard {

	public Squat(boolean male, double bodyWeight, double weight, int rep) {
		super(male, bodyWeight, weight, rep);
		this.type="squat";
		
	}

	@Override
	public double calculateORM() {
		if(this.rep==1){
			this.oneRepMax=this.weight;
		}
		else
		this.oneRepMax = Wathan.calculate();
		return this.oneRepMax;
	}

	@Override
	public void calculateStandards() {
		if(male){
			grades[0]=
			-3.5*Math.pow(10, -11)*Math.pow(bodyWeight, 5)
			+6.61*Math.pow(10, -8)*Math.pow(bodyWeight, 4)
			-3.617*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
			+0.0062*Math.pow(bodyWeight, 2)
			+0.3657*bodyWeight
			-1.7158;
			grades[1]=
				2.795*Math.pow(10, -10)*Math.pow(bodyWeight, 5)
				-2.501*Math.pow(10, -7)*Math.pow(bodyWeight, 4)
				+9*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
				-0.0208*Math.pow(bodyWeight, 2)
				+3.9187*bodyWeight
				-130.05;
			grades[2]=
				8.38*Math.pow(10, -10)*Math.pow(bodyWeight, 5)
				-8.213*Math.pow(10, -7)*Math.pow(bodyWeight, 4)
				+0.000319*Math.pow(bodyWeight, 3)
				-0.06684*Math.pow(bodyWeight, 2)
				+8.8513*bodyWeight
				-316.52;
			grades[3]=
				-6.409*Math.pow(10, -10)*Math.pow(bodyWeight, 5)
				+7.9*Math.pow(10, -7)*Math.pow(bodyWeight, 4)
				-0.00036432*Math.pow(bodyWeight, 3)
				+0.071*Math.pow(bodyWeight, 2)
				-3.9102*bodyWeight
				+180.53;
			grades[4]=
				2.5547*Math.pow(10, -10)*Math.pow(bodyWeight, 5)
				-1.38*Math.pow(10, -7)*Math.pow(bodyWeight, 4)
				+1.22*Math.pow(10, -5)*Math.pow(bodyWeight, 3)
				-0.0039*Math.pow(bodyWeight, 2)
				+3.8835*bodyWeight
				-71.376;
			
		}else{
			grades[0]=
				-0.0004*Math.pow(bodyWeight, 2)
				+0.4655*bodyWeight
				+4.9875;
			grades[1]=
				-0.0011*Math.pow(bodyWeight, 2)
				+0.9747*bodyWeight
				+0.9002;
			grades[2]=
				-0.0013*Math.pow(bodyWeight, 2)
				+1.1395*bodyWeight
				+0.7052;
			grades[3]=
				-0.0019*Math.pow(bodyWeight, 2)
				+1.5457*bodyWeight
				-1.7287;
			grades[4]=
				-0.0026*Math.pow(bodyWeight, 2)
				+2.0166*bodyWeight
				-8.6277;
		}
		
	}

	

}
