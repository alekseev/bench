import java.io.*;
import java.util.Scanner;
import java.util.regex.*;

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
		for (int number = 1; number <= 1000000; number++) {
			String[] r = text.toString().split("[a-z]");
		}
	}
}
