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

import lgs.admin.service.AdminService;
import lgs.cmmn.Utils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 */

@Controller
public class AdminController {

	/** AdminService */
	@Resource(name = "adminService")
	private AdminService adminService;

	private final static String SUCCESS = "1";

	/**
	 * name : adminloginPage
	 * description : 로그인화면을 보여준다.
	 */
	@RequestMapping(value = "/admin.do")
	public String adminloginPage() throws Exception {

		return "admin/login";
	}

	/**
	 * name : adminRegisterPage
	 * description : 회원가입 화면을 보여준다.
	 */
	@RequestMapping(value = "/register.do")
	public String adminRegisterPage() throws Exception {

		return "admin/register";
	}

	/**
	 * name : adminRegisterPage
	 * description : 비밀번호 찾기 화면을 보여준다.
	 */

	@RequestMapping(value = "/findpw.do")
	public String findpwPage() throws Exception {

		return "admin/findpw";
	}

	/**
	 * name : loginProcess (AJAX)
     * description : 로그인을 한다.
	 */
	@RequestMapping(value = "/loginProcess.do")
	public @ResponseBody String loginProcess(@RequestParam Map<String, Object> param
			                                  , HttpSession session
			                                  , HttpServletRequest request) throws Exception {

		String result = adminService.loginChk(param);

		/* 세션 추가 */
		if(result.equals(SUCCESS)) {
            session.setAttribute("loginCheck",true);
            session.setAttribute("id", param.get("userID").toString());
		} 
		
		return result;
	}

	/**
	 * name : registerProcess (AJAX)
	 * description : 회원가입을 한다.
	 */
	@RequestMapping(value = "/registerProcess.do")
	public @ResponseBody String registerProcess(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {
		adminService.userRegister(param);

		return SUCCESS;
	}

	/**
	 * name : logoutProcess
     * description : 로그아웃을한다.
	 */
    @RequestMapping(value="/logoutProcess.do")
    public String logoutProcess(HttpSession session) {
                            
        session.setAttribute("loginCheck",null);
        session.setAttribute("id",null);
        
        return "admin/login";
    }

	/**
	 * name : overlapId (AJAX)
	 * description : 아이디를 중복확인 한다.
	 */
	@RequestMapping(value = "/overlapId.do")
	public @ResponseBody String overlapId(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		return adminService.overlapId(param);
	}

	/**
	 * name : selectPwFindQuiz (AJAX)
	 * description : 비밀번호 찾기 질문을 조회한다.
	 */
	@RequestMapping(value = "/selectPwFindQuiz.do", produces = "application/text; charset=utf8")
	public @ResponseBody
	String selectPwFindQuiz(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		return adminService.selectPwFindQuiz(param);
	}

	/**
	 * name : selectPwFind (AJAX)
	 * description : 비밀번호 찾기 를 조회한다.
	 */
	@RequestMapping(value = "/selectPwFind.do", produces = "application/text; charset=utf8")
	public @ResponseBody
	String selectPwFind(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		return adminService.selectPwFind(param);
	}

	/**
	 * name : selectLoginUserInfo (AJAX)
	 * description : 로그인 유저 정보를 조회한다.
	 */
	@RequestMapping(value = "/selectLoginUserInfo.do")
	public @ResponseBody
	ModelAndView selectLoginUserInfo(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {
		param.put("id", session.getAttribute("id"));

		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> userLsit = adminService.selectLoginUserInfo(param);
		userLsit.get(0).put("FILE_PATH", Utils.castBase64(userLsit.get(0).get("FILE_PATH").toString()));

		mv.addObject("userList", userLsit);
		return mv;
	}

	/**
	 * name : mypageView
	 * description : 마이페이지 화면을 보여준다.
	 */
	@RequestMapping(value="/mypage.do")
	public String mypageView(HttpSession session) {

		return "admin/mypage";
	}


	/**
	 * name : adminMainPage
     * description : 관리자 메인화면을보여준다
	 */
	@RequestMapping(value = "/admin/main.do")
	public String adminMainPage(Model model) throws Exception {

		return "admin/index";
	}

	/**
	 * name : projectPage
     * description : 프로젝트관리화면을 보여준다.
	 */
	@RequestMapping(value = "/admin/project.do")
	public String projectPage(Model model) throws Exception {

		return "admin/project";
	}
	
	/**
	 * name : bbsPage
     * description : 게시판관리화면을 보여준다.
	 */
	@RequestMapping(value = "/admin/bbs.do")
	public String bbsPage(Model model) throws Exception {

		return "admin/bbs";
	}
	
	/**
	 * name : settingPage
     * description : 시스템 설정 화면을 보여준다.
	 */
	@RequestMapping(value = "/admin/setting.do")
	public String settingPage(Model model) throws Exception {

		return "admin/setting";
	}
	
}
