import QtQuick 1.1
import BasicUIControls 1.0

Item {
	id: switchItem
	width:177
	height:75
	
	property string idx;
	property string title;
	property string type;
	property string subtype;
	property string image;
	property string switchdata;
	property string switchtype;
	property string lastupdate;
	property string hardwarename;
	
	property color colorLight: "#f0f0f0"
	property color colorMedium: "#A8A8A8"
	property color colorDark: "#565656"
	property color bckgColorUp: "#f0f0f0"
	property color bckgColorDown: "#A8A8A8"
	
	state: "up"
	visible: (image == "Light" || hardwarename=="DownloadSensor" || hardwarename=="UploadSensor" || type == "Group" || type == "Temp" || type == "Scene" || subtype == "Visibility" || (subtype == "Percentage" && image == "Computer") || image == "Fan") ? true : false;

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
			
			if(image == "Light" || type == "Group" || type == "Scene" || image == "Fan"){
				if(switchdata=="Off") switchdata="On";
				else switchdata="Off";
				
				if(switchtype == "Push On Button" || type == "Scene") switchdata="On";
				if(type == "Group" || type == "Scene") app.domoticzCall("type=command&param=switchscene&idx="+idx+"&switchcmd="+switchdata,switchdata);
				else app.domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd="+switchdata,switchdata);

				switchItem.state = "down"
			}
		}
		onReleased: {
			switchItem.state = "up"
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
			visible: ((switchtype == "On/Off" || switchtype == "Dimmer") && image!=="Fan") ? true : false;
			width: 30
			height: 38
			source: (switchdata === "Off") ? "./drawables/bulb_off.png" : "./drawables/bulb_on.png"
		}
		
		Image {
			id: pushon1Button
			anchors {
			   top: parent.top
			   topMargin: 11
			   left: parent.left
			   leftMargin: 10
			}
			visible: (switchtype == "Push On Button" || type == "Scene") ? true : false;
			width: 30
			height: 38
			source: "./drawables/pushon.png"
		}
		
		Image {
			id: pushoff1Button
			anchors {
			   top: parent.top
			   topMargin: 11
			   left: parent.left
			   leftMargin: 10
			}
			visible: (switchtype == "Push Off Button") ? true : false;
			width: 30
			height: 38
			source: "./drawables/pushoff.png"
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
		
		Image {
			id: eye1Button
			anchors {
				top: parent.top
			   	topMargin: 11
				left: parent.left
				leftMargin: 10
			}
			visible: (subtype == "Visibility") ? true : false;
			width: 30
			height: 38
			source: "./drawables/eye.png"
		}
		
		Image {
			id: temp1Button
			anchors {
				top: parent.top
			   	topMargin: 11
				left: parent.left
				leftMargin: 10
			}
			visible: (type == "Temp") ? true : false;
			width: 30
			height: 38
			source: "./drawables/temp.png"
		}
		
		Image {
			id: download1Button
			anchors {
				top: parent.top
			   	topMargin: 11
				left: parent.left
				leftMargin: 10
			}
			visible: (hardwarename == "DownloadSensor") ? true : false;
			width: 30
			height: 38
			source: "./drawables/download.png"
		}
		
		Image {
			id: upload1Button
			anchors {
				top: parent.top
			   	topMargin: 11
				left: parent.left
				leftMargin: 10
			}
			visible: (hardwarename == "UploadSensor") ? true : false;
			width: 30
			height: 38
			source: "./drawables/upload.png"
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
