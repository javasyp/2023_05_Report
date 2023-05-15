package com.KoreaIT.syp.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.syp.demo.service.MemberService;
import com.KoreaIT.syp.demo.util.Ut;
import com.KoreaIT.syp.demo.vo.Member;
import com.KoreaIT.syp.demo.vo.ResultData;
import com.KoreaIT.syp.demo.vo.Rq;

@Controller
public class UsrMemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;
	
	// 액션 메서드
	// 로그인
	@RequestMapping("/usr/member/login")
	public String showLogin(HttpSession session) {
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw,
						@RequestParam(defaultValue = "/") String afterLoginUri) {

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-5", Ut.f("현재 로그인 상태입니다."));
		}
		
		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해 주세요.");
		}
		
		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해 주세요.");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Ut.jsHistoryBack("F-3", Ut.f("%s은(는) 존재하지 않는 아이디입니다.", loginId));
		}
		
		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다.");
		}
		
		rq.login(member);
		
		return Ut.jsReplace(Ut.f("%s 님 환영합니다.", member.getName()), afterLoginUri);
	}
	
	// 로그아웃
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {

		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("F-1", Ut.f("현재 로그아웃 상태입니다."));
		}
		
		rq.logout();
		
		return Ut.jsReplace(Ut.f("로그아웃 되었습니다."), "/");
	}
	
	// 회원가입
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname,
			String cellphoneNum, String email) {

		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("F-1", "아이디를 입력해 주세요.");
		}
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("F-2", "비밀번호를 입력해 주세요.");
		}
		if (Ut.empty(name)) {
			return rq.jsHistoryBack("F-3", "이름을 입력해 주세요.");
		}
		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("F-4", "닉네임을 입력해 주세요.");
		}
		if (Ut.empty(cellphoneNum)) {
			return rq.jsHistoryBack("F-5", "전화번호를 입력해 주세요.");
		}
		if (Ut.empty(email)) {
			return rq.jsHistoryBack("F-6", "이메일을 입력해 주세요.");
		}

		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name,
				nickname, cellphoneNum, email);

		// 중복일 때
		if (joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		// joinRd에 저장된 data1(id) 값
		Member member = memberService.getMemberById(joinRd.getData1());

		return Ut.jsReplace(Ut.f("회원가입이 완료되었습니다"), "../member/login");
	}
	
	// 아이디 중복 체크
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(String loginId) {

		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해 주세요.");
		}

		Member existsMember = memberService.getMemberByLoginId(loginId);

		if (existsMember != null) {
			return ResultData.from("F-2", "해당 아이디는 이미 사용 중입니다.", "loginId", loginId);
		}

		return ResultData.from("S-1", "사용 가능한 아이디입니다.", "loginId", loginId);
	}
	
	// 이메일 중복 체크
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(String email) {

		if (Ut.empty(email)) {
			return ResultData.from("F-1", "이메일을 입력해 주세요.");
		}

		Member existsMember = memberService.getMemberByEmail(email);

		if (existsMember != null) {
			return ResultData.from("F-2", "해당 이메일은 이미 사용 중입니다.", "email", email);
		}

		return ResultData.from("S-1", "사용 가능한 이메일입니다.", "email", email);
	}
}