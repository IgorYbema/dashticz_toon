import QtQuick 1.1
import qb.components 1.0

Screen {
	id: dashticzOvScreen
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz / OV"
	
	hasBackButton: false
	property DashticzApp app;

	onShown:{
		if(!ovTimer.running) app.getOV();
		ovTimer.running=true;
	}
	
	DashticzTabs {}
	
	Text {
		id:loadingOvText
		text: "Bezig met laden van OV-informatie...."
		font.pointSize: 12
		color: colors.clockTileColor
		visible: !app.ovReceived
		anchors {
			top: parent.top
			topMargin: 75
			left: parent.left
			leftMargin: 32
		}
	}
		
	Rectangle {
		id: ovBG
		width:400
		height:323
		radius:3
		visible: app.ovReceived
		color: "#f0f0f0"
		anchors {
			top: parent.top
			topMargin: 75
			left: parent.left
			leftMargin: 32
		}
	}
	
	Grid {
		spacing:10
		columns: 1
		rows:15
		visible: app.ovReceived
		anchors {
			top: parent.top
			topMargin: 85
			left: parent.left
			leftMargin: 32
		}

		Repeater {
			id: departuresRepeater
			model: app.departures
		   	OvItem { 
				visible: (index<=10) ? true : false
				depTime: app.departures[index]['time']
				depDestination: app.departures[index]['destinationName']
				depLine: app.departures[index]['service']
				depRealtime: app.departures[index]['realtimeText']
			}
		}
	}
	
	Timer  {
        id: ovTimer
        interval: 120000
        running: false
        repeat: true
        onTriggered: {
			if(app.settings.ovHalte!=="") app.getOV()
		}
    }
}
