package report.syp.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import report.syp.demo.repository.ReplyRepository;
import report.syp.demo.vo.Reply;
import report.syp.demo.vo.ResultData;

@Service
public class ReplyService {

	@Autowired
	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}
	
	// 댓글 작성
	public ResultData<Integer> writeReply(int actorId, int relId, String body) {
		
		replyRepository.writeReply(actorId, relId, body);

		int id = replyRepository.getLastInsertId();

		return ResultData.from("S-1", "댓글을 작성했습니다.", "id", id);
	}
	
	// 댓글 목록
	public List<Reply> getForPrintReplies(int actorId, int relId) {
		List<Reply> replies = replyRepository.getForPrintReplies(actorId, relId);
		
		return replies;
	}
}
