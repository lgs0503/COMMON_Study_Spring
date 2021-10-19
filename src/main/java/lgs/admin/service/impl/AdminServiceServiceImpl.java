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
package lgs.admin.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import lgs.admin.mapper.AdminMapper;
import lgs.admin.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("adminService")
public class AdminServiceServiceImpl extends EgovAbstractServiceImpl implements AdminService {

	@Resource(name="adminMapper")
	private AdminMapper adminMapper;
	
	@Override
	public String loginChk(Map<String, Object> map) throws Exception {

		return adminMapper.loginChk(map);
	}

	@Override
	public void userRegister(Map<String, Object> map) throws Exception {
		adminMapper.userRegister(map);
	}

	@Override
	public String overlapId(Map<String, Object> map) throws Exception {
		return adminMapper.overlapId(map);
	}

	@Override
	public String selectPwFindQuiz(Map<String, Object> map) throws Exception {
		return adminMapper.selectPwFindQuiz(map);
	}

	@Override
	public String selectPwFind(Map<String, Object> map) throws Exception {
		return adminMapper.selectPwFind(map);
	}

	@Override
	public List<Map<String, Object>> selectLoginUserInfo(Map<String, Object> map) throws Exception {
		return adminMapper.selectLoginUserInfo(map);
	}
}
