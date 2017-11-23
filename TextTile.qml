import QtQuick 1.1
import qb.base 1.0
import qb.components 1.0
import BasicUIControls 1.0;

BaseTile {
	id: tuinhuisTile
	width:205
	height:108
	
	function init() { }

	Item {
		anchors.fill: parent
		
    	Text {
        	id: switch1Title
        	anchors {
			   top: parent.top
			   topMargin: 10
			   left: parent.left
			   leftMargin: 10
        	}
        	font {
				family: qfont.semiBold.name
				pixelSize: 15
        	}
        	color: colors.clockTileColor
        	text: "Afvalkalender"
    	}

		Text {
			id: switch1Last
			anchors {
				top: switch1Title.bottom
			   	left: parent.left
				leftMargin: 10
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 11
			}
			color: colors.clockTileColor
			text: "GFT: Maandag"
		}

		Text {
			id: switch1Last
			anchors {
				top: switch1Last.bottom
			   	left: parent.left
				leftMargin: 10
			}
			font {
				family: qfont.semiBold.name
				pixelSize: 11
			}
			color: colors.clockTileColor
			text: "Papier: Dinsdag"
		}
	}
}
