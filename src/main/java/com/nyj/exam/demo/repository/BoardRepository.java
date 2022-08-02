package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.nyj.exam.demo.vo.Board;

@Mapper
public interface BoardRepository {

	@Select("""
			SELECT *
			FROM board  
				""")
	List<Board> getBoards();

	@Select("""
			<script>
			SELECT b.*, COUNT(a.boardId) as extra__articleCount
			FROM `board` b
			LEFT JOIN article a
			ON b.id = a.boardId
			WHERE 1
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordType == 'name'">
						AND b.`name` LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<when test="searchKeywordType == 'code'">
						AND b.`code` LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							b.`name` LIKE CONCAT('%', #{searchKeyword}, '%')
							OR
							b.`code` LIKE CONCAT('%', #{searchKeyword}, '%')
						)
					</otherwise>
				</choose>
			</if>
			GROUP BY a.boardId
			LIMIT #{limitStart}, #{limitTake}
			</script>
				""")
	List<Board> getForPrintBoards(String searchKeywordType, String searchKeyword, int limitStart, int limitTake);
	
	@Select("""
			SELECT *
			FROM board AS B
			WHERE B.id = #{id}
			AND B.delStatus = 0
				""")
	Board getBoardById(@Param("id") int id);
	
	@Select("""
			<script>
			SELECT COUNT(*)
			FROM board
			WHERE 1
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordType == 'name'">
						AND `name` LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<when test="searchKeywordType == 'code'">
						AND `code` LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							`name` LIKE CONCAT('%', #{searchKeyword}, '%')
							OR
							`code` LIKE CONCAT('%', #{searchKeyword}, '%')
						)
					</otherwise>
				</choose>
			</if> 
			</script>
	""")
	int getBoardCount(String searchKeywordType, String searchKeyword);

}
