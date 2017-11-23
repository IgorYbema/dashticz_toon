import QtQuick 1.1

import qb.base 1.0

BaseTile {
	id: switchTile
	property bool isEmptyTile: false;
	property string username: "YWRtaW4=";
	property string password: "U21hcnQyMDA0cg==";
	property string idx:"204";
	property string title:"Eettafel";
	
	property string switchIcon:"bulbyellow_off.png";
	property string status:"Off";
	
	function init(idx,title) {
	}

	function domoticzCall(url,onoff) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("GET", "http://192.168.1.3:8084/json.htm?username="+username+"&password="+password+"&"+url, true);
		xmlhttp.send();
		
		status = onoff
		if (onoff == "On") {
			switchIcon = "bulbyellow_on.png";
		} else {
			switchIcon = "bulbyellow_off.png";
		}
		
	}

	Item {
		anchors.fill: parent
		visible: !dimState		
		width:500
		height:300
		
		Image {
			anchors.fill: parent
			source: "drawables/emptyTileBorder.png"
			width:500
			height:300
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
			source: "./drawables/"+switchIcon
			MouseArea {
				id: switch1Mouse
				anchors.fill: parent
				onClicked: {
					if(status=="Off") domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd=On","On");
					else domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd=Off","Off");
				}
			}
		}

    	Text {
        	id: switch1Title
        	anchors {
			   	top: parent.top
				topMargin: 7
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
