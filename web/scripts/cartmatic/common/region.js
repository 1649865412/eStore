function countrySelector(id,value){
	__fillToSelector(1,__ctxPath+"/system/region/byType.html?regionType=1",id,value);
}

function stateSelector(pid,id,value){
	__regionSelector(2,pid,id,value);
}
function citySelector(pid,id,value){
	__regionSelector(3,pid,id,value);
}
function __regionSelector(regionType,pid,id,value){
	if(pid){
		__fillToSelector(regionType,__ctxPath+"/system/region/byParentIdAndType.html?regionType="+regionType+"&pid="+pid,id,value);
	}else{
		$("#"+id).empty();
		$("#"+id).append('<option value="">'+(regionType==2?"--省份/直辖市--":"--市--")+'</option>');
	}
}
function __fillToSelector(regionType,url,id,value){
	var selectName=regionType==1?"--国家--":(regionType==2?"--省份/直辖市--":"--市--");
	$.ajax({
   type: "GET",
   dataType:"json",
   async: false,
   url: url,
   success:function (result){
   		if (result.status == 1) {
			var regionList = result.data;
			$("#"+id).empty();
			$("#"+id).append('<option value="">'+selectName+'</option>');
			for(var i=0;i<regionList.length;i++){
				var region=regionList[i];
				var selectStr="";
				if(region.id==value||region.name==value){
					selectStr=' selected="selected"';
				}
				$("#"+id).append('<option value="'+region.id+'"'+selectStr+'>'+region.name+'</option>');
			}
		}else{
			alert(result.msg);
		}
		}
	});
	
}


