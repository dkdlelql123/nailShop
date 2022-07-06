package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.nyj.exam.demo.vo.Article;

@Mapper
public interface ArticleRepository {   
	public void writeArticle(@Param("memberId") int memberId, @Param("boardId") int boardId, @Param("title") String title, @Param("body") String body);  
 
	public Article getArticle(@Param("id") int id); 
	
	public Article getForPrintArticle(@Param("id") int id);
	 
	public List<Article> getArticles(
			@Param("boardId") int boardId, 
			@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake
			);  
	
	public List<Article> getForPrintArticles(@Param("boardId") int boardId);  

	public int getArticlesCount(@Param("boardId")int boardId, @Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword);
	 
	public void deleteArticle(@Param("id") int id); 
	  
	public void modifyArticle(@Param("id") int id,@Param("boardId") int boardId, @Param("title") String title, @Param("body") String body);
 
	public int getLastInsertId();

	public int increaseHitCount(int id);
	
	public int getArticleHitCount(int id);

	public int actorCanMakeReactionPoint(int loginedMemberId, int articleId);
	
}
