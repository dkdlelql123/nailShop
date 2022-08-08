package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.nyj.exam.demo.vo.Member;

@Mapper
public interface MemberRepository {

	void join(@Param("loginId") String loginId, @Param("loginPw") String loginPw, @Param("salt") String salt, @Param("email") String email, @Param("name") String name,@Param("nickname") String nickname, @Param("phoneNumber")String phoneNumber);

	int getLastInsertId();

	Member getMemberByLoginId(@Param("loginId") String loginId);
	
	Member getMemberById(@Param("id") int id);
	
	Member getForPrintMemberById(@Param("id") int id);

	Member getMemberNameAndEmail(@Param("name") String name, @Param("email") String email);

	void modify(int memberId,String loginPw, String salt, String email,String nickname, String phoneNumber);

	@Select("""
			<script>
				SELECT COUNT(*)
				FROM `member`;
			</script>
			""")
	int getALLMembersCount();
	
	@Select("""
			<script>
				SELECT COUNT(*)
				FROM `member`
				WHERE 1
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordType == 'loginId'" >
								AND loginId LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'name'" >
								AND `name` LIKE CONCAT('%', #{searchKeyword}, '%')
							</when> 
							<when test="searchKeywordType == 'nickname'" >
								AND `nickname` LIKE CONCAT('%', #{searchKeyword}, '%')
							</when> 
						</choose>
					</if>
					<if test="searchAuthLevel != 1">
						AND authLevel = #{searchAuthLevel}
					</if>
			</script>
			""")
	int getMembersCount(String searchKeywordType, String searchKeyword, int searchAuthLevel );
	

	@Select("""
			<script>
				SELECT *
				FROM `member`
				WHERE 1
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordType == 'loginId'" >
								AND loginId LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
							<when test="searchKeywordType == 'name'" >
								AND `name` LIKE CONCAT('%', #{searchKeyword}, '%')
							</when> 
							<when test="searchKeywordType == 'nickname'" >
								AND `nickname` LIKE CONCAT('%', #{searchKeyword}, '%')
							</when> 
						</choose>
					</if>
					
					<if test="searchAuthLevel != 1">
						AND authLevel = #{searchAuthLevel}
					</if>
				ORDER BY id DESC
				LIMIT #{limitStart}, #{limitTake}
				;
			</script>
			""")
	List<Member> getForPrintMembers(String searchKeywordType, String searchKeyword, int searchAuthLevel , int limitStart, int limitTake);

	void delete(int memberId);
}
