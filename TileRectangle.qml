import QtQuick 1.1
import qb.components 1.0
import BasicUIControls 1.0;

StyledRectangle {
	id: tileRectangleItem
	width: 113
	height: 35

	property string idx;
	property string name;
	property string switchdata;
	property string type;
	
	mouseIsActiveInDimState: true
	shadowColor: "transparent"
	
	property color colorLight: "#f0f0f0"
	property color colorMedium: "#A8A8A8"
	property color colorDark: "#565656"
	property color colorActive: "#e64f0a"
	property color bckgColorUp: "#f0f0f0"
	property color bckgColorDown: "#A8A8A8"

	Text {
		id: subLabel
		text: name
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		font.family: qfont.semiBold.name
		font.pixelSize: 13
	}

	state: (switchdata=="On") ? "active" : "up"

	states: [
		State {
			name: "up"
			PropertyChanges { target: tileRectangleItem;    color: bckgColorUp }
			PropertyChanges { target: tileRectangleItem;    shadowPixelSize: 1 }
			PropertyChanges { target: tileRectangleItem;    borderColor: bckgColorUp }
			PropertyChanges { target: subLabel; 			color: colorDark }
		},
		State {
			name: "down"
			PropertyChanges { target: tileRectangleItem;    color: bckgColorDown }
			PropertyChanges { target: tileRectangleItem;    shadowPixelSize: 0 }
			PropertyChanges { target: tileRectangleItem;    borderColor: bckgColorDown }
			PropertyChanges { target: subLabel;				color: colorLight }
		},
		State {
			name: "active"
			PropertyChanges { target: tileRectangleItem;    color: bckgColorUp }
			PropertyChanges { target: tileRectangleItem;    shadowPixelSize: 1 }
			PropertyChanges { target: tileRectangleItem;    borderColor: bckgColorUp }
			PropertyChanges { target: subLabel;				color: colorActive }
		}
	]
	
	MouseArea {
        anchors.fill: parent
        onPressed: {
			
			if(switchdata=="Off") switchdata="On";
			else switchdata="Off";

			if(type == "Group") app.domoticzCall("type=command&param=switchscene&idx="+idx+"&switchcmd="+switchdata,switchdata);
			else app.domoticzCall("type=command&param=switchlight&idx="+idx+"&switchcmd="+switchdata,switchdata);

			tileRectangleItem.state = "down"
		}
		onReleased: {
			if(switchdata=="On"){
				tileRectangleItem.state = "active"
			}
			else{
				tileRectangleItem.state = "up"
			}
		}
    }
}
