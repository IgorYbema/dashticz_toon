import QtQuick 1.1
import qb.base 1.0
import qb.components 1.0
import BasicUIControls 1.0;

Tile {
	id: tuinTile
	width:165
	height:58
	
	property string switchIcon:"./drawables/bulbyellow_off.png";
	property string idx:"110";
	property string title:"Tuin";
	property string status:"Off";
	
	property string username: "YWRtaW4=";
	property string password: "U21hcnQyMDA0cg==";
	
	function init() { }

	onClicked: {
		if(status=="Off") domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd=On","On");
		else domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd=Off","Off");
	}

	function checkStatus(){
		switchIcon = "./drawables/bulbyellow_off.png";
		if (status == "On") {
			switchIcon = "./drawables/bulbyellow_on.png";
		}
	}
	
	function domoticzCall(url,onoff) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("GET", "http://192.168.1.3:8084/json.htm?username="+username+"&password="+password+"&"+url, true);
		xmlhttp.send();
		
		status = onoff
		checkStatus();
		
	}

	Item {
		anchors.fill: parent
		visible: !dimState		
		
		Image {
			anchors.fill: parent
			source: "drawables/emptyTileBorder.png"
		}

		Image {
			id: switch1Button
			anchors {
			   top: parent.top
			   topMargin: 10
			   left: parent.left
			   leftMargin: 10
			}
			width: 30
			height: 38
			source: switchIcon
		}

    	Text {
        	id: switch1Title
        	anchors {
			   	top: parent.top
				topMargin: 10
				left: switch1Button.right
				leftMargin: 10
        	}
        	font {
				family: qfont.semiBold.name
				pixelSize: 15
        	}
        	color: colors.clockTileColor
        	text: title
    	}

		Text {
			id: switch1Last
			anchors {
				top: switch1Title.bottom
				left: switch1Button.right
				leftMargin: 10
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 11
			}
			color: colors.clockTileColor
			text: "22-11-2017 21:33"
		}
	}
}
