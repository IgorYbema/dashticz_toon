import QtQuick 1.1
import BasicUIControls 1.0

Item {
	id: switchTile
	width:177
	height:75
	
	property string idx;
	property string title;
	property string type;
	property string subtype;
	property string image;
	property string switchdata;
	property string lastupdate;
	
	property color colorLight: "#f0f0f0"
	property color colorMedium: "#A8A8A8"
	property color colorDark: "#565656"
	property color bckgColorUp: "#f0f0f0"
	property color bckgColorDown: "#A8A8A8"
	
	state: "up"
	visible: (image == "Light" || type == "Group" || (subtype == "Percentage" && image == "Computer") || image == "Fan") ? true : false;

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
			
			if(switchdata=="Off") switchdata="On";
			else switchdata="Off";
			
			if(type == "Group") app.domoticzCall("type=command&param=switchscene&idx="+idx+"&switchcmd="+switchdata,switchdata);
			else app.domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd="+switchdata,switchdata);
			
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
			width:parent.width
			height:parent.height
			radius:3
			color: bckgColorUp
		}
		
		Image {
			id: switch1Button
			anchors {
			   top: parent.top
			   topMargin: 11
			   left: parent.left
			   leftMargin: 10
			}
			visible: (image == "Light") ? true : false;
			width: 30
			height: 38
			source: (switchdata === "Off") ? "./drawables/bulb_off.png" : "./drawables/bulb_on.png"
		}
		
		Image {
			id: group1Button
			anchors {
			   top: parent.top
			   topMargin: 11
			   left: parent.left
			   leftMargin: 10
			}
			visible: (type == "Group") ? true : false;
			width: 30
			height: 38
			source: (switchdata === "Off") ? "./drawables/group_off.png" : "./drawables/group_on.png"
		}
		
		Image {
			id: fan1Button
			anchors {
				top: parent.top
			   	topMargin: 11
				left: parent.left
				leftMargin: 10
			}
			visible: (image == "Fan") ? true : false;
			width: 30
			height: 38
			source: (switchdata === "Off") ? "./drawables/fan_off.png" : "./drawables/fan_on.png"
		}
		
		Image {
			id: computer1Button
			anchors {
				top: parent.top
			   	topMargin: 11
				left: parent.left
				leftMargin: 10
			}
			visible: (subtype == "Percentage" && image == "Computer") ? true : false;
			width: 30
			height: 38
			source: "./drawables/harddisk.png"
		}

    	Text {
        	id: switch1Title
        	anchors {
				top: parent.top
				topMargin: 7
				left: parent.left
				leftMargin: 50
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
        	text: switchdata
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
