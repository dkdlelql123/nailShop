package com.nyj.exam.demo.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class GenFile {

    private int id;
    private String regDate;
    private String updateDate;
    private boolean delStatus;
    private String delDate;
    private String typeCode;
    private String type2Code;
    private String relTypeCode;
    private int relId;
    private String fileExtTypeCode;
    private String fileExtType2Code;
    private int fileSize;
    private int fileNo;
    private String fileExt;
    private String fileDir;
    private String originFileName;
    
    @JsonIgnore
    public String getFilePath(String genFileDirPath) {
        return genFileDirPath + getBaseFileUri();
    }

    @JsonIgnore
    private String getBaseFileUri() {
        return "/" + relTypeCode + "/" + fileDir + "/" + getFileName();
    }

    public String getFileName() {
        return id + "." + fileExt;
    }

    public String getForPrintUrl() {
        return "/gen" + getBaseFileUri() + "?updateDate=" + updateDate;
    }

    public String getDownloadUrl() {
        return "/common/genFile/doDownload?id=" + id;
    }

    public String getMediaHtml() {
        return "<img src=\"" + getForPrintUrl() + "\">";
    }
	
	public String getForPrintType1RegDate() {
		return regDate.substring(2,10);
	}
	
	public String getForPrintType1UpdateDate() {
		return updateDate.substring(2,10);
	}
	
	public String getForPrintType2RegDate() {
		return regDate.substring(2,16);
	}
	
	public String getForPrintType2UpdateDate() {
		return updateDate.substring(2,16);
	}
	
}
