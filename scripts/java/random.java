import java.util.Random;

public class random {
	public static void main(String args[]) {
		Random rnd = new Random();
		for (int i = 1; i <= 1000000; i++) {
			rnd.nextDouble();
		}
	}
}
