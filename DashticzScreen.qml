import QtQuick 1.1
import qb.components 1.0

Screen {
	id: dashticzScreen
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz"
	
	property DashticzApp app;
	
	onShown: {
		if (!app.devicesReceived){
			app.loadSettings();
		}
	}
	
	Row {
		id:btnRow
		spacing:10
		anchors {
			top: parent.top
			topMargin: 20
			left: parent.left
			leftMargin: 32
		}

		StandardButton {
			id: btnConfigScreen
			width: 100
			height: 45
			text: "Instellingen"
			onClicked: {
				if (app.dashticzSettings) {
					app.dashticzSettings.show();
				}
			}
		}
	}
	
	Text {
		id:loadingText
		text: "Bezig met laden..."
		font.pointSize: 12
		color: colors.clockTileColor
		visible: !app.devicesReceived
		anchors {
			top: btnRow.bottom
			topMargin: 10
			left: parent.left
			leftMargin: 32
		}
	}

	Grid {
		spacing:10
		columns: 4
		rows:5
		visible: app.devicesReceived
		anchors {
			top: btnRow.bottom
			topMargin: 10
			left: parent.left
			leftMargin: 32
		}

		Repeater {
			id: switches
			model: app.devices
			onItemAdded: {
				console.log("Dashticz IDX Added: "+ app.devices[index]['idx']+" > "+ app.devices[index]['Name']);
           	}
		   	SwitchItem {
				idx: app.devices[index]['idx']
				type: app.devices[index]['Type']
				title: app.devices[index]['Name']
				status: app.devices[index]['Data']
				lastupdate: app.devices[index]['LastUpdate']
			}
		}
	}
}
