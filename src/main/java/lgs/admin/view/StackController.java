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

import lgs.admin.service.AdminStackService;
import lgs.cmmn.PagingVO;
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
@RequestMapping("/admin/stack")
public class StackController {

	/** adminStackService */
	@Resource(name = "adminStackService")
	private AdminStackService adminStackService;

	/**
	 * name : stackPage
     * description : 기술관리화면 리스트을 보여준다.
	 */
	@GetMapping
	public String listPage(Model model, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();

		String keyword =  Utils.stringNullChk(request.getParameter("keyword"), "");
		String chkbox = Utils.stringNullChk(request.getParameter("chkbox"), "");
		String nowPage = Utils.stringNullChk(request.getParameter("nowPage"), "1");
		String cntPerPage = Utils.stringNullChk(request.getParameter("cntPerPage"), "10");
		
		int total = adminStackService.countList();
		PagingVO vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		map.put("keyword", keyword);
		map.put("chkbox", chkbox);
		
		List<Map<String,Object>> resultList = adminStackService.searchList(map);

		model.addAttribute("paging", vo);
		model.addAttribute("STACK", resultList);
		model.addAttribute("KEYWORD", keyword);
		model.addAttribute("CHKBOX", chkbox);
		
		return "admin/stack/index";
	}

	/**
	 * name : stackPage
     * description : 기술정보를 보여준다.
	 */
	@GetMapping("read/{stackId}")
	public String read(@PathVariable String stackId , Model model) throws Exception {
		Map<String,Object> map = adminStackService.search(stackId);
		
		model.addAttribute("stack", map);
		
		return "admin/stack/list";
	}
	

	/**
	 * name : writePage
     * description : 기술정보를 추가 하는 페이지를 보여준다.
	 */
	@GetMapping("writePage")
	public String writePage(Model model, HttpServletRequest request) throws Exception {
		
		return "admin/stack/write";
	}

	/**
	 * name : writePage
     * description : 기술정보를 수정 하는 페이지를 보여준다.
	 */
	@GetMapping("updatePage/{stackId}")
	public String updatePage(@PathVariable String stackId ,Model model) throws Exception {

		Map<String,Object> map = adminStackService.search(stackId);
		
		model.addAttribute("stack", map);
		return "admin/stack/update";
	}
}
