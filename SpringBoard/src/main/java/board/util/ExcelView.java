package board.util;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFCreationHelper;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

//import org.apache.poi.hssf.usermodel.HSSFRow;
//import org.apache.poi.hssf.usermodel.HSSFSheet;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.springframework.web.servlet.view.document.AbstractExcelView;

import board.dto.BoardDto;
import board.dto.SearchDto;


//public class ExcelView extends AbstractExcelView { // .xls(엑셀 2007년 이전 버전)

//	@Override
//	protected void buildExcelDocument(Map<String, Object> ModelMap, HSSFWorkbook workBook, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//
//		String excelName = ModelMap.get("target").toString();
//		System.out.println("엑셀네임왔냐? "+excelName);
////		System.out.println("엑셀내용왔냐? "+ModelMap.get("excelList").toString());
//		HSSFSheet workSheet = null;
//		HSSFRow row = null;
//		
//		
//		if( excelName.equals("List")) {
//			excelName = URLEncoder.encode("게시글 목록", "UTF-8").replaceAll("\\+", "%20");
////			workSheet = workBook.createSheet((URLEncoder.encode(excelName+" WorkSheet", "UTF-8")).replaceAll("\\+", "%20"));
//			String sheetName = (URLEncoder.encode(excelName+" WorkSheet", "UTF-8")).replaceAll("\\+", "%20");
//			
//			
//			workSheet = workBook.createSheet();
//			workBook.setSheetName(0, sheetName);
//			
//			
//			@SuppressWarnings("unchecked")
//			List<BoardDto> list = (List<BoardDto>)ModelMap.get("excelList");
//			
//			
//			row = workSheet.createRow(0);
//			row.createCell(0).setCellValue("글번호");
//			row.createCell(1).setCellValue("제목");
//			row.createCell(2).setCellValue("작성자");
//			row.createCell(3).setCellValue("내용");
//			row.createCell(4).setCellValue("비밀번호");
//			row.createCell(5).setCellValue("작성일");
//			row.createCell(6).setCellValue("조회수");
//			
//			for( int i=0; i<list.size(); i++ ) {
//				row = workSheet.createRow(i+1);
//				row.createCell(0).setCellValue(list.get(i).getPnum());
//				row.createCell(1).setCellValue(list.get(i).getTitle());
//				row.createCell(2).setCellValue(list.get(i).getWriter());
//				row.createCell(3).setCellValue(list.get(i).getContent());
//				row.createCell(4).setCellValue(list.get(i).getPw());
//				row.createCell(5).setCellValue(list.get(i).getReg_date());
//				row.createCell(6).setCellValue(list.get(i).getHit());
//			}
//			
//			
//		}
//		
//		
//		if( excelName.equals("comment")) {
//			excelName = URLEncoder.encode("댓글목록", "UTF-8");
//			workSheet = workBook.createSheet(excelName + " WorkSheet");
//			
//			@SuppressWarnings("unchecked")
//			List<CommentDto> list = (List<CommentDto>)ModelMap.get("excelList");
//			
//			row = workSheet.createRow(0);
//			row.createCell(0).setCellValue("댓글번호");
//			row.createCell(1).setCellValue("작성자");
//			row.createCell(2).setCellValue("작성일");
//			row.createCell(3).setCellValue("내용");
//			row.createCell(4).setCellValue("비밀번호");
//			row.createCell(5).setCellValue("게시글번호");
//			
//			for( int i=1; i<list.size(); i++ ) {
//				row = workSheet.createRow(i+1);
//				row.createCell(0).setCellValue(list.get(i).getPnum());
//				row.createCell(1).setCellValue(list.get(i).getCmtwriter());
//				row.createCell(2).setCellValue(list.get(i).getReg_date());
//				row.createCell(3).setCellValue(list.get(i).getCmtcontent());
//				row.createCell(4).setCellValue(list.get(i).getCmtpw());
//				row.createCell(5).setCellValue(list.get(i).getCmtboardno());
//			}
//			
//			
//		}
//		
//		
//		
//		response.setContentType("application/vnd.ms-excel"); 
////		response.setContentType(getContentType());
//		response.setHeader("Content-Disposition", "attachment; filename="+excelName+".xls");
//
//		
//	}
//	
//}



public class ExcelView extends AbstractView {
	
	@SuppressWarnings({ "unchecked", "resource" })
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String targetName = model.get("target").toString();
		System.out.println("엑셀네임왔냐? "+targetName);
		System.out.println("엑셀내용왔냐? "+model.get("excelList").toString());
		
		
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = null;
		XSSFRow row = null;
		XSSFCell cell = null;
		
		//날짜 포멧 바꿔주는 스타일부분
		XSSFCreationHelper helper = workbook.getCreationHelper();
		XSSFCellStyle dateStyle = workbook.createCellStyle();
		dateStyle.setDataFormat(helper.createDataFormat().getFormat("yyyy-MM-dd"));
		dateStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		dateStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);						
		dateStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);					
		dateStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);					
		dateStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		
		//엑셀 맨 윗 부분 스타일
		XSSFCellStyle header = workbook.createCellStyle();
		header.setAlignment(XSSFCellStyle.ALIGN_CENTER);					//폭 가운데 정렬
		header.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);			//높이 가운데 정렬
		header.setBorderTop(XSSFCellStyle.BORDER_THIN);						//위 테두리 선
		header.setBorderBottom(XSSFCellStyle.BORDER_THIN);					//아래 테두리 선
		header.setBorderLeft(XSSFCellStyle.BORDER_THIN);					//왼쪽 테두리 선
		header.setBorderRight(XSSFCellStyle.BORDER_THIN);					//오른쪽 테두리 선
		header.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		header.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		
		//엑셀 맨 윗 부분 폰트 스타일
		Font font = workbook.createFont();
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);							//글자 굵게
		header.setFont(font);
		
		//엑셀 헤더 제외 밑에 부분 스타일
		XSSFCellStyle content = workbook.createCellStyle();
		content.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		content.setBorderTop(XSSFCellStyle.BORDER_THIN);						
		content.setBorderBottom(XSSFCellStyle.BORDER_THIN);					
		content.setBorderLeft(XSSFCellStyle.BORDER_THIN);					
		content.setBorderRight(XSSFCellStyle.BORDER_THIN);
		
		// 제목, 작성자, 내용 부분은 스타일을 다르게 하기 위해 따로 작성
		XSSFCellStyle twc = workbook.createCellStyle();
		twc.setBorderTop(XSSFCellStyle.BORDER_THIN);						
		twc.setBorderBottom(XSSFCellStyle.BORDER_THIN);					
		twc.setBorderLeft(XSSFCellStyle.BORDER_THIN);					
		twc.setBorderRight(XSSFCellStyle.BORDER_THIN);
		
		
		
		if( targetName.equals("List")) {
			
			List<BoardDto> list = (List<BoardDto>)model.get("excelList");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
			Date date = new Date();
			String curDate = sdf.format(date);
			
			String name = "게시글 목록--"+curDate;
			
			String excelName = URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "%20");
			String sheetName = (name+" WorkSheet");
			
			sheet = workbook.createSheet();
			workbook.setSheetName(0, sheetName);
			
			
			for( int j=0; j<list.size(); j++ ) {
//				sheet.autoSizeColumn(i);
				sheet.setColumnWidth(j, (sheet.getColumnWidth(j))+1024);
				if ( j == 1 ) {
					sheet.setColumnWidth(1, (sheet.getColumnWidth(1))+2048);
				}else if( j == 3 ) {
					sheet.setColumnWidth(3, (sheet.getColumnWidth(3))+3072);
				}
				
			}
			
			
				row = sheet.createRow(0);
				cell = row.createCell(0);
				row.createCell(0).setCellValue("글번호");
				cell.setCellStyle(header);
				
				cell = row.createCell(1);
				row.createCell(1).setCellValue("제목");
				row.setHeightInPoints(23);
				cell.setCellStyle(header);
				
				cell = row.createCell(2);
				row.createCell(2).setCellValue("작성자");
				cell.setCellStyle(header);
				
				cell = row.createCell(3);
				row.createCell(3).setCellValue("내용");
				cell.setCellStyle(header);
				
				cell = row.createCell(4);
				row.createCell(4).setCellValue("비밀번호");
				cell.setCellStyle(header);
				
				cell = row.createCell(5);
				row.createCell(5).setCellValue("작성일");
				cell.setCellStyle(header);
				
				cell = row.createCell(6);
				row.createCell(6).setCellValue("조회수");
				cell.setCellStyle(header);
				
			
			
			for( int i=0; i<list.size(); i++ ) {
				row = sheet.createRow(i+1);
				
				cell = row.createCell(0);
				row.createCell(0).setCellValue(list.get(i).getPnum());
				cell.setCellStyle(content);
				
				cell = row.createCell(1);
				row.createCell(1).setCellValue(list.get(i).getTitle());
				cell.setCellStyle(twc);
				
				cell = row.createCell(2);
				row.createCell(2).setCellValue(list.get(i).getWriter());
				cell.setCellStyle(twc);
				
				cell = row.createCell(3);
				row.createCell(3).setCellValue(list.get(i).getContent());
				cell.setCellStyle(twc);
				
				cell = row.createCell(4);
				row.createCell(4).setCellValue(list.get(i).getPw());
				cell.setCellStyle(content);
				
				cell = row.createCell(5);
				row.createCell(5).setCellValue(list.get(i).getReg_date());
				cell.setCellStyle(dateStyle);
				
				cell = row.createCell(6);
				row.createCell(6).setCellValue(list.get(i).getHit());
				cell.setCellStyle(content);
				
			}
			
			response.setContentType("application/vnd.ms-excel"); 
			response.setHeader("Content-Disposition", "attachment; filename="+excelName+".xlsx");
			workbook.write(response.getOutputStream());
			
			workbook.close();
			
			
		}else if( targetName.equals("searchList") ) {
			System.out.println("서치!!");
			
			List<BoardDto> list = (List<BoardDto>)model.get("excelList");
			
			SearchDto search = (SearchDto) model.get("search");

			String searchSelected = search.getSearchSelect();
			String searchKeyword = search.getKeyword();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
			Date date = new Date();
			String curDate = sdf.format(date);
			
			String name ="게시글 검색 목록--"+curDate;
			
			String excelName = URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "%20");
			String sheetName = (name+" WorkSheet");
			
			sheet = workbook.createSheet();
			workbook.setSheetName(0, sheetName);
			
			for( int j=0; j<list.size(); j++ ) {
//				sheet.autoSizeColumn(i);//너비 자동정렬(내용 용량이 엑셀 기준보다 커서 자동정렬 사용 못함.)
				sheet.setColumnWidth(j, (sheet.getColumnWidth(j))+1024);
				if ( j == 1 ) {
					sheet.setColumnWidth(1, (sheet.getColumnWidth(1))+2048);
				}else if( j == 3 ) {
					sheet.setColumnWidth(3, (sheet.getColumnWidth(3))+3072);
				}
				
			}
			
			row = sheet.createRow(0);
			row.createCell(0).setCellValue("검색조건: SELECTED= "+searchSelected+", KEYWORD= "+searchKeyword);
			
				row = sheet.createRow(1);
				cell = row.createCell(0);
				row.createCell(0).setCellValue("글번호");
				cell.setCellStyle(header);
				
				cell = row.createCell(1);
				row.createCell(1).setCellValue("제목");
				row.setHeightInPoints(23);
				cell.setCellStyle(header);
				
				cell = row.createCell(2);
				row.createCell(2).setCellValue("작성자");
				cell.setCellStyle(header);
				
				cell = row.createCell(3);
				row.createCell(3).setCellValue("내용");
				cell.setCellStyle(header);
				
				cell = row.createCell(4);
				row.createCell(4).setCellValue("비밀번호");
				cell.setCellStyle(header);
				
				cell = row.createCell(5);
				row.createCell(5).setCellValue("작성일");
				cell.setCellStyle(header);
				
				cell = row.createCell(6);
				row.createCell(6).setCellValue("조회수");
				cell.setCellStyle(header);
				
			
			
			for( int i=0; i<list.size(); i++ ) {
				row = sheet.createRow(i+2);
				
				cell = row.createCell(0);
				row.createCell(0).setCellValue(list.get(i).getPnum());
				cell.setCellStyle(content);
				
				cell = row.createCell(1);
				row.createCell(1).setCellValue(list.get(i).getTitle());
				cell.setCellStyle(twc);
				
				cell = row.createCell(2);
				row.createCell(2).setCellValue(list.get(i).getWriter());
				cell.setCellStyle(twc);
				
				cell = row.createCell(3);
				row.createCell(3).setCellValue(list.get(i).getContent());
				cell.setCellStyle(twc);
				
				cell = row.createCell(4);
				row.createCell(4).setCellValue(list.get(i).getPw());
				cell.setCellStyle(content);
				
				cell = row.createCell(5);
				row.createCell(5).setCellValue(list.get(i).getReg_date());
				cell.setCellStyle(dateStyle);
				
				cell = row.createCell(6);
				row.createCell(6).setCellValue(list.get(i).getHit());
				cell.setCellStyle(content);
				
			}
			
			response.setContentType("application/vnd.ms-excel"); 
			response.setHeader("Content-Disposition", "attachment; filename="+excelName+".xlsx");
			workbook.write(response.getOutputStream());
			
			workbook.close();
		}
		
		
		
		
		
	}
	
	
}
