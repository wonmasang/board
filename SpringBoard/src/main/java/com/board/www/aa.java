package com.board.www;

public class aa {
	public static void main(String[] args) {
		int curPage =15;//현제 페이지
		int pageCount = 5; //노출 페이지갯수
		int listCount = 10; //페이지당 개시글
		int totalCount = 150; //전체 목록
		
		int totalPage = totalCount / listCount;
		
		if( totalCount % listCount > 0 ) {
			totalPage++;
		}	
		if (totalPage < curPage) {
			curPage = totalPage;
		}else {
			curPage = curPage;
		}
		
		System.out.println("토탈페이지 : " + totalPage);
		
		int totalBlock = (totalPage/pageCount);
		if( totalPage % pageCount > 0 ) totalBlock++;
		System.out.println("토탈블럭 : " + totalBlock);
		
		int curBlock = (((curPage-1)/pageCount)+1);
		System.out.println("현재블럭 : " + curBlock);
		
		int startPage = ((curPage-1)/pageCount)*pageCount+1;
		System.out.println("현재페이지 블럭 시작 :"+startPage);
		int endPage = startPage+(pageCount-1);
		if(endPage > totalPage)	endPage = totalPage;
		System.out.println("현재페이지 블럭 끝 :"+endPage);
		
		int prevBlock;
		if( curBlock <= 1) {// 0 < curPage >= 5  or  curPage <= 0 , curPage>0 && curPage<=pageCount || curPage <= 0
			prevBlock = 1;
		}else {
			prevBlock = startPage-1;
		}
		System.out.println("이전블럭페이지 : "+ prevBlock);
		int nextPage;
		if( curBlock >= totalBlock ) {// curBlock >= totalBlock
			nextPage = totalPage;
		}else {
			nextPage = endPage+1;
		}
		System.out.println("다음블럭페이지 : " + nextPage);
		
		int p;
		if(curPage == 1) {
			p=1;
		}else {
			p=(curBlock-1)*pageCount;
		}
		System.out.println(p);
		
//		int prevPage = (curBlock == 1)? 1:(curBlock-1)*pageCount;
//		(curPage == 1)? 1:(curBlock-1)*pageCount;
//int prevBlock;
//if( curBlock == 1 ) {
//	prevBlock = 1;
//}else {
//	prevBlock = (curBlock-1)*blockCount;
//}
//System.out.println("이전블럭페이지 : "+ prevBlock);

//int nextPage = curBlock >= totalPage ? (curBlock*blockCount) : (curBlock*blockCount)+1;
//System.out.println("다음블럭페이지 : " + nextPage);
	}
}
