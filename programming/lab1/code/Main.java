import java.util.Arrays;
import java.util.Random;
import java.lang.Math;


class Main{
	public static void main(String[] args){
		// First array
		int[] w = new int[7];
		
		for (int i = 0, val = 4; val <= 16; ++i, val += 2){
			w[i] = val;
		}	
		
		// Second array
		float[] x = new float[12];
		
		Random rd = new Random();
		final float minRand = -6.0f;
		final float maxRand = 9.0f;
		for (int i = 0; i < 12; ++i){
			x[i] = minRand + rd.nextFloat() * (maxRand-minRand);			
		}

		// Third array
		double[][] k = new double[7][12];

		for (int i = 0; i < k.length; ++i){
			for (int j = 0; j < k[i].length; ++j){	
					k[i][j] = generateMatrixValue(w[i], x[j]);
			}
		}

		// Output
		printDoubleMatrixWithPrecision(k, 2);
	}

	/*
	* Generate matrix number
	* w, x mean values from corresponding arrays
	*/
	private static double generateMatrixValue(int w, float x){
		double res;
		if (w == 10){
			res = java.lang.Math.pow(
					(2 * java.lang.Math.tan(
								java.lang.Math.pow(
									(x * (1 - x)), 2))
					 ), 2);
		} else if (w == 8 || w == 14 || w == 16){
			res = java.lang.Math.pow(1.0/3.0/
					(4.0-(
					       java.lang.Math.pow(
						       java.lang.Math.cbrt(x),
						       ((1.0-(2.0/3.0)/(x+1.0)) / java.lang.Math.PI)
							)))
				       	, 3);

		} else {
			res = java.lang.Math.tan(java.lang.Math.pow(java.lang.Math.E, (java.lang.Math.sin(java.lang.Math.cos(x)))));
		}
		return res;
	}

	// Print matrix
	private static void printDoubleMatrixWithPrecision(double[][] matrix, int precision){
		for (int i = 0; i < matrix.length; ++i){
			printDoubleArrayWithPrecision(matrix[i], precision);
		}	
	}
	
	// Print array
	private static void printDoubleArrayWithPrecision(double[] arr, int precision){
		System.out.print("[");
		for (int i = 0; i < arr.length; ++i){
			System.out.printf(" %." + precision + "f", arr[i]);
		}
		System.out.println("]");
	}
}

