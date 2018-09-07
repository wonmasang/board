package board.service;

import java.util.List;

import board.dto.SearchDto;

public interface ExcelService {

	public List<Object> getAllObjects(String target, SearchDto searchDto);
	
	
	
}
