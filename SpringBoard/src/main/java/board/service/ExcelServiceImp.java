package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dao.ExcelDao;
import board.dto.BoardDto;
import board.dto.CommentDto;
import board.dto.SearchDto;

@Service
public class ExcelServiceImp implements ExcelService{

	@Autowired
	ExcelDao excelDao;
	
	
	@Override
	public List<Object> getAllObjects(String target, SearchDto searchDto) {
		
		if(target.equals("List")) {
			return excelDao.getAllList(); 
		}
		
		if(target.equals("searchList")) {
			return excelDao.getSearchList(searchDto);
		}
		
//		if(target.equals("searchList")) {
//			return excelDao.getAllFiles();
//		}

		
		return null;
	}
	
	
}
