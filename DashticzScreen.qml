import QtQuick 1.1
import qb.components 1.0

Screen {
	id: dashticzScreen
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz"
	
	hasBackButton: false
	property DashticzApp app;
	
	function goToScreen(){
		app.runningFromTile=false
		if(app.settingsLoaded){
			settingsTimer.running = false
			if(app.settings.domoticzHost!==""){
				stage.openFullscreen(app.dashticzSwitchesUrl);
			}
			else if(app.settings.ovHalte!==""){
				stage.openFullscreen(app.dashticzOvUrl);
			}
			else {
				app.noApps=true;
			}
		}
		else {
			settingsTimer.running = true
			app.loadSettings()
		}
	}
			
	onShown: {
		goToScreen();
	}
	
	Text {
		id:loadingSettingsText
		text: "Bezig met laden..."
		font.pointSize: 12
		visible: !app.noApps
		color: colors.clockTileColor
		anchors {
			top: parent.top
			topMargin: 75
			left: parent.left
			leftMargin: 32
		}
	}
	
	DashticzTabs {
		visible: app.noApps
	}
	
	Text {
		id:loadingText
		text: "Ga naar Instellingen om te beginnen!"
		font.pointSize: 12
		visible: app.noApps
		color: colors.clockTileColor
		anchors {
			top: parent.top
			topMargin: 75
			left: parent.left
			leftMargin: 32
		}
	}
	
	Timer  {
        id: settingsTimer
        interval: 2000
        running: false
        repeat: true
        onTriggered: {
			goToScreen()
		}
    }
	
}
