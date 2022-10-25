package com.nyj.exam.demo.service;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.nyj.exam.demo.repository.GenFileRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.GenFile;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class GenFileService {
	
    @Value("${custom.genFileDirPath}")
    private String genFileDirPath;
    
	@Autowired
	GenFileRepository genFileRepository;
    
	
	public ResultData save(MultipartFile multipartFile, int relId) { 
		String fileInputName = multipartFile.getName();
		String[] fileInputNameBits = fileInputName.split("__");
		
		// fileInputNameBits[0] ~ fileInputNameBits[5]까지 존재 
	    String relTypeCode = fileInputNameBits[1];
	    String typeCode = fileInputNameBits[3];
	    String type2Code = fileInputNameBits[4];
	    int fileNo = Integer.parseInt(fileInputNameBits[5]);
		
	    return save(multipartFile, relTypeCode, relId, typeCode, type2Code, fileNo);
	}

	private ResultData save(MultipartFile multipartFile, String relTypeCode, int relId, String typeCode, String type2Code, int fileNo) {
	
		String fileInputName = multipartFile.getName();
		
		int fileSize = (int) multipartFile.getSize();
		
		if(fileSize <= 0) {
			return ResultData.form("F-0", "파일이 업로드 되지 않았습니다.");
		}
		
	    String originFileName = multipartFile.getOriginalFilename();
        String fileExtTypeCode = Ut.getFileExtTypeCodeFromFileName(originFileName);
        String fileExtType2Code = Ut.getFileExtType2CodeFromFileName(originFileName);
        String fileExt = Ut.getFileExtFromFileName(originFileName).toLowerCase();

        if (fileExt.equals("jpeg")) {
            fileExt = "jpg";
        } else if (fileExt.equals("htm")) {
            fileExt = "html";
        }
        
        String fileDir = Ut.getNowYearMonthDateStr();

        if (relId > 0) {
            GenFile oldGenFile = getGenFile(relTypeCode, relId, typeCode, type2Code, fileNo);

            if (oldGenFile != null) {
//                deleteGenFile(oldGenFile);
            }
        }
        
        ResultData saveMetaRd = saveMeta(relTypeCode, relId, typeCode, type2Code, fileNo, originFileName,
                fileExtTypeCode, fileExtType2Code, fileExt, fileSize, fileDir);
        int newGenFileId = (int) saveMetaRd.getData1();
        
     // 새 파일이 저장될 폴더(io파일) 객체 생성
        String targetDirPath = genFileDirPath + "/" + relTypeCode + "/" + fileDir;
        java.io.File targetDir = new java.io.File(targetDirPath);

        // 새 파일이 저장될 폴더가 존재하지 않는다면 생성
        if (targetDir.exists() == false) {
            targetDir.mkdirs();
        }

        String targetFileName = newGenFileId + "." + fileExt;
        String targetFilePath = targetDirPath + "/" + targetFileName;

        // 파일 생성(업로드된 파일을 지정된 경로롤 옮김)
        try {
            multipartFile.transferTo(new File(targetFilePath));
        } catch (IllegalStateException | IOException e) {
            return ResultData.form("F-3", "파일저장에 실패하였습니다.");
        }

        return ResultData.form("S-1", "파일이 생성되었습니다.");
//        return new ResultData("S-1", "파일이 생성되었습니다.", "id", newGenFileId, "fileRealPath", targetFilePath, "fileName",
//                targetFileName, "fileInputName", fileInputName);
        
    }

	private GenFile getGenFile(String relTypeCode, int relId, String typeCode, String type2Code, int fileNo) {
        return genFileRepository.getGenFile(relTypeCode, relId, typeCode, type2Code, fileNo);
    }
	
	private ResultData saveMeta(String relTypeCode, int relId, String typeCode, String type2Code, int fileNo,
			String originFileName, String fileExtTypeCode, String fileExtType2Code, String fileExt, int fileSize,
			String fileDir) { 
		Map<String, Object> param = Ut.mapOf("relTypeCode", relTypeCode, "relId", relId, "typeCode", typeCode,
                "type2Code", type2Code, "fileNo", fileNo, "originFileName", originFileName, "fileExtTypeCode",
                fileExtTypeCode, "fileExtType2Code", fileExtType2Code, "fileExt", fileExt, "fileSize", fileSize,
                "fileDir", fileDir);
		genFileRepository.saveMeta(param);

        int id = Ut.getAsInt(param.get("id"), 0);
        return ResultData.form("S-1", "성공하였습니다.", "id", id);
	}

}
