package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.nyj.exam.demo.vo.Board;

@Mapper
public interface BoardRepository {

	@Select("""
			SELECT b.*,
			COUNT(a.boardId) as extra__articleCount
			FROM board  b
			LEFT JOIN article a
			ON b.id = a.boardId 
			GROUP BY b.id
			ORDER BY b.id DESC
				""")
	List<Board> getBoards();

	@Select("""
			<script>
			SELECT b.*, 
			COUNT(a.boardId) as extra__articleCount
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
			GROUP BY b.id
			ORDER BY b.id DESC
			LIMIT #{limitStart}, #{limitTake}
			</script>
				""")
	List<Board> getForPrintBoards(String searchKeywordType, String searchKeyword, int limitStart, int limitTake);
	
	@Select("""
			SELECT  b.*, 
			COUNT(a.boardId) as extra__articleCount
			FROM board AS b
			LEFT JOIN article a
			ON b.id = a.boardId
			WHERE b.id = #{id}
			AND b.delStatus = 0
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

	@Select("""
			<script>
			SELECT *
			FROM board
			WHERE 1
			<if test=" type=='name' ">
				AND name= #{value}
			</if>	
			<if test=" type=='code' ">
				AND code= #{value}
			</if>	
			</script>	
	""")
	Board CheckForDuplicates(String value, String type);
	
	@Insert("""			
			INSERT INTO board
			SET regDate = NOW(),
			updateDate = NOW(),
			`code` = #{code},
			`name` = #{name}
			""")
	void doWrite(String name, String code);

}
