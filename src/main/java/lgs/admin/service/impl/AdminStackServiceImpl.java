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

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import lgs.admin.mapper.AdminMemberMapper;
import lgs.admin.mapper.AdminStackMapper;
import lgs.admin.service.AdminMemberService;
import lgs.admin.service.AdminService;
import lgs.admin.service.AdminStackService;

import org.springframework.stereotype.Service;

@Service("adminStackService")
public class AdminStackServiceImpl extends EgovAbstractServiceImpl implements AdminStackService {

	@Resource(name="adminStackMapper")
	private AdminStackMapper adminStackMapper;

	@Override
	public List<Map<String, Object>> searchList(Map<String, Object> map) {
		return adminStackMapper.searchList(map);
	}
	
	@Override
	public int countList() {
		return adminStackMapper.countList();
	}
	
	@Override
	public Map<String, Object> search(String map) {
		return adminStackMapper.search(map);
	}

	@Override
	public void add(Map<String, Object> map) {
		adminStackMapper.add(map);
	}

	@Override
	public void update(Map<String, Object> map) {
		adminStackMapper.update(map);
	}

	@Override
	public void delete(String map) {
		adminStackMapper.delete(map);
	}
}
