package board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dao.BoardDao;
import board.dto.BoardDto;
import board.dto.CommentDto;
import board.dto.FileDto;
import board.dto.SearchDto;
import board.util.Paging;

@Service
public class BoardServiiceImp implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public List<BoardDto> list() {
		
		return boardDao.list();
	}
	
	@Override
	public int boardTotalCount() {
		return boardDao.boardTotalCount();
	}
	
	@Override
	public List<BoardDto> pagingList(Paging paging) {
		return boardDao.pagingList(paging);
	}
	
	@Override
	public int searchTotalCount(SearchDto searchDto) {
		return boardDao.searchTotalCount(searchDto);
	}
	
	@Override
	public BoardDto listView(BoardDto boardDto) {
		return boardDao.listView(boardDto);
	}
	
	@Override
	public List<FileDto> fileListView(BoardDto boardDto) {
		return boardDao.fileListView(boardDto);
	}
	
	@Override
	public void updateHit(BoardDto boardDto) {
		boardDao.updateHit(boardDto);
	}
	
	@Override
	public void write(BoardDto boardDto) {
		boardDao.write(boardDto);
	}
	
	@Override
	public void fileUpload(FileDto fileDto) {
		boardDao.fileUpload(fileDto);
	}
	
	@Override
	public FileDto selectFile(FileDto fileDto) {
		return boardDao.selectFile(fileDto);
	}
	
	@Override
	public BoardDto selectModify(BoardDto boardDto) {
		return boardDao.selectModify(boardDto);
	}
	
	@Override
	public void modify(BoardDto boardDto) {
		boardDao.modify(boardDto);
	}
	
	@Override
	public int fileCount(FileDto fileDto) {
		return boardDao.fileCount(fileDto);
	}
	
	@Override
	public void fileDelete(FileDto fileDto) {
		boardDao.fileDelete(fileDto);
	}
	
	@Override
	public int selectchild(BoardDto boardDto) {
		return boardDao.selectchild(boardDto);
	}
	
	@Override
	public void updateDel(BoardDto boardDto) {
		boardDao.updateDel(boardDto);
	}
	
	@Override
	public BoardDto selectParent(BoardDto boardDto) {
		return boardDao.selectParent(boardDto);
	}
	
	@Override
	public void deleteAll(BoardDto boardDto) {
		boardDao.deleteAll(boardDto);
		boardDao.fileDoDelete(boardDto);
	}
	
	@Override
	public void delete(BoardDto boardDto) {
		boardDao.delete(boardDto);
		boardDao.fileDoDelete(boardDto);
	}
	
	@Override
	public int countPwCheck(BoardDto boardDto) {
		return boardDao.countPwCheck(boardDto);
	}
	
	@Override
	public void updateReply(BoardDto boardDto) {
		boardDao.updateReply(boardDto);
	}
	
	@Override
	public void reply(BoardDto boardDto) {
		boardDao.reply(boardDto);
	}
	
	@Override
	public List<CommentDto> commentList(int boardNo) {
		return boardDao.commentList(boardNo);
	}
	
	@Override
	public void commentInsert(CommentDto commentDto) {
		boardDao.commentInsert(commentDto);
	}
	
	@Override
	public void commentUpdate(CommentDto commentDto) {
		boardDao.commentUpdate(commentDto);
	}
	
	@Override
	public void commentReply(CommentDto commentDto) {
		boardDao.commentReply(commentDto);
	}
	
	@Override
	public int selectChildComment(CommentDto commentDto) {
		return boardDao.selectChildComment(commentDto);
	}
	
	@Override
	public void commUpdateDel(CommentDto commentDto) {
		boardDao.commUpdateDel(commentDto);
	}
	
	@Override
	public CommentDto selectComParent(CommentDto commentDto) {
		return boardDao.selectComParent(commentDto);
	}
	
	@Override
	public void commDeleteAll(CommentDto commentDto) {
		boardDao.commDeleteAll(commentDto);
	}
	
	@Override
	public int countPwCheckComm(CommentDto commentDto) {
		return boardDao.countPwCheckComm(commentDto);
	}
	
	@Override
	public void commDelete(CommentDto commentDto) {
		boardDao.commDelete(commentDto);
	}
	
//	@Override
//	public List<BoardDto> searchList(SearchDto searchDto) {
//		return boardDao.searchList(searchDto);
//	}
	
	
}
