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
package lgs.cmmn.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import lgs.cmmn.mapper.CmmnMapper;
import lgs.cmmn.service.CmmnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("cmmnService")
public class CmmnServiceImpl extends EgovAbstractServiceImpl implements CmmnService {

	@Autowired
	private CmmnMapper cmmnMapper;

	@Override
	public List<Map<String, Object>> selectCode(Map<String, Object> map) throws Exception{
		return cmmnMapper.selectCode(map);
	}

	@Override
	public String getMaxfileNo() throws Exception {
		return cmmnMapper.getMaxfileNo();
	}

	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		cmmnMapper.insertFile(map);
	}
}
