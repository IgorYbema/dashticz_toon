import QtQuick 1.1
import BasicUIControls 1.0

Item {
	id: textItem
	width:400
	height:15
	
	property string depTime;
	property string depDestination;
	property string depLine;
	property string depRealtime;
	
	property color colorDark: "#565656"
	
	Item {
		anchors.fill: parent
		
		Text {
			id: text1Title
			width:50
			color: colorDark
			anchors {
			   top: parent.top
			   topMargin: 5
			   left: parent.left
			   leftMargin: 13
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 15
			}
			text: depTime
		}

		Text {
			id: text1Time
			width:50
			color: "#ff0000"
			anchors {
			   top: parent.top
			   topMargin: 5
			   left: text1Title.right
			   leftMargin: 20
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 15
			}
			text: depRealtime
		}

		Text {
			id: text1Data
			width:250
			color: colorDark
			anchors {
			   top: parent.top
			   topMargin: 5
			   left: text1Time.right
			   leftMargin: 20
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 15
			}
			text: depLine+" - "+depDestination
		}
	}
}
