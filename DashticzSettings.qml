import QtQuick 1.1
import qb.components 1.0
import BxtClient 1.0

Screen {
	id: dashticzSettingsScreen

	hasBackButton: true
	hasHomeButton: false
	hasCancelButton: true


	property bool firstShown: true;  // we need this because exiting a keyboard will load onShown again. Without this the input will be overwritten with the app settings again


	screenTitle: "Dashticz Instellingen"

	onShown: {
		addCustomTopRightButton("Opslaan");
		if (firstShown) {  // only update the input boxes if this is the first time shown, not while coming back from a keyboard input
			domoticzToggle.isSwitchedOn = app.settings.domoticzEnable;
			domoticzHostLabel.inputText = app.settings.domoticzHost;
			domoticzPortLabel.inputText = app.settings.domoticzPort;
			firstShown = false;
		}
	}

	onCanceled: {
		firstShown = true; // if canceled we can overwrite the input boxes again with the app settings 
	}



	onCustomButtonClicked: {
		hide();
		var temp = app.settings; // updating app property variant is only possible in its whole, not by elements only, so we need this
		temp.domoticzEnable = domoticzToggle.isSwitchedOn; 
		temp.domoticzHost = domoticzHostLabel.inputText;
		temp.domoticzPort = domoticzPortLabel.inputText;
		temp.domoticzIdx = domoticzIdxLabel.inputText;
		app.settings = temp;

		firstShown = true; // we have saved the settings so on a fresh settings screen we can load the input boxes with the new app settings

		// save the new app settings into the json file
		var saveFile = new XMLHttpRequest();
		saveFile.open("PUT", "file:///HCBv2/qml/apps/dashticz/dashticz.settings");
		saveFile.send(JSON.stringify(app.settings));

		app.getDomoticz(); // fetch new data on each save

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
				return {content: "Poort nummer onjuist"};
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

	function updateDomoticzIdxLabel(text) {
		if (text) {
			if (text.match(/^[0-9]*$/)) {
				domoticzIdxLabel.inputText = text;
			}
		}
	}

	// toggles
	Text {
		id: checkTest
		x: 15
		y: 10
		font.pixelSize: 16
		font.family: qfont.semiBold.name
		text: "Check test"
	}

	OnOffToggle {
		id: domoticzToggle
		height: 36
		anchors.left: checkTest.right
		anchors.leftMargin: 20
		anchors.top: checkTest.top
		leftIsSwitchedOn: false
	}

	// domoticz
	Text {
		id: domoticzText
		font.pixelSize: 16
		font.family: qfont.semiBold.name
		text: "Domoticz URL"
		anchors {
			left: domoticzToggle.right
			leftMargin: 20
			top: domoticzToggle.top
			topMargin: 0 
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



}
