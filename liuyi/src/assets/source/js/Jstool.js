// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) { //author: meizz 
	var o = {
		"M+": this.getMonth() + 1, //月份 
		"d+": this.getDate(), //日 
		"h+": this.getHours(), //小时 
		"m+": this.getMinutes(), //分 
		"s+": this.getSeconds(), //秒 
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		"S": this.getMilliseconds() //毫秒 
	};
	if(/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for(var k in o)
		if(new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}


//返回 合适 时间
			var customMsgChangeTime = function(params) {
				var d = new Date(); //时间值
				var now_year = d.getFullYear();
				var now_month = d.getMonth() + 1;
				var now_day = d.getDate();
				if(params) {
					d.setTime(params);
					var old_year = d.Format("yyyy");
					var old_month = d.Format("MM");
					var old_day = d.Format("dd");
					if(old_year == now_year) {
						var zero_month='0'+now_month;//加 零
						if((old_month == now_month||old_month==zero_month )&& old_day == now_day) {
							return d.Format("hh:mm");
						} else {
							return d.Format("MM月dd日 hh:mm");
						}
					} else {
						return d.Format("yyyy年MM月dd日 hh:mm");
					}
				}else{
					return "";
				}
			};