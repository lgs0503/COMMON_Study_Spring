
package lgs.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminMemberService {

	List<Map<String, Object>> searchList(Map<String, Object> map);
	
	int countList();
	
	Map<String, Object> search(String map);
	
	void add(Map<String, Object> map);
	
	void update(Map<String, Object> map);

	void delete(String map);

}
