import java.util.Random;

public class random {
	public static void main(String args[]) {
		Random rnd = new Random();
		for (int number = 1; number <= 1000; number++) {
			double x = rnd.nextDouble();
		}
	}
}
