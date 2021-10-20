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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 */

@Controller
@RequestMapping("/admin/member")
public class MemberController {

	/** AdminMemberService */
	@Resource(name = "adminMemberService")
	private AdminMemberService adminMemberService;

	/**
	 * name : memberPage
     * description : 회원관리화면 을 보여준다.
	 */
	@GetMapping
	public String memberPage(Model model, HttpServletRequest request) throws Exception {

		return "admin/member/index";
	}

	/**
	 * name : selectList (ajax)
	 * description : 회원리스트을 보여준다.
	 */
	@RequestMapping(value = "/list")
	public @ResponseBody
	ModelAndView selectLoginUserInfo(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("jsonView");

		mv.addObject("memberList", adminMemberService.searchList(param));
		mv.addObject("memberCnt", adminMemberService.countList());

		return mv;
	}

	/**
	 * name : selectMember
	 * description : 회원정보를 보여준다.
	 */
	@RequestMapping(value = "/read")
	public @ResponseBody
	ModelAndView selectMember(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> memeber = adminMemberService.search(param);

		if(memeber.get(0).get("FILE_PATH") != null){
			memeber.get(0).put("FILE_PATH", Utils.castBase64(memeber.get(0).get("FILE_PATH").toString()));
		}

		mv.addObject("member", memeber);

		return mv;
	}

	/**
	 * name : deleteMember (ajax)
	 * description : 회원을 삭제한다.
	 */
	@RequestMapping(value = "/delete")
	public @ResponseBody
	String deleteMember(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		adminMemberService.delete(param);

		return "ok";
	}
}
