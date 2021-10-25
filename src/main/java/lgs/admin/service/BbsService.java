
package lgs.admin.service;

import java.util.List;
import java.util.Map;

public interface BbsService {

	List<Map<String, Object>> searchList(Map<String, Object> map);
	
	int countList();

	List<Map<String, Object>> search(Map<String, Object> map);
	
	void add(Map<String, Object> map);
	
	void update(Map<String, Object> map);

	void delete(Map<String, Object> map);

}
