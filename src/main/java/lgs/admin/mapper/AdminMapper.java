/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
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
package lgs.admin.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

import java.util.List;
import java.util.Map;

@Mapper("adminMapper")
public interface AdminMapper {

	String loginChk(Map<String, Object> map) throws Exception;

	void userRegister(Map<String, Object> map);

	String overlapId(Map<String, Object> map) throws Exception;

	String selectPwFindQuiz(Map<String, Object> map);

	String selectPwFind(Map<String, Object> map);

	List<Map<String, Object>> selectLoginUserInfo(Map<String, Object> map);
}
