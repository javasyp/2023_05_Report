package report.syp.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import report.syp.demo.service.ReplyService;
import report.syp.demo.util.Ut;
import report.syp.demo.vo.Article;
import report.syp.demo.vo.Reply;
import report.syp.demo.vo.ResultData;
import report.syp.demo.vo.Rq;

@Controller
public class UsrReplyController {
	
	@Autowired
	private Rq rq;
	@Autowired
	private ReplyService replyService;
	
	// 댓글 작성
	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(int relId, String body, String replaceUri) {
		
		if (Ut.empty(relId)) {
			return rq.jsHistoryBack("F-1", "글 번호를 입력해 주세요.");
		}
		
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("F-2", "내용을 입력해 주세요.");
		}

		ResultData<Integer> writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), relId, body);

		int id = (int) writeReplyRd.getData1();

		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../article/detail?id=%d", relId);
		}

		return rq.jsReplace(writeReplyRd.getMsg(), replaceUri);
	}
	
}