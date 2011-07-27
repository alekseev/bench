import java.io.FileInputStream;
import java.io.IOException;
import java.util.Scanner;

public class regexp {
	public static void main(String args[]) throws IOException {
		StringBuilder text = new StringBuilder();
		String NL = System.getProperty("line.separator");
		Scanner scanner = new Scanner(new FileInputStream("../../data/lorem.txt"), "UTF-8");
		try {
			while (scanner.hasNextLine()) {
				text.append(scanner.nextLine() + NL);
			}
		} finally {
			scanner.close();
		}
		for (int i = 1; i <= 1000000; i++) {
			text.toString().split("[a-z]");
		}
	}
}
