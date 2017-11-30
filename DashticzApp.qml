import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0
import HttpRequest 1.0
import "dashticz.js" as DashticzJS 


App {
	id: root
	
	property url trayUrl : "DashticzTray.qml"
	property url tileUrl : "./DashticzTile.qml"
	property url thumbnailIcon: "./drawables/dashticzIcon.png"
	property url dashticzScreenUrl : "DashticzScreen.qml"
	property url dashticzSettingsUrl : "DashticzSettings.qml"
	
	property variant devices : []
	property bool devicesReceived: false
	
	property string username: "YWRtaW4="
	property string password: "U21hcnQyMDA0cg=="
	
	property DashticzSettings dashticzSettings
	property variant settings: { 
		"domoticzHost": "192.168.1.10",
		"domoticzPort": "8080",
	}

	function init() {
		registry.registerWidget("screen", dashticzScreenUrl, this);
		registry.registerWidget("screen", dashticzSettingsUrl, this, "dashticzSettings");
		registry.registerWidget("systrayIcon", trayUrl, this, "dashticzTray");
		//registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: "Dashticz", thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
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
				}
			}
		}
		settingsFile.open("GET", "file:///HCBv2/qml/apps/dashticz/dashticz.settings", true);
		settingsFile.send();


	}
	
	function domoticzCall(url,onoff) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("GET", "http://192.168.1.3:8084/json.htm?username="+username+"&password="+password+"&"+url, true);
		xmlhttp.send();
	}
	
	function getDevices() {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					var res = JSON.parse(xmlhttp.responseText);
					devices = res["result"]
					devicesReceived = true;
				}
			}
		}
		xmlhttp.open("GET", "http://192.168.1.3:8084/json.htm?username="+username+"&password="+password+"&type=devices&favorite=1&filter=all&used=true&order=Name", true);
		xmlhttp.send();
	}
	
	Timer {
		id: collectDomoticzTimer
		interval: 10000
		triggeredOnStart: true 
		running: true
		repeat: true
		onTriggered: {
			getDevices();
		}
	}

}
