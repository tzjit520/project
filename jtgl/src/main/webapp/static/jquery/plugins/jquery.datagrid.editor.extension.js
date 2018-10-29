var comboxData=[];
function comboxFormatter(value){
	for(var i=0; i<comboxData.length; i++){
		if (comboxData[i].code == value) return comboxData[i].name;
	}
	return value;
}

function statusFormatter(value){
	if(value==1){
		return "<div style='font-weight:700;color:yellow;background-color:green;margin:0px;padding:0px;'>有效</div>";
	}else{
		return "<div style='font-weight:700;color:red;background-color:#CCCCCC;text-decoration:line-through'>无效</div>";
	}
}

/**
 * 格式化日期时间
 * @param val
 * @param row
 * @return yyyy-mm-dd
 */
function formateDateTimeColumn(val){
	if( val != null&&val!=""){
		var y = val.year + 1900;
	    var m = val.month + 1;
	    var d = val.date;
	    var hour = val.hours;
	    var min = val.minutes;
	    var sec = val.seconds;
	    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
	}
}

formatterDate = function(date) {
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	return date.getFullYear() + '-' + month + '-' + day;
};

/**
 * 格式化日期时间
 * @param val
 * @param row
 * @return yyyy-mm-dd
 */
function formateDateColumn(val){
	if( val != null){
		var y = val.year + 1900;
	    var m = val.month + 1;
	    var d = val.date;
	    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
}

$.extend($.fn.datagrid.defaults.editors, {
    my97: {
        init: function(container, options){
            var input = $('<input class="Wdate" type="text" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'});"  />').appendTo(container);
            return input;
        },
        getValue: function(target){
            return $(target).val();
        },
        setValue: function(target, value){
            $(target).val(value);
        },
        resize: function(target, width){
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            }
            else {
                input.width(width);
            }
        }
    }
});

/*$.extend($.fn.datagrid.defaults.editors, {
  datebox : {
    init : function(container, options) {
      var input = $('<input type="text">').appendTo(container);
      input.datebox(options);
      return input;
    },
    destroy : function(target) {
      $(target).datebox('destroy');
    },
    getValue : function(target) {
      return $(target).datebox('getValue');//获得旧值
    },
    setValue : function(target, value) {
      console.info(formateDateColumn(value));
      $(target).datebox('setValue', formateDateColumn(value));//设置新值的日期格式
    },
    resize : function(target, width) {
      $(target).datebox('resize', width);
    }
  }
});*/