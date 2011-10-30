package strstd;

public abstract class Standard {
	public boolean male;
	public double bodyWeight;
	public double weight;
	public int rep;
	public double oneRepMax = -1;
	public String type;
	public Formula calculation;
	public static Standard getStandard(String t, double bw, double w, boolean m, int rep){
		Standard s=null;
		if(t.equals("bp")){
			s=new Benchpress(m,bw,w,rep);
		}
		else if(t.equals("dl")){
			s=new Deadlift(m,bw,w,rep);
		}
		else if(t.equals("squat")){
			s=new Squat(m,bw,w,rep);
		}
		else if(t.equals("ohp")){
			s=new Press(m,bw,w,rep);
		}
		return s;
	}
	public  double grade(){

		if(oneRepMax==-1){
			calculateORM();

		}
		int i =0;
		for(;i<grades.length;i++){
			if(oneRepMax<grades[i])
				break;
		}

		double grade = i;
		if(i!=0&&i!=5){
			grade+=(oneRepMax-grades[i-1])/(grades[i]-grades[i-1]);
		}
		return grade-1>0?grade-1:0;
	}
	public void setBodyWeight(double s){
		this.bodyWeight=s;
		calculateStandards();
		grade();
	}
	public abstract void calculateStandards();
	public double [] grades = new double[5];
	public final Formula Mayhew = new Formula(){
		public double calculate(){
			return 100*weight/(52.2+41.9*Math.exp( -0.055*rep));
		}
	};
	public final Formula Wathan = new Formula(){
		public double calculate(){
			return 100*weight/(48.8+53.8*Math.exp(-0.075*rep));
		}
	};
	public abstract double calculateORM();
	public Standard(boolean male, double bodyWeight, double weight, int rep) {
		super();
		this.male = male;
		this.bodyWeight = bodyWeight;
		this.weight = weight;
		this.rep = rep;
		calculateStandards();
	}
	

}
