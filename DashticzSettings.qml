import QtQuick 1.1
import qb.components 1.0
import BxtClient 1.0

Screen {
	id: dashticzSettingsScreen
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz / Instellingen"

	hasBackButton: false
	hasHomeButton: false
	hasCancelButton: true


	onShown: {
		addCustomTopRightButton("Opslaan");
		if(domoticzHostLabel.inputText=="") 	domoticzHostLabel.inputText = app.settings.domoticzHost;
		if(domoticzPortLabel.inputText=="") 	domoticzPortLabel.inputText = app.settings.domoticzPort;
		if(domoticzUsernameLabel.inputText=="") domoticzUsernameLabel.inputText = app.settings.domoticzUsername;
		if(domoticzPasswordLabel.inputText=="") domoticzPasswordLabel.inputText = app.settings.domoticzPassword;
		if(domoticzTileIDXLabel.inputText=="") 	domoticzTileIDXLabel.inputText = app.settings.domoticzTileIDX;
		if(ovHalteLabel.inputText=="") 			ovHalteLabel.inputText = app.settings.ovHalte;
	}

	onCustomButtonClicked: {
		var temp = app.settings; // updating app property variant is only possible in its whole, not by elements only, so we need this
		temp.domoticzHost = domoticzHostLabel.inputText;
		temp.domoticzPort = domoticzPortLabel.inputText;
		temp.domoticzUsername = domoticzUsernameLabel.inputText;
		temp.domoticzPassword = domoticzPasswordLabel.inputText;
		temp.domoticzTileIDX = domoticzTileIDXLabel.inputText;
		temp.ovHalte = ovHalteLabel.inputText;
		app.settings = temp;

		var saveFile = new XMLHttpRequest();
		saveFile.open("PUT", "file:///HCBv2/qml/apps/dashticz/dashticz.settings");
		saveFile.send(JSON.stringify(app.settings));
		
		//hide();
		app.settingsLoaded=false
		stage.openFullscreen(app.dashticzScreenUrl);
	}


	function hostnameValidate(text, isFinal) {
		if (isFinal) {
			if ((text.match(/^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$/)) || (text.match(/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/))) {
				return null;
			}
			else {
				return {content: "Onjuist hostnaam of IP adres"};
			}
			return null;
		}
		return null;
	}

	function numValidate(text, isFinal) {
		if (isFinal) {
			if (text.match(/^[0-9]*$/)) {
				return null;
			}
			else {
				return {content: "Poortnummer onjuist"};
			}
			return null;
		}
		return null;
	}

	function updateDomoticzHostLabel(text) {
		if (text) { 
			domoticzHostLabel.inputText = text;
		}
	}

	function updateDomoticzPortLabel(text) {
		if (text) {
			if (text.match(/^[0-9]*$/)) {
				domoticzPortLabel.inputText = text;
			}
		}
	}

	function updateDomoticzUsernameLabel(text) {
		if (text) domoticzUsernameLabel.inputText = text;
	}

	function updateDomoticzPasswordLabel(text) {
		if (text) domoticzPasswordLabel.inputText = text;
	}
	
	function updateovHalteLabel(text) {
		if (text) ovHalteLabel.inputText = text;
	}
	
	function updateDomoticzTileIDXLabel(text) {
		if (text) domoticzTileIDXLabel.inputText = text;
	}

	function updateDashticzPortLabel(text) {
		if (text) {
			if (text.match(/^[0-9]*$/)) {
				dashticzPortLabel.inputText = text;
			}
		}
	}


	// domoticz
	Text {
		id: domoticzText
		font.pixelSize: 16
		font.family: qfont.semiBold.name
		text: "Domoticz"
		anchors {
			top: parent.top
			topMargin: 20
			left: parent.left
			leftMargin: 16
		}
	}
	
	EditTextLabel {
		id: domoticzHostLabel
		width: 350
		height: 35
		leftText: "Host (zonder http://)"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzText.left
			top: domoticzText.bottom                       
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Hostnaam", domoticzHostLabel.inputText, updateDomoticzHostLabel,hostnameValidate);
		}
	}

	EditTextLabel {
		id: domoticzPortLabel
		width: 350
		height: 35
		leftText: "Port"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzHostLabel.left
			top: domoticzHostLabel.bottom                       
			topMargin: 10
		}

		onClicked: {
			qnumKeyboard.open("Poort", domoticzPortLabel.inputText, "Nummer", 1 , updateDomoticzPortLabel,numValidate);
		}
	}

	EditTextLabel {
		id: domoticzTileIDXLabel
		width: 350
		height: 35
		leftText: "Tile IDX (max 6)"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzHostLabel.left
			top: domoticzPortLabel.bottom                       
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Tile IDX (max 6)", domoticzTileIDXLabel.inputText, updateDomoticzTileIDXLabel);
		}
	}

	EditTextLabel {
		id: domoticzUsernameLabel
		width: 350
		height: 35
		leftText: "Gebruikersnaam (base64encoded)"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzHostLabel.right                   
			leftMargin: 20
			top: domoticzText.bottom                      
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Gebruikersnaam", domoticzUsernameLabel.inputText, updateDomoticzUsernameLabel);
		}
	}
	
	EditTextLabel {
		id: domoticzPasswordLabel
		width: 350
		height: 35
		leftText: "Wachtwoord (base64encoded)"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzHostLabel.right                   
			leftMargin: 20
			top: domoticzUsernameLabel.bottom                      
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Wachtwoord", domoticzPasswordLabel.inputText, updateDomoticzPasswordLabel);
		}
	}
	
	//ov
	Text {
		id: dashticzText
		font.pixelSize: 16
		font.family: qfont.semiBold.name
		text: "OV Informatie"
		anchors {
			left: domoticzText.left
			top: domoticzTileIDXLabel.bottom                       
			topMargin: 30
		}
	}
	
	EditTextLabel {
		id: ovHalteLabel
		width: 350
		height: 35
		leftText: "Station / Halte"
		leftTextAvailableWidth: 200

		anchors {
			left: dashticzText.left
			top: dashticzText.bottom                       
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Station / Halte", ovHalteLabel.inputText, updateovHalteLabel);
		}
	}

}
