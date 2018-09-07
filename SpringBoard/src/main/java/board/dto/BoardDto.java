package board.dto;

import java.sql.Date;

public class BoardDto {
	
	private int rnum;
	private int pnum;
	private int rank;
	private int grp;
	private int grpord;
	private int depth;
	private int del;
	private int parentNo;
	
	private int boardNo;
	private String title;
	private String content;
	private String writer;
	private String pw;
	private Date reg_date;
	private int hit;
	
	private int commentCount;
	private int parentChild;
	
	private int fileCount;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrpord() {
		return grpord;
	}
	public void setGrpord(int grpord) {
		this.grpord = grpord;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public int getParentNo() {
		return parentNo;
	}
	public void setParentNo(int parentNo) {
		this.parentNo = parentNo;
	}
	public int getParentChild() {
		return parentChild;
	}
	public void setParentChild(int parentChild) {
		this.parentChild = parentChild;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	
	@Override
	public String toString() {
		return "BoardDto [rnum=" + rnum 
				+ ", pnum=" + pnum
				+ ", rank=" + rank 
				+ ", grp=" + grp 
				+ ", grpord=" + grpord 
				+ ", depth=" + depth
				+ ", boardNo=" + boardNo 
				+ ", title=" + title 
				+ ", content=" + content 
				+ ", writer=" + writer 
				+ ", pw="+ pw 
				+ ", reg_date=" + reg_date 
				+ ", hit=" + hit 
				+ ", del=" + del
				+ ", commentCount=" + commentCount
				+ ", parentNo=" + parentNo
				+ ", parentChild=" + parentChild
				+ ", fileCount=" + fileCount
				+ "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
