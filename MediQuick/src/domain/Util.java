package domain;

public class Util {

	public static String humancase(String str) { 
		if (str==null) return "";
		else if (str.length()<2) return str;
		else return str.substring(0,1).toUpperCase() + str.substring(1).toLowerCase();
	}
	
}
