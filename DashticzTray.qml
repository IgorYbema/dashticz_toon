import QtQuick 1.1
import Effects 1.0

import qb.components 1.0
import qb.base 1.0

SystrayIcon {
	id: dashticzSystrayIcon
	visible: true
	posIndex: 8000

	onClicked: {
		stage.openFullscreen(app.dashticzScreenUrl);
	}

	Image {
		id: imgDashticz
		anchors.centerIn: parent
		source: "./drawables/dashticzIcon.png"
	}
}
