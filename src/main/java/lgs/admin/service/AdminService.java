
package lgs.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminService {

	String loginChk(Map<String,Object> map) throws Exception;

	void userRegister(Map<String,Object> map) throws Exception;

	String overlapId(Map<String,Object> map) throws Exception;

	String selectPwFindQuiz(Map<String,Object> map) throws Exception;

	String selectPwFind(Map<String,Object> map) throws Exception;

	List<Map<String, Object>> selectLoginUserInfo(Map<String,Object> map) throws Exception;
}
