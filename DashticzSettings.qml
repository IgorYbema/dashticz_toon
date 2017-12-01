import QtQuick 1.1
import qb.components 1.0
import BxtClient 1.0

Screen {
	id: dashticzSettingsScreen

	hasBackButton: true
	hasHomeButton: false
	hasCancelButton: true

	screenTitle: "Dashticz Instellingen"

	onShown: {
		addCustomTopRightButton("Opslaan");
		domoticzHostLabel.inputText = app.settings.domoticzHost;
		domoticzPortLabel.inputText = app.settings.domoticzPort;
		domoticzUsernameLabel.inputText = app.settings.domoticzUsername;
		domoticzPasswordLabel.inputText = app.settings.domoticzPassword;
	}

	onCustomButtonClicked: {
		var temp = app.settings; // updating app property variant is only possible in its whole, not by elements only, so we need this
		temp.domoticzHost = domoticzHostLabel.inputText;
		temp.domoticzPort = domoticzPortLabel.inputText;
		temp.domoticzUsername = domoticzUsernameLabel.inputText;
		temp.domoticzPassword = domoticzPasswordLabel.inputText;
		app.settings = temp;

		var saveFile = new XMLHttpRequest();
		saveFile.open("PUT", "file:///HCBv2/qml/apps/dashticz/dashticz.settings");
		saveFile.send(JSON.stringify(app.settings));
		
		hide();
		app.getDevices();
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


	// domoticz
	Text {
		id: domoticzText
		font.pixelSize: 16
		font.family: qfont.semiBold.name
		text: "Domoticz URL"
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
		leftText: "Host"
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
	IconButton {
		id: domoticzHostLabelButton;
		width: 40
		iconSource: "./drawables/edit.png"

		anchors {
			left: domoticzHostLabel.right
			leftMargin: 6
			top: domoticzHostLabel.top
		}

		bottomClickMargin: 3
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
	IconButton {
		id: domoticzPortLabelButton;
		width: 40
		iconSource: "./drawables/edit.png"

		anchors {
			left: domoticzPortLabel.right
			leftMargin: 6
			top: domoticzPortLabel.top
		}

		bottomClickMargin: 3
		onClicked: {
			qnumKeyboard.open("Poort", domoticzPortLabel.inputText, "Nummer", 1 , updateDomoticzPortLabel,numValidate);
		}
	}


	EditTextLabel {
		id: domoticzUsernameLabel
		width: 350
		height: 35
		leftText: "Gebruikersnaam"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzPortLabel.left
			top: domoticzPortLabel.bottom                       
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Gebruikersnaam", domoticzUsernameLabel.inputText, updateDomoticzUsernameLabel);
		}
	}
	IconButton {
		id: domoticzUsernameLabelButton;
		width: 40
		iconSource: "./drawables/edit.png"

		anchors {
			left: domoticzUsernameLabel.right
			leftMargin: 6
			top: domoticzUsernameLabel.top
		}

		bottomClickMargin: 3
		onClicked: {
			qkeyboard.open("Gebruikersnaam", domoticzUsernameLabel.inputText, updateDomoticzUsernameLabel);
		}
	}

	
	EditTextLabel {
		id: domoticzPasswordLabel
		width: 350
		height: 35
		leftText: "Wachtwoord"
		leftTextAvailableWidth: 200

		anchors {
			left: domoticzUsernameLabel.left
			top: domoticzUsernameLabel.bottom                       
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Wachtwoord", domoticzPasswordLabel.inputText, updateDomoticzPasswordLabel);
		}
	}
	IconButton {
		id: domoticzPasswordLabelButton;
		width: 40
		iconSource: "./drawables/edit.png"

		anchors {
			left: domoticzPasswordLabel.right
			leftMargin: 6
			top: domoticzPasswordLabel.top
		}

		bottomClickMargin: 3
		onClicked: {
			qkeyboard.open("Wachtwoord", domoticzPasswordLabel.inputText, updateDomoticzPasswordLabel);
		}
	}

}
