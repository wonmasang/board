package board.service;

import java.util.List;

import board.dto.BoardDto;
import board.dto.CommentDto;
import board.dto.FileDto;
import board.dto.SearchDto;
import board.util.Paging;

public interface BoardService {
	
	//리스트 페이지
	public List<BoardDto> list();
	
	//페이징시 필요한 전체 게시글 갯수 조회
	public int boardTotalCount();
	
	//페이징 처리된 게시글 리스트
	public List<BoardDto> pagingList(Paging paging);
	
	//검색 한 게시글의 갯수
	public int searchTotalCount(SearchDto searchDto);
	
	//상세 페이지
	public BoardDto listView(BoardDto boardDto);
	
	//상세 페이지 -> 업로드된 파일 불러오기
	public List<FileDto> fileListView(BoardDto boardDto);
	
	//상세페이지 접속시 마다 조회수 증가
	public void updateHit(BoardDto boardDto);
	
	//게시글 작성 
	public void write(BoardDto boardDto);
	
	//게시글 작성시 파일 업로드도 진행
	public void fileUpload(FileDto fileDto);
	
	//파일 다운로드 호출 시 파일 번호로 DB내용 조회
	public FileDto selectFile(FileDto fileDto);
	
	//게시글 수정 페이지 로드시 글번호로 작성자 조회
	public BoardDto selectModify(BoardDto boardDto);
	
	//게시글 수정
	public void modify(BoardDto boardDto);
	
	//파일 번호를 받아서 파일이 있는지 확인
	public int fileCount(FileDto fileDto);
	
	//파일이 있으면 삭제
	public void fileDelete(FileDto fileDto);
	
	//삭제전에 나의 자식 답글이 있는지 조회
	public int selectchild(BoardDto boardDto);
	
	//게시글 삭제(삭제 실행시 del 컬러의 값을 1로 업데이트함)
	public void updateDel(BoardDto boardDto);
	
	//답글 완젼 삭제 전에 부모도 같이 지울지 부모 상태 확인
	public BoardDto selectParent(BoardDto boardDto);
	
	//답글 부모상태가 del=1이면 부모 자식 모두 완젼 삭제
	public void deleteAll(BoardDto boardDto);
	
	//게시글 완젼 삭제
	public void delete(BoardDto boardDto);
	
	//게시글 패스워드 확인 카운트 리턴
	public int countPwCheck(BoardDto boardDto);
	
	//답글 작성 시 기존 답글의 grpord를 +1 업데이트 해주는 메소드
	public void updateReply(BoardDto boardDto);
	
	//답글 작성
	public void reply(BoardDto boardDto);
	
	//댓글 리스트 
	public List<CommentDto> commentList(int boardNo);
	
	//댓글 작성
	public void commentInsert(CommentDto commentDto);
	
	//댓글 작성시 기존 댓글의 grpord를 +1 업데이트 해주는 메소드
	public void commentUpdate(CommentDto commentDto);
	
	//대댓글 작성
	public void commentReply(CommentDto commentDto);
	
	//삭제 전에 나의 자식 댓글이 있는지 조회
	public int selectChildComment(CommentDto commentDto);
	
	//댓글 삭제(삭제 실행시 del 컬러의 값을 1로 업데이트함)
	public void commUpdateDel(CommentDto commentDto);
	
	//댓글 완젼 삭제 전에 부모도 같이 지울지 부모 상태 확인
	public CommentDto selectComParent(CommentDto commentDto);
	
	//답글 부모상태가 del=1이면 부모 자식 모두 완젼 삭제
	public void commDeleteAll(CommentDto commentDto);
	
	//삭제전 비번 체크
	public int countPwCheckComm(CommentDto commentDto);
	
	//게시글 완젼 삭제
	public void commDelete(CommentDto commentDto);
	
//	//게시글 검색 결과 리스트
//	public List<BoardDto> searchList(SearchDto searchDto);

}
