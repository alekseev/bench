import java.io.*;
import java.util.*;
import java.security.*;

public class md5 {
	public static void main(String args[]) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		Random rnd = new Random();
		MessageDigest md = MessageDigest.getInstance("MD5");
		for (int number = 1; number <= 1000; number++) {
			double x = rnd.nextDouble();
			String xstring = Double.toString(x);
			byte[] xbytes = xstring.getBytes("UTF-8");
			byte[] thedigest = md.digest(xbytes);
		}
	}
}
