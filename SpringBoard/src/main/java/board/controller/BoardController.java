package board.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import board.dto.BoardDto;
import board.dto.CommentDto;
import board.dto.FileDto;
import board.dto.SearchDto;
import board.service.BoardService;
import board.util.Paging;

@Controller
public class BoardController {
	
	@Autowired
	private ServletContext context;
	@Autowired
	private BoardService boardService;

	
	@RequestMapping(value="/board/list.do", method={RequestMethod.GET, RequestMethod.POST})
	public String list(@RequestParam(defaultValue="0") int curPage, SearchDto searchDto
						, BoardDto boardDto, Model model, HttpServletResponse response) {
		
		if( searchDto.getKeyword() == null || searchDto.getKeyword().isEmpty() ) {
			
			
			//DB에서 전체 게시글 갯수 조회해서 totalCount에 담기
			int totalCount = boardService.boardTotalCount();
			System.out.println("전체 게시글 갯수 :"+totalCount);
			
//			System.out.println("페이징 객체에 현재 페이지가 뭐냐? " + curPage);
			
			//totalCount, curPage 값을 넘겨서 페이징 객체 생성
			Paging paging  = new Paging(totalCount, curPage);
			model.addAttribute("paging", paging);
			
			//페이징 처리 된 리스트 받아서 넘기기
			List<BoardDto> list = boardService.pagingList(paging);
//			System.out.println("리스트에 뭐있냐"+list.toString());
			
			model.addAttribute("list", list);

			return "/board/list";
			
		}else {
			
			System.out.println("검색어 받기 : " + searchDto.toString());
			
			//검색 키워드를 포함한 게시글의 total카운트
			int totalCount = boardService.searchTotalCount(searchDto);
			System.out.println("페이징 게시글 갯수 : " + totalCount);
			
			if( totalCount == 0 ) {
				
				System.out.println("페이징 게시글 갯수가 0 이니까 처음 리스트 페이지 호출");
				
				model.addAttribute("msg", "검색 결과가 없습니다.");
				model.addAttribute("url", "/board/list.do");
				
				return "/util/sarchAlert";
			}else {
				
				String keyword = searchDto.getKeyword();
				String searchSelect = searchDto.getSearchSelect();
				
				Paging paging  = new Paging(totalCount, curPage, keyword, searchSelect);
				
				System.out.println("페이징 객체에 있는 셀렉트 & 키워드 : " +paging.getSearchSelect()+ "," + paging.getKeyword());
				
				model.addAttribute("paging", paging);
				
				model.addAttribute("searchKeyword", keyword);
				model.addAttribute("searchSelected", searchSelect);
				
				List<BoardDto> list = boardService.pagingList(paging);
				model.addAttribute("list", list);
				
				return "/board/list";
			}
			
			
			
		}
		
		
	}
	
	@RequestMapping(value="/board/listView.do", method=RequestMethod.GET)
	public void listView(BoardDto boardDto, Model model, FileDto fileDto) {
		
		boardService.updateHit(boardDto);
		
		int rank = boardDto.getRank();
		int commentCount = boardDto.getCommentCount();
		
		
		List<FileDto> fileList = boardService.fileListView(boardDto);
		
		
		model.addAttribute("fileList", fileList);
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("rank", rank);
		model.addAttribute("listView", boardService.listView(boardDto));
		
	}
	
	@RequestMapping(value="/board/write.do", method=RequestMethod.GET)
	public void write() {
		
	}
	
	@RequestMapping(value="/board/write.do", method=RequestMethod.POST)
	public String write(BoardDto boardDto, FileDto fileDto) {
		boardService.write(boardDto);
		
		System.out.println("이건되냐 "+boardDto.getBoardNo());
		
		List<MultipartFile> file = fileDto.getFiles();
		System.out.println("file = "+file.size());
		
		String uID = UUID.randomUUID().toString().split("-")[0];
//		String realpath = context.getRealPath("C:\\upload\\uploadFile");
		String realpath = "C:\\upload\\uploadFile";
		
		File fileSet = new File(realpath);
		if(fileSet.exists() == false){
			fileSet.mkdirs();
		}

		for( int i = 0; i < file.size(); i++ ) {

			String stored = uID + "_" + file.get(i).getOriginalFilename();
		
			File dest = new File(realpath, stored);
		
			try {
				file.get(i).transferTo(dest);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
			fileDto.setB_original_filename(file.get(i).getOriginalFilename());
			fileDto.setB_stored_filename(stored);
			fileDto.setB_boardno(boardDto.getBoardNo());
			fileDto.setB_file_size(file.get(i).getSize());

			boardService.fileUpload(fileDto);
	
		}
		
		return "redirect:/board/list.do";
	}
	
	@RequestMapping(value="/board/downloadFile.do", method=RequestMethod.POST)
	public void downloadFile(FileDto fileDto, HttpServletResponse response) throws Exception {
		
		System.out.println("파일넘버 왔? " + fileDto.getB_fileno());
		
		FileDto f_Dto =  boardService.selectFile(fileDto);
		
		String original_filename = f_Dto.getB_original_filename(); 	
		String urlEncoding = URLEncoder.encode(original_filename, "UTF-8");
		urlEncoding = urlEncoding.replaceAll("\\+", "%20");
		String stored_filename = f_Dto.getB_stored_filename();
		System.out.println("파일 이름 찾았어? " + original_filename +", "+ stored_filename);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\uploadFile\\"+stored_filename));
	     
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
//	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(original_filename,"UTF-8")+"\";");
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + urlEncoding + "\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();


		
	}
	
	@RequestMapping(value="/board/modify.do", method=RequestMethod.GET)
	public void modify(BoardDto boardDto, Model model, FileDto fileDto) {
		
		BoardDto aboardDto = boardService.selectModify(boardDto);
		List<FileDto> fileList = boardService.fileListView(boardDto);
		
		
		model.addAttribute("modify", aboardDto);
		model.addAttribute("fileList", fileList);
		System.out.println("수정 : " + aboardDto.getTitle());
		System.out.println("수정2 : " + aboardDto.getPw());
		
	}
	
	@RequestMapping(value="/board/fileDelete.do", method=RequestMethod.POST)
	public @ResponseBody Map<Object, Object> fileDelete(FileDto fileDto) {
		boolean check;
		
		int fileCount = boardService.fileCount(fileDto);
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		if( fileCount == 1 ) {
			check = true;
			
			FileDto f_Dto = boardService.selectFile(fileDto);
			
			String stored_filename = f_Dto.getB_stored_filename();
			
			File file = new File("C:\\upload\\uploadFile\\"+stored_filename);

			if(file.exists() == true){

			file.delete();
			boardService.fileDelete(fileDto);

			}
			
			map.put("check", check);
			
		} else {
			check = false;
			map.put("check", check);
			
		}
		
		return map;
	}
	
	@RequestMapping(value="/board/modifyProc.do", method=RequestMethod.POST)
	public String modify(BoardDto boardDto, FileDto fileDto) {
		
		boardService.modify(boardDto);
		
		List<MultipartFile> file = fileDto.getFiles();
		System.out.println("file = "+file.size());
		
		String uID = UUID.randomUUID().toString().split("-")[0];
		String realpath = "C:\\upload\\uploadFile";
		
		File fileSet = new File(realpath);
		if(fileSet.exists() == false){
			fileSet.mkdirs();
		}

		for( int i = 0; i < file.size(); i++ ) {

			String stored = uID + "_" + file.get(i).getOriginalFilename();
		
			File dest = new File(realpath, stored);
		
			try {
				file.get(i).transferTo(dest);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
			fileDto.setB_original_filename(file.get(i).getOriginalFilename());
			fileDto.setB_stored_filename(stored);
			fileDto.setB_boardno(boardDto.getBoardNo());
			fileDto.setB_file_size(file.get(i).getSize());

			boardService.fileUpload(fileDto);
			
		}
		
		return "redirect:/board/list.do";
	}
	
	
	@RequestMapping(value="/board/modifyPwCheck.do", method=RequestMethod.GET)
	public void modifyPwCheck(int boardNo, Model model) {
		System.out.println("수정 B넘버 :"+boardNo);
		
		model.addAttribute("boardNo", boardNo);
		
	}
	
	@RequestMapping(value="/board/deletePwCheck.do", method=RequestMethod.GET)
	public void deletePwCheck(int boardNo, int parentNo, Model model) {
		System.out.println("삭제 B넘버 :"+boardNo);
		
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("parentNo", parentNo);
		
	}
	
	@RequestMapping(value="/board/pwCheckProc.do", method=RequestMethod.POST)
	public @ResponseBody Map<Object, Object> pwCheckProc(BoardDto boardDto) {
		System.out.println("ajax 값 확인 : "+boardDto.toString());
		
		boolean check;
		int count = boardService.countPwCheck(boardDto);
		System.out.println("비번체크 카운트" + count);
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		if( count == 1 ) {
			check = true;
			map.put("check", check);
			
		} else {
			check = false;
			map.put("check", check);
			
		}
				
		return map;
		
	}
	
	
	@RequestMapping(value="/board/delete.do", method=RequestMethod.GET)
	public String delete(BoardDto boardDto, Model model) {
//		System.out.println("내꺼보드넘버1"+boardDto.getBoardNo());
		
		//지우려는 글의 자식이 있는지 조회
		int sChild = boardService.selectchild(boardDto);
//		System.out.println("자식갯수"+sChild);
		
		
		if( sChild > 0 ) { //자식이 있으면 del 컬럼을 1로 update 함.(del=0 : 기본, del=1 : 삭제)
//			System.out.println("내꺼보드넘버2"+boardDto.getBoardNo());
			boardService.updateDel(boardDto);
			
		}else { //자식이 없으면 삭제 진행
//			System.out.println("내꺼보드넘버3"+boardDto.getBoardNo()+", "+boardDto.getParentNo());
			if( boardDto.getParentNo() == 0 ) { //삭제 시 부모가 없으면 바로 삭제
				boardService.delete(boardDto);
			}else {// 삭제 시 부모가 있으면 부모 상태 조회
			
				BoardDto parentDto = boardService.selectParent(boardDto);
//				System.out.println("부모상태"+parentDto.toString());
				
				// 부모글의 del=1이고 자식이 1명만(지금 나) 있으면 부모까지 함께 삭제 === 첨부파일도 함께 삭제
				if( parentDto.getDel() == 1 && parentDto.getParentChild() == 1) { 
//					System.out.println("전부삭제!!");
//					System.out.println(boardDto.toString());
					boardService.deleteAll(boardDto);
				
				// 부모글의 del=1이지만 자식이 1이상(나말고 또) 있으면 나만 삭제 === 첨부파일도 함께 삭제
				}else if( parentDto.getDel() == 1 && parentDto.getParentChild() > 1 ){ 
//					System.out.println("나만 삭제!! 1");
//					System.out.println(boardDto.toString());
					boardService.delete(boardDto);
					
				// 부모글의 del=0이면 나만 삭제 === 첨부파일도 함께 삭제
				}else if ( parentDto.getDel() == 0 ) { 
//					System.out.println("나만 삭제!! 2");
//					System.out.println(boardDto.toString());
					boardService.delete(boardDto);
				}
			
			}
			
		}
		
		return "redirect:/board/list.do";
	}
	
//	@RequestMapping(value="/board/search.do", method=RequestMethod.POST)
//	public String search(SearchDto searchDto, BoardDto boardDto, Model model) {
//		
//		System.out.println("검색어 받기 : " + searchDto.toString());
//		
//		model.addAttribute("search", boardService.searchList(searchDto));
//		
//		return "/board/searchList";
//	}
	
	@RequestMapping(value="/board/reply.do", method=RequestMethod.GET)
	public void reply(BoardDto boardDto, Model model) {
		
		int boardNo = boardDto.getBoardNo();
		int grp = boardDto.getGrp();
		int grpord = boardDto.getGrpord();
		int depth = boardDto.getDepth();
		
		model.addAttribute("parentNo", boardNo);
		model.addAttribute("grp", grp);
		model.addAttribute("grpord", grpord);
		model.addAttribute("depth", depth);
		
	}
	
	@RequestMapping(value="/board/reply.do", method=RequestMethod.POST)
	public String reply(BoardDto boardDto) {
		System.out.println("답글작성" + boardDto.toString());
		
		boardService.updateReply(boardDto);
		
		boardService.reply(boardDto);
		
		return "redirect:/board/list.do";
	}
	
	@RequestMapping(value="/board/commentList.do", method=RequestMethod.GET)
	public @ResponseBody List<CommentDto> commentList(int boardNo) {
		
		System.out.println("보드넘버왔냐? "+boardNo);
		
		List<CommentDto> cmtList = boardService.commentList(boardNo);
		System.out.println(cmtList.toString());
		
		return cmtList;
	}
	
	@RequestMapping(value="/board/commentInsert.do", method=RequestMethod.POST)
	public String commentInsert(CommentDto commentDto) {
		
		boardService.commentInsert(commentDto);
		
		return "/board/comment";
	}
	
	@RequestMapping(value="/board/commentReply.do", method=RequestMethod.POST)
	public String commentReply(CommentDto commentDto) {
		
		System.out.println("댓글 투스트링"+commentDto.toString());
		boardService.commentUpdate(commentDto);
		
		boardService.commentReply(commentDto);
		
		return "/board/comment";
	}
	
	@RequestMapping(value="/board/commDelPwCheck.do", method=RequestMethod.GET)
	public void commDelPwCheck(int cmtno, int parentNo, int boardNo, Model model) {
		System.out.println("삭제 B넘버 :"+cmtno);
		
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("cmtno", cmtno);
		model.addAttribute("parentNo", parentNo);
		
	}
	
	@RequestMapping(value="/board/commentPwCheckProc.do", method=RequestMethod.POST)
	public @ResponseBody Map<Object, Object> commentPwCheckProc(CommentDto commentDto) {
		System.out.println("ajax 값 확인 : "+commentDto.toString());
		
		boolean check;
		int commCount = boardService.countPwCheckComm(commentDto);
		System.out.println("비번체크 카운트" + commCount);
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		if( commCount == 1 ) {
			check = true;
			map.put("check", check);
			
		} else {
			check = false;
			map.put("check", check);
			
		}
				
		return map;
		
	}
	
	
	@RequestMapping(value="/board/commentDelete.do", method=RequestMethod.GET)
	public String commentDelete(CommentDto commentDto, int boardNo) {
		
		System.out.println("내꺼 cmtno "+commentDto.getCmtno());
		
		int selChild = boardService.selectChildComment(commentDto);
		System.out.println("자식갯수 "+selChild);
		
		if( selChild > 0 ) {
			boardService.commUpdateDel(commentDto);
		}else {
			System.out.println("내꺼cmtno3 "+commentDto.getCmtno()+", "+commentDto.getParentNo());
			
			if( commentDto.getParentNo() == 0 ) {
				boardService.commDelete(commentDto);
			}else {
				
				CommentDto parentCommDto = boardService.selectComParent(commentDto);
				
				System.out.println("부모상태"+parentCommDto.toString());
				
				if( parentCommDto.getDel() == 1 && parentCommDto.getParentChild() == 1) {
					System.out.println("전부삭제!!");
//					System.out.println(parentCommDto.toString());
					boardService.commDeleteAll(commentDto);
				}else if( parentCommDto.getDel() == 1 && parentCommDto.getParentChild() > 1 ){
					System.out.println("나만 삭제!! 1");
//					System.out.println(commentDto.toString());
					boardService.commDelete(commentDto);
				}else if ( parentCommDto.getDel() == 0) {
					System.out.println("나만 삭제!! 2");
//					System.out.println(commentDto.toString());
					boardService.commDelete(commentDto);
				}
			}
		}
		
//		return "redirect:/board/list.do";
		return "redirect:/board/listView.do?boardNo="+boardNo;
	}
	
	
	
	
}
