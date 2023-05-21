package report.syp.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import report.syp.demo.repository.ArticleRepository;
import report.syp.demo.util.Ut;
import report.syp.demo.vo.Article;
import report.syp.demo.vo.ResultData;
import report.syp.demo.vo.Rq;

@Service
public class ArticleService {
	
	@Autowired
	private ArticleRepository articleRepository;
	@Autowired
	private Rq rq;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}
	
	// 서비스 메서드
	// 작성
	public ResultData<Integer> writeArticle(int memberId, String title, String body) {
		// 서비스에서 ResultData로 처리
		articleRepository.writeArticle(memberId, title, body);
		
		int id = articleRepository.getLastInsertId();
		
		return ResultData.from("S-1", Ut.f("%d번 글이 생성되었습니다.", id), "id", id);
	}
	
	// 목록 (출력용)
	public List<Article> getForPrintArticles(int itemsInAPage, int page) {
		
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		
		return articleRepository.getForPrintArticles(limitFrom, limitTake);
	}
	
	// 상세보기
	public Article getForPrintArticle(int id) {
		return articleRepository.getForPrintArticle(id);
	}
	
	// 게시물 개수
	public int getArticlesCount() {
		return articleRepository.getArticlesCount();
	}
}
