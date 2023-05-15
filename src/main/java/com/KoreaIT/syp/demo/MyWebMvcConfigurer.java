package com.KoreaIT.syp.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.KoreaIT.syp.demo.interceptor.BeforeActionInterceptor;
import com.KoreaIT.syp.demo.interceptor.NeedLoginInterceptor;
import com.KoreaIT.syp.demo.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// BeforeActionInterceptor 불러오기 (연결)
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	
	// NeedLoginInterceptor 불러오기 (로그인 상태에서 가능한 기능)
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	
	// NeedLogoutInterceptor 불러오기 (로그아웃 상태에서 가능한 기능)
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;
	
	// /resource/common.css
	// 인터셉트 적용
	public void addInterceptors(InterceptorRegistry registry) {
		InterceptorRegistration ir;

		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.excludePathPatterns("/resource/**");
		ir.excludePathPatterns("/error");
		
		// 로그인 필요
		//ir = registry.addInterceptor(needLoginInterceptor);
		
		// 로그아웃 필요
		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/usr/member/login");
		ir.addPathPatterns("/usr/member/doLogin");
		ir.addPathPatterns("/usr/member/getLoginIdDup");
		ir.addPathPatterns("/usr/member/getEmailDup");
		ir.addPathPatterns("/usr/member/join");
		ir.addPathPatterns("/usr/member/doJoin");
	}
}
