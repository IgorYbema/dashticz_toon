import QtQuick 1.1
import BasicUIControls 1.0
import qb.components 1.0

Row {
	spacing:10
	anchors {
		top: parent.top
		topMargin: 20
		left: parent.left
		leftMargin: 32
	}

	StandardButton {
		id: btnSwitchesScreen
		width: 106
		height: 45
		text: "Schakelaars"
		visible: (app.settings.domoticzHost!=="") ? true : false
		onClicked: {
			stage.openFullscreen(app.dashticzSwitchesUrl);
		}
	}

	StandardButton {
		id: btnOvScreen
		width: 44
		height: 45
		visible: (app.settings.ovHalte!=="") ? true : false
		text: "OV"
		onClicked: {
			stage.openFullscreen(app.dashticzOvUrl);
		}
	}

	StandardButton {
		id: btnConfigScreen
		width: 106
		height: 45
		text: "Instellingen"
		onClicked: {
			stage.openFullscreen(app.dashticzSettingsUrl);
		}
	}
}