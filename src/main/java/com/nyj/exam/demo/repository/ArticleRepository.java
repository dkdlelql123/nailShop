package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.nyj.exam.demo.vo.Article;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ArticleRepository {

	void writeArticle(@Param("memberId") int memberId, @Param("boardId") int boardId, @Param("title") String title, @Param("body") String body);

	Article getArticle(@Param("id") int id);

	Article getForPrintArticle(@Param("id") int id);

	List<Article> getArticles(
			@Param("boardId") int boardId,
			@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake
			);

	@Select("""
			<script>
		SELECT COUNT(*)
		FROM `article`
		WHERE 1
			<if test='boardId !=null and boardId !="" and boardId !=0 '>
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordType == 'title'" >
						AND title LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordType == 'body'" >
						AND `body` LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND ( 
							title LIKE CONCAT('%', #{searchKeyword}, '%')
								OR 
							`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						)
					</otherwise>
				</choose>
			</if>
		</script>
	""")
	int getArticlesCount(@Param("boardId")int boardId, @Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword);

	void deleteArticle(@Param("id") int id);

	void modifyArticle(@Param("id") int id,@Param("boardId") int boardId, @Param("title") String title, @Param("body") String body);

	int getLastInsertId();

	int increaseHitCount(int id);

	int getArticleHitCount(int id);

	int increaseGoodReactionPoint(int id);

	int increaseBadReactionPoint(int id);

	int decreaseReactionPoint(int relId, String cancelReaction);

	List<Article> getBestArticles();

	List<Article> getNewArticles();

	void deleteFromMember(int memberId);

	List<Article> getArticlesByMemberId(int memberId, int limitStart, int limitTake);
}
