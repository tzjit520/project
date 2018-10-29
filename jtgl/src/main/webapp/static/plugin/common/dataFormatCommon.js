    //agc运行方式
    function agcStatus(val){
        if(val == 1){
            return 'SCHB';
        }
        if(val == 2){
            return 'SCHE';
        }
        return 'SCHR';
    }   
    //agc开关状态
    function agckgzt(val){
        if(val == 0){
            return '关';
        }
        if(val == 2){
            return '关';
        }
        return '开';
    }
    //保留4位小数
    function dataFormat(val){
    	if(null == val){
    		return '';
    	} else {
    		val = val + '';
    		var re = /([0-9]+\.[0-9]{4})[0-9]*/;
    		return val.replace(re,"$1");
    	}
    }
    
    //保留2位小数
    function dataFormat2(val){
    	if(null == val){
    		return '';
    	} else {
    		val = val + '';
    		var re = /([0-9]+\.[0-9]{2})[0-9]*/;
    		return val.replace(re,"$1");
    	}
    }
    
    //转换为百分比
    function dataFormat3(val){
    	if(null == val){
    		return '';
    	} else {
    		val = val*100 + '';
    		var re = /([0-9]+\.[0-9]{2})[0-9]*/;
    		return val.replace(re,"$1") + '%';
    	}
    }
    //是和否的转化
    function changeToYesOrNo(val){
    	if(val == null){
    		return '';
    	}
    	if(val == 0){
    		return '否';
    	}
    	if(val == 1){
    		return '是';
    	}
    }