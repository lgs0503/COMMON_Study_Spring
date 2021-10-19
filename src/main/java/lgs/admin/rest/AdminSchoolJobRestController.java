/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package lgs.admin.rest;

import lgs.admin.service.AdminSchoolJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**회원관리 Restful
 */

@RestController
@RequestMapping("/admin/schooljobapi")
public class AdminSchoolJobRestController {

	private final String HTTPRETURN_OK = "OK";
	
	@Autowired
	private AdminSchoolJobService adminSchoolJobService;

	@PostMapping
	public String add(@RequestParam Map<String,Object> param, HttpSession session) {
		
		if(session.getAttribute("id") != null){
			//일련번호조회
			//param.put("idx", "조회일련번호");
		} else {
			param.put("idx", "1");
		}
		
		adminSchoolJobService.add(param);
		return HTTPRETURN_OK;
	}
	
	@PutMapping
	public String update(@RequestParam Map<String,Object> param) {
		adminSchoolJobService.update(param);
		return HTTPRETURN_OK;
	}
	
	@DeleteMapping("{memberId}")
	public String delete(@PathVariable String memberId) {
		adminSchoolJobService.delete(memberId);
		return HTTPRETURN_OK;
	}
}