package report.syp.demo.service;

import org.springframework.stereotype.Service;

import report.syp.demo.repository.MemberRepository;
import report.syp.demo.util.Ut;
import report.syp.demo.vo.Member;
import report.syp.demo.vo.ResultData;

@Service
public class MemberService {
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	// 서비스 메서드
	public ResultData<Integer> join(String email, String loginPw, String name) {

		// 아이디 중복 체크
		Member existsMember = getMemberByEmail(email);
		
		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용 중인 이메일(%s)입니다.", email));
		}

		// select문 실행
		memberRepository.join(email, loginPw, name);

		// 몇 번째 회원인지
		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
	
	// 이메일 중복 체크
	public Member getMemberByEmail(String email) {
		return memberRepository.getMemberByEmail(email);
	}
	
	// 프로필 수정
	public ResultData modify(int id, String loginPw, String name) {
		memberRepository.modify(id, loginPw, name);
		
		return ResultData.from("S-1", "프로필 수정이 완료되었습니다.");
	}

}
