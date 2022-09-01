/** */
$('select[data-value]').each(function(index, el){
	const $el = $(el);
	const newData = $el.attr('data-value').trim(); 
	
	if(newData.length > 0) $el.val(newData);
})

/** 공백삭제 */
function doTrim(str){
	return str.trim();
}

/** 한 글자 이상 확인 */
function isNull(str) { 
	if (str == null || str =="") 
		return false;
		
	let trimStr = str.trim(); 
	if (trimStr.length <= 0) 
		return false;
	
	return true;
}