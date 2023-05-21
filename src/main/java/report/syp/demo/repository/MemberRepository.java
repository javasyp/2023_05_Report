package report.syp.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import report.syp.demo.vo.Member;

@Mapper
public interface MemberRepository {
	
	@Insert("""
				INSERT INTO `member`
				SET regDate = NOW(),
				updateDate = NOW(),
				email = #{email},
				loginPw = #{loginPw},
				`name` = #{name}
			""")
	void join(String email, String loginPw, String name);
	
	@Select("""
				SELECT *
				FROM `member`
				WHERE id = #{id}
			""")
	Member getMemberById(int id);
	
	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();
	
	// 이메일 중복 체크
	@Select("""
				SELECT *
				FROM `member`
				WHERE email = #{email}
			""")
	Member getMemberByEmail(String email);
	
	// 회원 정보 수정
	@Update("""
			<script>
				UPDATE `member`
				<set>
					<if test="loginPw != null">
						loginPw = #{loginPw},
					</if>
					<if test="name != null">
						name = #{name},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{id}
			</script>
			""")
	void modify(int id, String loginPw, String name);
	
}
