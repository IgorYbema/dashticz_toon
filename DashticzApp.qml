import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0
import "dashticz.js" as DashticzJS 


App {
	id: root
	
	property url trayUrl : "DashticzTray.qml";
	property url tileUrl : "./tiles/DashticzTile.qml";
	property url thumbnailIcon: "./drawables/dashticzIcon.png"
	property url dashticzScreenUrl : "DashticzScreen.qml"
	property url dashticzSettingsUrl : "DashticzSettings.qml"
	
	property DashticzSettings dashticzSettings
	property variant settings: { 
		"domoticzHost": "192.168.1.10",
		"domoticzPort": "8080",
	}

	function init() {
		registry.registerWidget("screen", dashticzScreenUrl, this);
		registry.registerWidget("screen", dashticzSettingsUrl, this, "dashticzSettings");
		registry.registerWidget("systrayIcon", trayUrl, this, "dashticzTray");
		registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: "Dashticz", thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
	}

	Component.onCompleted: {
		loadSettings(); 
	}

	function loadSettings()  {
		var settingsFile = new XMLHttpRequest();
		settingsFile.onreadystatechange = function() {
			if (settingsFile.readyState == XMLHttpRequest.DONE) {
				if (settingsFile.responseText.length > 0)  {
					var temp = JSON.parse(settingsFile.responseText);
					for (var setting in settings) {
						if (!temp[setting])  { temp[setting] = settings[setting]; } // use default if no saved setting exists
					}
					settings = temp;
					collectDomoticzTimer.interval = 3000; // set refresh of timer after 10 sec to get new tariffs in case of parameter changed after load
				}
			}
		}
		settingsFile.open("GET", "file:///HCBv2/qml/apps/dashticz/dashticz.settings", true);
		settingsFile.send();


	}

	function getDomoticz() {
		
	}

	Timer {
		id: collectDomoticzTimer
		interval: 10000
		triggeredOnStart: true 
		running: true
		repeat: true
		onTriggered: {
			collectDomoticzTimer.interval = 10000;
			getDomoticz();
		}
	}

}
