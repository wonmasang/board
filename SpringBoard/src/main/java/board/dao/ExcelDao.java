package board.dao;

import java.util.List;

import board.dto.SearchDto;


public interface ExcelDao {
	
	public List<Object> getAllList();
	
	public List<Object> getSearchList(SearchDto searchDto);
	
//	public List<Object> getAllFiles();

}
