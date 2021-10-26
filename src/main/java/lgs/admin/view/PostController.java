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

import lgs.admin.service.BbsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
@RequestMapping("/admin/post")
public class PostController {

	@Resource(name = "bbsService")
	private BbsService bbsService;

	private final static String SUCCESS = "1";

	/**
	 * name : postPage
     * description : 게시글관리화면 을 보여준다.
	 */
	@GetMapping
	public String postPage(Model model, HttpServletRequest request) throws Exception {

		return "admin/post/index";
	}

	/**
	 * name : selectList (ajax)
	 * description : 게시글 리스트를 보여준다.
	 */
	@RequestMapping(value = "/list")
	public @ResponseBody
	ModelAndView selectList(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("jsonView");

		mv.addObject("postList", bbsService.searchList(param));
		mv.addObject("postCnt", bbsService.countList());

		return mv;
	}

	/**
	 * name : selectPost
	 * description : 게시글정보를 보여준다.
	 */
	@RequestMapping(value = "/read")
	public @ResponseBody
	ModelAndView selectPost(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> bbs = bbsService.search(param);

		mv.addObject("bbs", bbs);

		return mv;
	}

	/**
	 * name : overlapPost (AJAX)
	 * description : 게시판번호를 중복확인 한다.
	 */
	@RequestMapping(value = "/overlapBbs")
	public @ResponseBody String overlapBbs(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		return bbsService.overlapBbs(param);
	}

	/**
	 * name : insertBbs (ajax)
	 * description : 게시판을 추가한다..
	 */
	@RequestMapping(value = "/insert")
	public @ResponseBody
	String insertBbs(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		bbsService.add(param);

		return SUCCESS;
	}

	/**
	 * name : updateBbs (ajax)
	 * description : 게시판을 수정한다.
	 */
	@RequestMapping(value = "/update")
	public @ResponseBody
	String updateBbs(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		bbsService.update(param);

		return SUCCESS;
	}

	/**
	 * name : deleteBbs (ajax)
	 * description : 게시판을 삭제한다.
	 */
	@RequestMapping(value = "/delete")
	public @ResponseBody
	String deleteBbs(@RequestParam Map<String, Object> param
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		bbsService.delete(param);

		return SUCCESS;
	}
}
