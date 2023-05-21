package report.syp.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private int memberId;
	private String title;
	private String body;
	
	// member 테이블의 nickname
	private String extra_writer;
}
