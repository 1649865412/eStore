
package com.cartmatic.estoresf.payment.web;

import java.util.Vector;

/**
 * 仅用于authorize net 网关的 aim 方式
 * @author csx
 *
 */
public class AuthorizeNetAIM {

	public static Vector split(String pattern, String in) {
		int s1 = 0, s2 = -1;
		Vector out = new Vector(30);
		while (true) {
			s2 = in.indexOf(pattern, s1);
			if (s2 != -1) {
				out.addElement(in.substring(s1, s2));
			} else {
				//the end part of the string (string not pattern terminated)
				String _ = in.substring(s1);
				if (_ != null && !_.equals("")) {
					out.addElement(_);
				}
				break;
			}
			s1 = s2;
			s1 += pattern.length();
		}
		return out;
	}

	// by Roedy Green (c)1996-2003 Canadian Mind Products
	public static String toHexString(byte[] b) {
		StringBuffer sb = new StringBuffer(b.length * 2);
		for (int i = 0; i < b.length; i++) {
			// look up high nibble char
			sb.append(hexChar[(b[i] & 0xf0) >>> 4]);

			// look up low nibble char
			sb.append(hexChar[b[i] & 0x0f]);
		}
		return sb.toString();
	}

	// table to convert a nibble to a hex character
	static char[]	hexChar	= { '0', '1', '2', '3', '4', '5', '6', '7', '8',
			'9', 'A', 'B', 'C', 'D', 'E', 'F' };
}
