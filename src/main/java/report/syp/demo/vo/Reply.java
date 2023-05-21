package report.syp.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private int memberId;
	private int relId;
	private String body;
	
	// member 테이블의 nickname
	private String extra_writer;
	
	public String getForPrintRegDateType1() {
		return regDate.substring(2, 16).replace(" ", "<br>");
	}
}