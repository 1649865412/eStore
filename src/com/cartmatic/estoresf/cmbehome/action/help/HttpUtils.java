package com.cartmatic.estoresf.cmbehome.action.help;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * 
 * @author IVAN
 *
 */
public class HttpUtils {
	public static byte[] stream2Byte(InputStream inputStream, int bufferLength)
			throws IOException {

		byte[] result = null;
		if (inputStream != null) {
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[bufferLength];
			int readLength = -1;
			while ((readLength = inputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, readLength);
			}
			result = outputStream.toByteArray();

			outputStream.close();
			inputStream.close();

		}

		return result;

	}
}
