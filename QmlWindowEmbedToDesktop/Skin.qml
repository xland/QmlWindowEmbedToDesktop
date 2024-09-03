import QtQuick 2.3

Item {
	property string bg;
	property string text0; //日期标题，当月日期
	property string text1; //阴历，节假日
	property string text2; //上月或下月日期
	property string toolTipBg; 
	property string toolTipText; 
	property string menuBg; 
	property string menuText; 
	property string menuHover; 
	function setBlack(){
		text0 = "#FFFFFF"
		text1 = "#D2D3D4"
		text2 = "#A5A7A9"
		toolTipBg = "#FFFFFF"
		toolTipText = "#1F2329"
		menuBg = "#000000"
		menuText = "#FFFFFF"
		menuHover = "#33FFFFFF"
	}
	function setWhite(){
		text0 = "#1F2329"
		text1 = "#4C4F54"
		text2 = "#666666"
		toolTipBg = "#1A1A1A"
		toolTipText = "#FFFFFF"
		menuBg = "#EDEEEE"
		menuText = "#1F2329"
		menuHover = "#E0E0E0"
	}
	function setSkin(alpha,name){
		let hex = Math.round(alpha * 255).toString(16);
        let aVal = hex.length === 1 ? '0' + hex : hex;
		if(name === 'type1'){
			bg = `#${aVal}FFFFFF`;
			setWhite();
		}else{
			bg = `#${aVal}000000`;
			setBlack();
		}
	}
}
