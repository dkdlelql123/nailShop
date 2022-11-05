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

/** 
이메일 유효성 검사
@param input(type=email)
^문자열 시작 - ? 존재여부(_) - @ 필수 - .필수 - .뒤에 문자 2~3글자 - $문자열 종료
*/  
function validEmailCheck(obj){
    let pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    return (obj.value.match(pattern)!=null)
}