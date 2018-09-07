package board.dto;

public class SearchDto {
	
	private String searchSelect;
	private String keyword;
	
	
	public String getSearchSelect() {
		return searchSelect;
	}
	public void setSearchSelect(String searchSelect) {
		this.searchSelect = searchSelect;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return "SearchDto [searchSelect=" + searchSelect + ", keyword=" + keyword + "]";
	}
	
	
	
}
