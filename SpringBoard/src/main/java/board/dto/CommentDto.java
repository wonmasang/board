package board.dto;

import java.sql.Date;

public class CommentDto {

	
	private int cmtno;
	private String cmtwriter;
	private String cmtcontent;
	private int cmtboardno;
	private String cmtpw;
	private Date reg_date;
	private int grp;
	private int grpord;
	private int depth;
	private int del;
	private int parentNo;
	private int parentChild;
	
	private int pnum;
	
	
	public int getCmtno() {
		return cmtno;
	}
	public void setCmtno(int cmtno) {
		this.cmtno = cmtno;
	}
	public String getCmtwriter() {
		return cmtwriter;
	}
	public void setCmtwriter(String cmtwriter) {
		this.cmtwriter = cmtwriter;
	}
	public String getCmtcontent() {
		return cmtcontent;
	}
	public void setCmtcontent(String cmtcontent) {
		this.cmtcontent = cmtcontent;
	}
	public int getCmtboardno() {
		return cmtboardno;
	}
	public void setCmtboardno(int cmtboardno) {
		this.cmtboardno = cmtboardno;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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
	public String getCmtpw() {
		return cmtpw;
	}
	public void setCmtpw(String cmtpw) {
		this.cmtpw = cmtpw;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	
	@Override
	public String toString() {
		return "ComentDto [cmtno=" + cmtno 
				+ ", pnum=" + pnum
				+ ", cmtwriter=" + cmtwriter 
				+ ", cmtcontent=" + cmtcontent 
				+ ", cmtboardno=" + cmtboardno 
				+ ", cmtpw=" + cmtpw	
				+ ", reg_date=" + reg_date 
				+ ", grp=" + grp 
				+ ", grpord=" + grpord 
				+ ", depth=" + depth
				+ ", del=" + del 
				+ ", parentNo=" + parentNo
				+ ", parentChild=" + parentChild
				+ "]";
	}
	
	
	
	
	
	
	
	
	
	
}
