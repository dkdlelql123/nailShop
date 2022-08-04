package com.nyj.exam.demo.service;

import com.nyj.exam.demo.repository.BoardRepository;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.ResultData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {
	
	@Autowired
	BoardRepository boardrepository;
	
	public Board getBoardById(int id) {
		return boardrepository.getBoardById(id);
	}

	public List<Board> getBoards() {
		return boardrepository.getBoards();
	}

	public List<Board> getForPrintBoards(String searchKeywordType, String searchKeyword, int page,int itemsCountInAPage) {
		int limitStart = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;
		
		System.out.println("limitTake"+limitTake);
		return boardrepository.getForPrintBoards(searchKeywordType,searchKeyword,limitStart, limitTake);
	}

	public int getBoardCount(String searchKeywordType, String searchKeyword) {
		return boardrepository.getBoardCount(searchKeywordType,searchKeyword);
	}

	public ResultData CheckForDuplicates(String value, String type) {
		Board oldBoard = boardrepository.CheckForDuplicates(value, type);
		if(oldBoard != null) {
			return ResultData.form("F-1", "중복되는 게시판이 있습니다.", "oldBoard", oldBoard);
		}
		return ResultData.form("S-1", "사용가능한 이름입니다."); 
	}

	public void doWrite(String name, String code) {
		boardrepository.doWrite(name, code);
	}


	public void doModify(int id, String name, String code) {
		boardrepository.doModify(id, name, code);	
	}
	
}
