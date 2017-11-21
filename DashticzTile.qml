import QtQuick 1.1
import qb.base 1.0
import qb.components 1.0
import BasicUIControls 1.0;


Tile {
	id: easyenergyTile

	function init() {}

	onClicked: {
		stage.openFullscreen(app.dashticzScreenUrl);
	}

	Text {
		id: tileTitle
		anchors {
			baseline: parent.top
			baselineOffset: 30
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: colors.tileTitleColor
		text: "Dashticz"
	}
}
