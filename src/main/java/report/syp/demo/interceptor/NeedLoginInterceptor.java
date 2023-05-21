package report.syp.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import report.syp.demo.vo.Rq;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		
		// 로그아웃 상태일 때
		if (!rq.isLogined()) {
			rq.printReplace("로그인 후 이용해 주세요.", "../member/login");
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}