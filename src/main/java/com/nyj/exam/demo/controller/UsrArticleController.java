package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.ArticleService;
import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.service.ReactionPointService;
import com.nyj.exam.demo.service.ReplyService;
import com.nyj.exam.demo.service.VisitService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.Reply;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Rq;


@Controller
public class UsrArticleController {

	@Autowired
	ArticleService articleService; 
	@Autowired
	BoardService boardService;
	@Autowired
	ReactionPointService reactionPointService;
	@Autowired
	ReplyService replyService;
	@Autowired
	VisitService visitService;
	
	private Rq rq;
	
	public UsrArticleController(Rq rq) {
		this.rq = rq;
	}
	
	@RequestMapping("/usr/article/write")
	public String showWrite(Model model) {
		List<Board> boards = boardService.getBoards();
		 
		model.addAttribute("boards", boards);
		
		return "/usr/article/write";
	} 
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body) {
		if (Ut.empty(title)) {
			return Ut.jsHistoryBack("제목을 입력해주세요");
		}

		if (Ut.empty(body)) {
			return Ut.jsHistoryBack("내용을 입력해주세요");
		}

		ResultData writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);
		int id = (int) writeArticleRd.getData1();

		return Ut.jsReplace("작성을 완료했습니다", "/usr/article/detail?id="+id); 
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model, 
			@RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "10") int itemsCountInAPage, 
			@RequestParam(defaultValue = "title,body") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword ) {		
		
		Board board = boardService.getBoardById(boardId);
		
		if(board==null) {
			Ut.jsHistoryBack("해당 게시판은 존재하지 않습니다.");
		}
		model.addAttribute("reactionPointStatus", board.getReactionPointStatus());
		model.addAttribute("replyStatus", board.getReplyStatus());
		 
		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordType, searchKeyword);
		
		int pagesCount = (int) Math.ceil((double)articlesCount / itemsCountInAPage) ; 
		
		List<Article> articles = articleService.getArticles(boardId, searchKeywordType, searchKeyword, page, itemsCountInAPage);
		
		model.addAttribute("board", board);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		
		return "usr/article/list";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		String relTypeCode = "article";
		
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		model.addAttribute("article", article);  
		
		ResultData actorCanMakeReactionPointRd = reactionPointService.actorCanMakeReactionPoint(rq.getLoginedMemberId(), relTypeCode, id);
		model.addAttribute("actorCanMakeReactionPoint", actorCanMakeReactionPointRd.isSuccess());
		
		if(actorCanMakeReactionPointRd.getResultCode().equals("F-2")) {
			int subReactionPointByMember = (int)actorCanMakeReactionPointRd.getData1();
			if( subReactionPointByMember > 0 ) {
				model.addAttribute("actorCanMakeCancleGoodReactionPoint", true);				
			} else {				
				model.addAttribute("actorCanMakeCancleBadReactionPoint", true);				
			}
		}
		
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), id, relTypeCode);
		int replyCount = replies.size();
		for(Reply reply : replies) {
			ResultData reactionRd = reactionPointService.actorCanMakeReactionPoint(rq.getLoginedMemberId(), "reply", reply.getId());
			
			if(reactionRd.isSuccess()) reply.setExtra__reactionStatus("");
			if(reactionRd.getResultCode().equals("F-2")) {
				int sumReactionPointByMember = (int)reactionRd.getData1();
				if( sumReactionPointByMember > 0 ) { 
					reply.setExtra__reactionStatus("good");
				} else {		
					reply.setExtra__reactionStatus("bad");
				}
			}
		}
		
		model.addAttribute("replies", replies);
		model.addAttribute("replyCount", replyCount);
		
		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/increaseHitCount")
	@ResponseBody
	public ResultData doIncreaseHitCount(int id) {
		ResultData increaseHitCountRd = articleService.increaseHitCount(id);
		
		if(increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData visitRd = visitService.increaseHitCount(id);
		
		int hitCount = articleService.getArticleHitCount(id); 
		System.out.println("hitCounthitCounthitCounthitCount");
		System.out.println(hitCount);
		ResultData rd = ResultData.newData(increaseHitCountRd, "조회 후 조회수", hitCount); 
	    rd.setData2(visitRd.getMsg(), visitRd);
		
		return rd;
	}

	@RequestMapping("/usr/article/getArticle")
	@ResponseBody
	public ResultData getArticleAction(int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return ResultData.form("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
		}

		return ResultData.form("S-1", Ut.f("%d번 게시물입니다.", id), article); 
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		if (article == null) {
			return Ut.jsHistoryBack("해당 게시물이 없습니다.");
		}
		
		if(article.getMemberId() != rq.getLoginedMemberId()) {
			return Ut.jsHistoryBack("권한이 없습니다.");  
		}
		articleService.deleteArticle(id);

		return Ut.jsReplace("게시물이 삭제되었습니다..", "/usr/article/list"); 
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(int id, Model model) {
		List<Board> boards = boardService.getBoards();
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id); 
		ResultData actorCanEditRd = articleService.actorCanEdit(rq.getLoginedMemberId(), article);
		
		if(actorCanEditRd.isFail()==true) {
			return "/usr/article/detail?id="+id;
		}
		 
		model.addAttribute("boards", boards);
		model.addAttribute("article", article);
		
		return "/usr/article/modify";
	}

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id,int boardId, String title, String body) { 
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack("존재하지 않는 게시물입니다.");
		}

		articleService.modifyArticle(id, boardId, title, body); 
		return Ut.jsReplace("수정이 완료되었습니다", "/usr/article/detail?id="+id);
	}

}
