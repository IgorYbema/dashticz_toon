import QtQuick 1.1
import BasicUIControls 1.0

Item {
	id: switchTile
	width:165
	height:75
	
	visible: (type == "Lighting 2") ? true : false;
	
	property string idx;
	property string title;
	property string type;
	property string status;
	property string lastupdate;
	
	property color colorLight: "#f0f0f0"
	property color colorMedium: "#A8A8A8"
	property color colorDark: "#565656"
	property color bckgColorUp: "#f0f0f0"
	property color bckgColorDown: "#A8A8A8"
	
	state: "up"

	states: [
		State {
			name: "up"
			PropertyChanges { target: switch1Title; color: colorDark}
			PropertyChanges { target: switch1Last; color: colorDark}
			PropertyChanges { target: switch1Data; color: colorDark}
			PropertyChanges { target: switch1BG; color: bckgColorUp}
		},
		State {
			name: "down"
			PropertyChanges { target: switch1Title; color: bckgColorUp}
			PropertyChanges { target: switch1Last; color: bckgColorUp}
			PropertyChanges { target: switch1Data; color: bckgColorUp}
			PropertyChanges { target: switch1BG; color: bckgColorDown}
		}
	]
	
	MouseArea {
        anchors.fill: parent
        onPressed: {
			
			if(status=="Off") status="On";
			else status="Off";
			app.domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd="+status,status);
			
			switchTile.state = "down"
		}
		onReleased: {
			switchTile.state = "up"
		}
    }

	Item {
		anchors.fill: parent	

		Rectangle {
			id: switch1BG
			width:165
			height:75
			radius:3
			color: bckgColorUp
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
			source: (status === "On") ? "./drawables/bulbyellow_on.png" : "./drawables/bulbyellow_off.png"
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
        	color: colorDark
        	text: title
    	}

    	Text {
        	id: switch1Data
        	anchors {
				top: switch1Title.bottom
				left: switch1Button.right
				leftMargin: 10
        	}
        	font {
				family: qfont.semiBold.name
				pixelSize: 12
        	}
        	color: colorDark
        	text: status
    	}

		Text {
			id: switch1Last
			anchors {
				top: switch1Data.bottom
				topMargin: 3
				left: switch1Button.right
				leftMargin: 10
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 9
			}
			color: colorMedium
			text: lastupdate
		}
	}
}
