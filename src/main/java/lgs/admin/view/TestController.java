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
package lgs.admin.view;

import lgs.admin.service.AdminMemberService;
import lgs.cmmn.Utils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 */

@Controller
@RequestMapping("/admin/Test")
public class TestController {

	/** AdminMemberService */
	@Resource(name = "adminMemberService")
	private AdminMemberService adminMemberService;

	/**
	 * name : memberPage
     * description : 회원관리화면 리스트을 보여준다.
	 */
	@GetMapping
	public String memberPage(Model model, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		String keyword =  Utils.stringNullChk(request.getParameter("keyword"), "");
		String chkbox = Utils.stringNullChk(request.getParameter("chkbox"), "");
		
		map.put("keyword", keyword);
		map.put("chkbox", chkbox);
		
		List<Map<String,Object>> memberList = adminMemberService.searchList(map);
		
		model.addAttribute("MEMBER", memberList);
		model.addAttribute("KEYWORD", keyword);
		model.addAttribute("CHKBOX", chkbox);
		
		return "admin/member/index";
	}

	/**
	 * name : memberPage
     * description : 회원정보를 보여준다.
	 */
	@GetMapping("read/{memberId}")
	public String read(@PathVariable String memberId , Model model) throws Exception {
		System.out.println("memberId"+memberId);
		Map<String,Object> member = adminMemberService.search(memberId);
		
		model.addAttribute("MEMBER", member);
		
		return "admin/member/list";
	}
	

	/**
	 * name : writePage
     * description : 회원정보를 추가 및 수정 하는 페이지를 보여준다.
	 */
	@GetMapping("writePage")
	public String writePage(Model model, HttpServletRequest request) throws Exception {
		
		return "admin/member/write";
	}
}
