package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Item {
	/** pk */
	int id;
	/** 등록일 */
	String regDate;
	/** 수정일 */
	String updateDate;  
	/** 작성자ID */
	int memberId;
	/** 작성자ID */
	String memberName;
	/** 카테고리ID */
	int categoryId;
	/** 카테고리이름 */
	String extra__categoryName;
	/** 상풍명 */
	String name;
	/** 카테고리 링크 */
	String link;
	/** 카테고리 설명 */
	String desc;
	
	/** 톤 타입 */
	String toneType;
	/** 계절 */
	String seasonType;
	/** 가격 */
	int price;
	/** 세일가격 */
	int sale;
	
	/** 사용여부 */
	int useYn;  
	
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

	public String getShopItemImgUri() {
        return "/common/genFile/file/item/" + id + "/extra/shopItemImg/1";
    }
    
    public String getShopItemFallbackImgUri() {
        return "https://via.placeholder.com/400?text=:)";
    }

    public String getShopItemFallbackImgOnErrorHtmlAttr() {
        return "this.src = '" + getShopItemFallbackImgUri() + "';";
    }
    
    public String getRemoveShopItemImgIfNotExistsOnErrorHtmlAttr() {
        return "$(this).remove();";
    }
	 
}
