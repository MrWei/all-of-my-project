function changeCompany (obj) {
	var companyid = $(obj).val();
	$.post( "{:U('changeCompany')}" , { companyid:companyid } , function(data){

	},'json' )
}