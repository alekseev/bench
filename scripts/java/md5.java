import java.io.UnsupportedEncodingException;
import java.util.Random;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class md5 {
	public static void main(String args[]) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		Random rnd = new Random();
		MessageDigest md = MessageDigest.getInstance("MD5");
		for (int i = 1; i <= 1000000; i++) {
			md.digest(Double.toString(rnd.nextDouble()).getBytes("UTF-8"));
		}
	}
}
