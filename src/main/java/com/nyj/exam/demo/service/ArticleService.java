package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ArticleRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;
	
	public ArticleService( ) {
		
	}

	public ResultData writeArticle(int memberId, int boardId, String title, String body) {
		articleRepository.writeArticle(memberId, boardId, title, body);
		int id = articleRepository.getLastInsertId(); 
		return ResultData.form("S-1", Ut.f("%d번 게시물 생성 되었습니다", id), id); 
	}

	public List<Article> getArticles(int boardId, String searchKeyType, String searchKeyword, int page, int itemsCountInAPage) { 
		int limitStart = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage; 
		
		return articleRepository.getArticles(boardId, searchKeyType, searchKeyword, limitStart, limitTake); 
	}  
	
	public Article getArticle(int id) { 		
		return articleRepository.getArticle(id); 
	}

	public Article getForPrintArticle(int LoginedMemberId ,int id) {
		Article article = articleRepository.getForPrintArticle(id);
		
		ResultData actorCanEditRd = actorCanEdit(LoginedMemberId, article); 
		
		article.setExtra__actorCanEdit(actorCanEditRd.isSuccess());
		
		return article;
	} 

	public ResultData actorCanEdit(int loginedMemberId, Article article) {
		if(article == null) {
			return ResultData.form("F-1", "게시물이 존재하지 않습니다.");
		}
		
		if(article.getMemberId() != loginedMemberId) {
			return ResultData.form("F-2", "권한이 없습니다.");
		}
		
		return ResultData.form("S-1", Ut.f("%d번 게시물 수정이 완료되었습니다", article.getId()), article); 
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public void modifyArticle(int id, int boardId, String title, String body) {
		articleRepository.modifyArticle(id,boardId,title,body);		
	}

	public int getArticlesCount(int boardId, String searchKeywordType, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordType, searchKeyword);
	}  
	
	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}

	public ResultData increaseHitCount(int id) { 
		int affectedRowCount =  articleRepository.increaseHitCount(id);
		if( affectedRowCount == 0 ) {
			return ResultData.form("F-1", "조회수 증가 실패");			
		}
		return ResultData.form("S-1", "조회수 +1");
	}

	public ResultData increaseGoodReactionPoint(int relId) {
		int affectedCount = articleRepository.increaseGoodReactionPoint(relId);
		if( affectedCount == 0 ) {
			return ResultData.form("F-1", "해당 게시물이 존재하지 않습니다.", "affectedCount", affectedCount);			
		}
		return ResultData.form("S-1", "좋아요 + 1", "affectedCount", affectedCount);
	} 
	
	public ResultData increaseBadReactionPoint(int relId) {
		int affectedCount = articleRepository.increaseBadReactionPoint(relId);
		if( affectedCount == 0 ) {
			return ResultData.form("F-1", "해당 게시물이 존재하지 않습니다.", "affectedCount", affectedCount);			
		}
		return ResultData.form("S-1", "싫어요 + 1", "affectedCount", affectedCount);
	}

	public ResultData decreaseReactionPoint(int relId, String cancleReaction) {
		int affectedCount = 0;
		
		switch(cancleReaction) {
		case "good" : 
			affectedCount = articleRepository.decreaseReactionPoint(relId, "goodReactionPoint");
			break;
		case "bad" :
			affectedCount = articleRepository.decreaseReactionPoint(relId, "badReactionPoint");
			break;
		}
		
		if( affectedCount == 0 ) {
			return ResultData.form("F-1", "해당 게시물이 존재하지 않습니다.", "affectedCount", affectedCount);			
		}
		return ResultData.form("S-1", "리액션 헤제", "affectedCount", affectedCount);
		
	}

	public List<Article> getBestArticles() {
		return articleRepository.getBestArticles();
	}

	public List<Article> getNewArticles() {
		return articleRepository.getNewArticles();
	}

	public void deleteFromMember(int memberId) {
		articleRepository.deleteFromMember(memberId);
	}
	
}
