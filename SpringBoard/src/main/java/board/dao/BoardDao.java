package board.dao;

import java.util.List;

import board.dto.BoardDto;
import board.dto.CommentDto;
import board.dto.FileDto;
import board.dto.SearchDto;
import board.util.Paging;

public interface BoardDao {

	public List<BoardDto> list();
	
	public int boardTotalCount();
	
	public List<BoardDto> pagingList(Paging paging);
	
	public int searchTotalCount(SearchDto searchDto);
	
	public BoardDto listView(BoardDto boardDto);
	
	public List<FileDto> fileListView(BoardDto boardDto);
	
	public void updateHit(BoardDto boardDto);
	
	public void write(BoardDto boardDto);
	
	public void fileUpload(FileDto fileDto);
	
	public FileDto selectFile(FileDto fileDto);
	
	public BoardDto selectModify(BoardDto boardDto);
	
	public void modify(BoardDto boardDto);
	
	public int fileCount(FileDto fileDto);
	
	public void fileDelete(FileDto fileDto);
	
	public int selectchild(BoardDto boardDto);
	
	public void updateDel(BoardDto boardDto);
	
	public BoardDto selectParent(BoardDto boardDto);
	
	public void deleteAll(BoardDto boardDto);
	
	public void fileDoDelete(BoardDto boardDto);
	
	public void delete(BoardDto boardDto);
	
	public int countPwCheck(BoardDto boardDto);
	
	public void updateReply(BoardDto boardDto);
	
	public void reply(BoardDto boardDto);
	
	public List<CommentDto> commentList(int boardNo);
	
	public void commentInsert(CommentDto commentDto);
	
	public void commentUpdate(CommentDto commentDto);
	
	public void commentReply(CommentDto commentDto);
	
	public int selectChildComment(CommentDto commentDto);
	
	public void commUpdateDel(CommentDto commentDto);
	
	public CommentDto selectComParent(CommentDto commentDto);
	
	public void commDeleteAll(CommentDto commentDto);
		
	public int countPwCheckComm(CommentDto commentDto);
	
	public void commDelete(CommentDto commentDto);
		
//	public List<BoardDto> searchList(SearchDto searchDto);
	
	
	
}
