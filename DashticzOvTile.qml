import QtQuick 1.1
import qb.base 1.0
import qb.components 1.0
import BasicUIControls 1.0;


Tile {
	id: dashticzOvTile

	function init() {}

	onClicked: {
		stage.openFullscreen(app.dashticzOvUrl);
	}
	
	Image {
		anchors {
			baseline: parent.top
			baselineOffset: 30
			horizontalCenter: parent.horizontalCenter
		}
		id: tileImage
		width: 94
		height: 71
		source: app.tileIcon
	}
	
	Text {
		id: tileTitle
		anchors {
			top: tileImage.bottom
			topMargin: 20
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: colors.tileTitleColor
		text: "OV"
	}
}
