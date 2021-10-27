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
import lgs.admin.mapper.PostMapper;
import lgs.admin.service.PostService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("postService")
public class PostServiceImpl extends EgovAbstractServiceImpl implements PostService {

	@Resource(name="postMapper")
	private PostMapper postMapper;

	@Override
	public List<Map<String, Object>> searchList(Map<String, Object> map) {
		return postMapper.searchList(map);
	}
	
	@Override
	public int countList() {
		return postMapper.countList();
	}
	
	@Override
	public List<Map<String, Object>> search(Map<String, Object> map) {
		return postMapper.search(map);
	}

	@Override
	public void add(Map<String, Object> map) {
		postMapper.add(map);
	}

	@Override
	public void update(Map<String, Object> map) {
		postMapper.update(map);
	}

	@Override
	public void delete(Map<String, Object> map) {
		postMapper.delete(map);
	}
}
