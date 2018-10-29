(function (window, undefined) {

	function DGHelper($dg, $dgTabs, tabbedColumns, config) {
		var that = this,
		editIndex;

		config = $.extend({}, config);
		
		if (typeof $dg == "string") $dg = $($dg);
		if (typeof $dgTabs == "string") $dgTabs = $($dgTabs);

		this.enableTabs = function () {
			$.each($dgTabs.tabs("tabs"), function(index){
				$dgTabs.tabs("enableTab", index);
			});
		};
		this.disableTabs = function () {
			$.each($dgTabs.tabs("tabs"), function(index){
				$dgTabs.tabs("disableTab", index);
			});
		};
		this.getSelectedRowIndex = function () {
			var row = $dg.datagrid("getSelected");
			return row ? $dg.datagrid("getRowIndex", row) : -1;
		};
		this.endEditing = function () {
			if (editIndex == undefined) {
				return true;
			};
			if ($dg.datagrid("validateRow", editIndex)) {
				if (config.beforeEndEditing) config.beforeEndEditing.call(that, editIndex);
				$dg.datagrid("endEdit", editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			};
		};
		this.append = function (row) {
			if (that.endEditing()) {
				if(row){
					$dg.datagrid("appendRow", row);
				} else {
					$dg.datagrid("appendRow", {});
				}
				var index = $dg.datagrid("getRows").length - 1;
				$dg.datagrid("selectRow", index).datagrid("beginEdit", index);
				editIndex = index;
				
				if (config.afterBeginEdit) config.afterBeginEdit.call(this,editIndex,row);
			};
		};
		this.remove = function () {
			var rowIndex;
			if (editIndex != undefined) {
				$dg.datagrid("cancelEdit", editIndex);
				rowIndex = editIndex;
				editIndex = undefined;
			} else {
				rowIndex = that.getSelectedRowIndex();
			};

			if (rowIndex != undefined && rowIndex > -1) {
				$dg.datagrid("deleteRow", rowIndex);
			};
		};
		this.edit = function (index) {
			if (index == undefined) index = that.getSelectedRowIndex();
			if (editIndex != index) {
				if (that.endEditing()) {
					$dg.datagrid("selectRow", index).datagrid("beginEdit", index);
					editIndex = index;
				} else {
					$dg.datagrid("selectRow", editIndex);
				};
			};
			
			var row = $dg.datagrid("getSelected");
			if (config.afterBeginEdit) config.afterBeginEdit.call(this,editIndex,row);
		};
		this.accept = function () {
			if (that.endEditing()) {
				var changedRows = $dg.datagrid("getChanges");
				$dg.datagrid("acceptChanges");
			};
		};
		this.reject = function () {
			$dg.datagrid("rejectChanges");
			editIndex = undefined;
		};
		this.getChanges = function () {
			var changedRows = $dg.datagrid("getChanges");
			return changedRows;
		};
		this.onSelect = function () {
			if (editIndex != undefined) {
				that.endEditing();
			};
		};
		this.onDblClickRow = function (index) {
			that.edit();
		};
		this.getEditIndex = function () {
			return editIndex;
		};
		
		this.getRowLength = function () {
			var data = $dg.datagrid("getData");
			
			if( data.length != undefined){
				return rows.length;
			}
			
			if( data.rows.length != undefined){
				return data.rows.length;
			}
			
			return 0;
		};

		if ($dgTabs && tabbedColumns) {
			$(function(){
				$dgTabs.tabs({
					onSelect : function (title, index) {
						index += 1;
						if (index in tabbedColumns) {
							var fixedFields = tabbedColumns.fixed.split("|");
							var fields = tabbedColumns[index].split("|");
							$.each($dg.datagrid("getColumnFields"), function (index, field) {
								if ($.inArray(field, fixedFields) == -1 ) {
									var show = $.inArray(field, fields) > -1;
									$dg.datagrid(show ? "showColumn" : "hideColumn", field);
								};
							});
						};
					}
				});
			});
		};
	};

	window.DGHelper = DGHelper;

})(window);