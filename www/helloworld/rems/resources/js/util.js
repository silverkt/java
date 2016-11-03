	function ifZero(num){return ((num <= 9) ? ("0" + num) : num);}
	function getTime(h,m){
		var x = new Array();
		for(var i = 0;i < h;i++){
			for(var j = 0;j < m;j++){
				x.push(ifZero(i) + ":" + ifZero(j * 10));
			}
		}
		return x;
	}
