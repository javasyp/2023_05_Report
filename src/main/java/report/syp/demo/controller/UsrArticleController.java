package report.syp.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import report.syp.demo.service.ArticleService;
import report.syp.demo.service.ReplyService;
import report.syp.demo.util.Ut;
import report.syp.demo.vo.Article;
import report.syp.demo.vo.Reply;
import report.syp.demo.vo.ResultData;
import report.syp.demo.vo.Rq;

@Controller
public class UsrArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private Rq rq;
	
	// 작성
	@RequestMapping("/usr/article/write")
	public String showWrite(String title, String body) {
		
		return "usr/article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, String replaceUri) {
		
		if (Ut.empty(title)) {
			return rq.jsHistoryBack("F-1", "제목을 입력해 주세요.");
		}
		
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("F-2", "내용을 입력해 주세요.");
		}
		
		ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body);
		
		int id = (int) writeArticleRd.getData1();

		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../article/detail?id=%d", id);
		}
		
		return rq.jsReplace(Ut.f("%d번 글이 생성되었습니다.", id), replaceUri);
	}
	
	// 목록
	@RequestMapping("/usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue="1") int page) {
		
		int articlesCount = articleService.getArticlesCount();
		
		// 페이징
		
		int itemsInAPage = 10;		// 한 페이지에 나오는 글 개수
		// 글 20개 -> 2
		// 글 24개 -> 3

		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		List<Article> articles = articleService.getForPrintArticles(itemsInAPage, page);
		
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);
		
		return "usr/article/list";
	}
	
	// 상세보기
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(id);
		
//		if (article == null) {
//			return rq.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다.", id));
//		}
		
		if (article == null) {
			return rq.jsHistoryBackOnView(Ut.f("%d번 글은 존재하지 않습니다...", id));
		}
		
		// 댓글 목록
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), id);

		int repliesCount = replies.size();

		model.addAttribute("repliesCount", repliesCount);
		model.addAttribute("replies", replies);
		model.addAttribute("article", article);
		
		return "usr/article/detail";
	}
	
}