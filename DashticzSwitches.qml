import QtQuick 1.1
import qb.components 1.0

Screen {
	id: dashticzSwitches
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz / Schakelaars"
	
	hasBackButton: false
	property DashticzApp app;
	
	onShown: {
		if(!switchesTimer.running) app.getDevices();
		switchesTimer.running=true;
	}
	
	DashticzTabs {}
	
	Text {
		id:loadingText
		text: "Bezig met laden van schakelaars..."
		font.pointSize: 12
		color: colors.clockTileColor
		visible: (!app.devicesReceived) ? true : false
		anchors {
			top: parent.top
			topMargin: 75
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
			top: parent.top
			topMargin: 75
			left: parent.left
			leftMargin: 32
		}

		Repeater {
			id: switchesRepeater
			model: app.devices
			onItemAdded: {
				console.log("Dashticz IDX Added: "+ app.devices[index]['idx']+" > "+ app.devices[index]['Name']);
           	}
		   	SwitchItem {
				idx: app.devices[index]['idx']
				type: app.devices[index]['Type']
				subtype: app.devices[index]['SubType']
				switchtype: app.devices[index]['SwitchType']
				title: app.devices[index]['Name']
				image: app.devices[index]['Image']
				switchdata: app.devices[index]['Data']
				hardwarename: app.devices[index]['HardwareName']
				lastupdate: app.devices[index]['LastUpdate']
			}
		}
	}
	
	Timer  {
        id: switchesTimer
        interval: 60000
        running: false
        repeat: true
        onTriggered: {
			if(app.settings.domoticzHost!=="") app.getDevices()
		}
    }
	
}
