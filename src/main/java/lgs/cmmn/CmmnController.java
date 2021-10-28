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
package lgs.cmmn;

import lgs.cmmn.service.CmmnService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * CmmnController 공통 컨트롤러
 */

@Controller
public class CmmnController {

    /**
     * CmmnService
     */
    @Resource(name = "cmmnService")
    private CmmnService cmmnService;

    /**
    * Upload file Path [global.propoerties]
    */
	@Value("#{globalProperties['upload.filepath']}")
    private String filePath;

    @Value("#{globalProperties['upload.summerNotePath']}")
    private String summerNotePath;

    /**
     * name : selectCode (AJAX)
     * description : 코드 데이터를 조회한다. (콤보로드)
     */
    @RequestMapping("/cmmn/selectCode")
    public @ResponseBody
    ModelAndView selectCode(@RequestParam Map<String, Object> param
            , HttpSession session
            , HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("codeList", cmmnService.selectCode(param));
        return mv;
    }

    /**
     * name : selectBbsCode (AJAX)
     * description : 게시판 코드 데이터를 조회한다. (콤보로드 커스텀)
     */
    @RequestMapping("/cmmn/selectBbsCode")
    public @ResponseBody
    ModelAndView selectBbsCode(@RequestParam Map<String, Object> param
            , HttpSession session
            , HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("codeList", cmmnService.selectBbsCode());
        return mv;
    }

    /**
     * name : fileUpload (AJAX)
     * description : 파일을 업로드한다.
     */
    @RequestMapping("/fileUpload")
    public @ResponseBody
    String fileUpload(@RequestParam("file") MultipartFile multi
            , HttpServletRequest request
            , HttpServletResponse response
            , Model model) throws Exception {
        try {
        	/* 폴더생성 */
            Utils.makeDir(filePath);

            String originFilename = multi.getOriginalFilename();
            String fileName = originFilename.substring(0, originFilename.lastIndexOf("."));
            String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
            String saveFileName = Utils.genSaveFileName();
			long size = multi.getSize();

            if (!multi.isEmpty()) {
                File file = new File(filePath, saveFileName+extName);
                multi.transferTo(file);

                Map<String, Object> fileMap = new HashMap<String, Object>();
                String fileNo = cmmnService.getMaxfileNo();

                fileMap.put("fileNo", fileNo); //파일번호
				fileMap.put("fileName", fileName); //파일명
				fileMap.put("filePath", filePath); //파일경로
				fileMap.put("fileExten", extName); //파일확장자
				fileMap.put("fileSize", size); //파일사이즈
				fileMap.put("saveFileName", saveFileName); //저장파일이름

				// DB 저장
				cmmnService.insertFile(fileMap);

                return fileNo;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return "redirect:form";
    }

    @RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json")
    @ResponseBody
    public ModelAndView uploadSummernoteImageFile(@RequestParam("file") MultipartFile multi
            , HttpServletRequest request
            , HttpServletResponse response
            , Model model) {

        ModelAndView mv = new ModelAndView("jsonView");
        try {
            /* 폴더생성 */
            Utils.makeDir(filePath);

            String originFilename = multi.getOriginalFilename();
            String fileName = originFilename.substring(0, originFilename.lastIndexOf("."));
            String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
            String saveFileName = Utils.genSaveFileName();
            long size = multi.getSize();

            if (!multi.isEmpty()) {
                File file = new File(filePath, saveFileName+extName);
                multi.transferTo(file);
                mv.addObject("url", summerNotePath+saveFileName+extName);

                return mv;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return mv;

    }
}