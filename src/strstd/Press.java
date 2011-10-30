package strstd;

public class Press extends Standard{

	

	public Press(boolean male, double bodyWeight, double weight, int rep) {
		super(male, bodyWeight, weight, rep);
		this.type="ohp";
		
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
			
			3.149*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
			-0.00334*Math.pow(bodyWeight, 2)
			+1.1931*bodyWeight
			-44.8;
			grades[1]=
				+3.474*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
				-0.00406*Math.pow(bodyWeight, 2)
				+1.5318*bodyWeight
				-55.249;
			grades[2]=
				+5.1*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
				-0.006*Math.pow(bodyWeight, 2)
				+2.1315*bodyWeight
				-83.298;
			grades[3]=
				7.167*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
				-0.0074*Math.pow(bodyWeight, 2)
				+2.553*bodyWeight
				-99.782;
			grades[4]=
				-8.755*Math.pow(10, -6)*Math.pow(bodyWeight, 3)
				+0.00134*Math.pow(bodyWeight, 2)
				+1.4707*bodyWeight
				-45.466;
			
		}else{
			grades[0]=
				-0.0004*Math.pow(bodyWeight, 2)
				+0.344*bodyWeight
				+1.4775;
			grades[1]=
				-0.0005*Math.pow(bodyWeight, 2)
				+0.4627*bodyWeight
				+2.3449;
			grades[2]=
				-0.0019*Math.pow(bodyWeight, 2)
				+0.9081*bodyWeight
				-21.03;
			grades[3]=
				-0.0007*Math.pow(bodyWeight, 2)
				+0.7251*bodyWeight
				+2.8989;
			grades[4]=
				-0.0012*Math.pow(bodyWeight, 2)
				+1.0234*bodyWeight
				-2.8711;
		}
		
	}


}
