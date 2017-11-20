import QtQuick 1.1

import qb.components 1.0

Screen {
	id: dashticzScreen
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz"
	
	onShown: {

		switchesFilterModel.clear();
		switchesFilterModel.append({name: 'Woonkamer'});
		switchesFilterModel.append({name: 'Keuken'});
		switchesFilterModel.append({name: 'Gang'});

	}

	StandardButton {
		id: btnConfigScreen
		width: 265
		height: 45
		text: "Instellingen"
		anchors {
			fill: parent
			top: parent.top
			left: parent.right
			topMargin: 5
			rightMargin: 35
		}
		onClicked: {
			if (app.dashticzSettings) {
				app.dashticzSettings.show();
			}
		}
	}

	GridView {
		id: switchesGridView

		model: switchesFilterModel
		delegate: SwitchesDelegate {}

		interactive: false
		flow: GridView.TopToBottom
		cellWidth: 250
		cellHeight: 50

		anchors {
			fill: parent
			top: parent.top
			left: parent.left
			topMargin: 5
			leftMargin: 35
		}
	}

	ListModel {
		id: switchesFilterModel
	}
}
