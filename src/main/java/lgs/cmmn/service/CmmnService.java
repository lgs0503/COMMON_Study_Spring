
package lgs.cmmn.service;

import java.util.List;
import java.util.Map;

public interface CmmnService {

	List<Map<String, Object>> selectCode(Map<String, Object> map) throws Exception;

	String getMaxfileNo() throws Exception;

	void insertFile(Map<String, Object> map) throws Exception;
}
