import QtQuick 1.1
import BasicUIControls 1.0

Item {
	id: switchTile
	width:165
	height:58
	
	property string switchIcon:"./drawables/bulbyellow_off.png";
	property string idx;
	property string title;
	property string status;
	property string lastupdate;
	
	MouseArea {
        anchors.fill: parent
        onClicked: {
			if(status=="Off") app.domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd=On","On");
			else app.domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd=Off","Off");
		}
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
			text: lastupdate
		}
	}
}
