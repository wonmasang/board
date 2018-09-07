package board.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileDto {

	private int b_fileno;
	private int b_boardno;
	private String b_original_filename;
	private String b_stored_filename;
	private long b_file_size;
	private double file_size_kb;
	private Date b_upload_date;
	private int b_del;
	private List<MultipartFile> files;
	
	public int getB_fileno() {
		return b_fileno;
	}
	public void setB_fileno(int b_fileno) {
		this.b_fileno = b_fileno;
	}
	public int getB_boardno() {
		return b_boardno;
	}
	public void setB_boardno(int b_boardno) {
		this.b_boardno = b_boardno;
	}
	public String getB_original_filename() {
		return b_original_filename;
	}
	public void setB_original_filename(String b_original_filename) {
		this.b_original_filename = b_original_filename;
	}
	public String getB_stored_filename() {
		return b_stored_filename;
	}
	public void setB_stored_filename(String b_stored_filename) {
		this.b_stored_filename = b_stored_filename;
	}
	public long getB_file_size() {
		return b_file_size;
	}
	public void setB_file_size(long b_file_size) {
		this.b_file_size = b_file_size;
	}
	public Date getB_upload_date() {
		return b_upload_date;
	}
	public void setB_upload_date(Date b_upload_date) {
		this.b_upload_date = b_upload_date;
	}
	public int getB_del() {
		return b_del;
	}
	public void setB_del(int b_del) {
		this.b_del = b_del;
	}
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	
	@Override
	public String toString() {
		return "FileDto [b_fileno=" + b_fileno 
				+ ", b_boardno=" + b_boardno 
				+ ", b_original_filename=" + b_original_filename 
				+ ", b_stored_filename=" + b_stored_filename 
				+ ", b_file_size=" + b_file_size
				+ ", b_upload_date=" + b_upload_date 
				+ ", b_del=" + b_del 
				+ "]";
	}
	public double getFile_size_kb() {
		return file_size_kb;
	}
	public void setFile_size_kb(double file_size_kb) {
		this.file_size_kb = file_size_kb;
	}
	
	
	
	
	
	
	
}
