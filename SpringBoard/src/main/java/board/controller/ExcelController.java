package board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.dto.SearchDto;
import board.service.ExcelService;

@Controller
public class ExcelController {
	
	@Autowired
	ExcelService excelService;
	
	
	@RequestMapping("/board/excelTransform.do") 
	public String excelTransform(@RequestParam String target, SearchDto searchDto , Map<String,Object> ModelMap) throws Exception{ 
		
		System.out.println("타겟 = "+target);
		System.out.println("키워드 = "+searchDto.toString());
		
		List<Object> excelList= null; 
		excelList = excelService.getAllObjects(target, searchDto); 
//		System.out.println("조회결과 = "+excelList.toString());
		
		ModelMap.put("search", searchDto);
		ModelMap.put("excelList", excelList);
		ModelMap.put("target", target); 
		return "excelView"; 

	}
	
}
