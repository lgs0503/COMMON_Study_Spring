package lgs.cmmn;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Calendar;

public class Utils{

	/* 문자열 널체크 
	 * 널이면 returnText 리턴 */
	public static String stringNullChk (String param, String returnText) {
		if(param == null) {
			return returnText;
		} else {
			return param;
		}
	}

	/* SHA 256 인코딩 */
	public static String encrypt(String text) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(text.getBytes());

		return bytesToHex(md.digest());
	}

	/* 바이트 TO 헥사 */
	public static String bytesToHex(byte[] bytes) {
		StringBuilder builder = new StringBuilder();
		for (byte b : bytes) {
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
	}

	/* 폴더 생성 */
	public static void makeDir(String dirPath){
		File Folder = new File(dirPath);

		if (!Folder.exists()) {
			try{
				Folder.mkdirs(); //폴더 생성합니다.
			}
			catch(Exception e){
				e.getStackTrace();
			}
		} else {
		}
	}

	/* 현재 시간을 기준으로 파일 이름 생성 */
	public static String genSaveFileName() {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR) + calendar.get(Calendar.MONTH) + calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR) + calendar.get(Calendar.MINUTE) + calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);

		return fileName;
	}

	/* 이미지 파일 base64 변환 */
	public static String castBase64(String filePath) throws IOException {
		File file = new File(filePath);
		byte[] data = new byte[(int) file.length()];
		try (FileInputStream stream = new FileInputStream(file)) {
			stream.read(data, 0, data.length);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		return Base64.getEncoder().encodeToString(data);
	}
}
