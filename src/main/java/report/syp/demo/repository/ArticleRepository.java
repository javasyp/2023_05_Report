package report.syp.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import report.syp.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	
	// 작성
	@Select("""
				INSERT INTO article
				SET regDate = NOW(),
				memberId = #{memberId},
				title = #{title},
				`body`= #{body}
			""")
	public void writeArticle(int memberId, String title, String body);
	
	// 목록 (페이징)
	@Select("""
			<script>
				SELECT A.*, M.name AS extra_writer
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				ORDER BY A.id DESC
				<if test="limitFrom >= 0">
					LIMIT #{limitFrom}, #{limitTake}
				</if>
			</script>
			""")
	public List<Article> getForPrintArticles(int limitFrom, int limitTake);
	
	// 상세보기
	@Select("""
				SELECT A.*, M.name AS extra_writer
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				WHERE A.id = #{id}
			""")
	public Article getForPrintArticle(int id);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();
	
	// 게시물 개수
	@Select("""
				SELECT COUNT(*) AS cnt
				FROM article
			""")
	public int getArticlesCount();

}
