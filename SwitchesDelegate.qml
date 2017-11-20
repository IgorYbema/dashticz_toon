import QtQuick 1.1
import BasicUIControls 1.0
import qb.components 1.0

Rectangle
{
	width: 265
	height: 50
	color: colors.canvas
	property string kpiPrefix: "switchesFilterScreen."

	function saveSwitches(location) {
	
	}

	StandardButton {
		id: switchesButton
		controlGroup: switchesFilterGroup
		width: 220
		height: 45
		radius: 5
		text: name
		fontPixelSize: 15

		onClicked: {
			app.location = text.substring(0,4);
			app.getDomoticz();
		}
	}
	
	IconButton {
        id: switchesIconButton
        anchors {
            top: switchesButton.top
            left: switchesButton.right
        }
        width: 45
        height: 45

        iconSource: app.switchStatusIcon

		onClicked: {
			app.location = text.substring(0,4);
			app.getDomoticz();
		}
    }
	
}


