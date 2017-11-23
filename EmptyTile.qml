import QtQuick 1.1

import qb.base 1.0

/**
 * A component that represents a tile that enables user to add tiles to page
 *
 * A tile is a clickable element that exist as default tile in
 * each new home screen page
 * Clicking it opens tile selection screen that allow user to select tile
 * to be placed instead of this placeholder.
 */
BaseTile {
	id: emptyTile

	///Differentiate from normal tiles in search for first empty one
	property bool isEmptyTile: true;

	function init() {
	}

	Item {
		anchors.fill: parent
		visible: !dimState

		Image {
			anchors.fill: parent
			source: "drawables/emptyTileBorder.png"
			MouseArea {
				anchors.fill: parent
				onClicked: {
					app.chooseTileScreen.tilePage = page;
					app.chooseTileScreen.tilePos = position;
					app.chooseTileScreen.show();
				}
			}
		}

		Rectangle {
			id: iconShadow

			x:iconBackground.x+1
			y:iconBackground.y+1

			width: iconBackground.width
			height: iconBackground.height
			radius: iconBackground.radius

			color: "transparent"
		}

		Rectangle {
			id: iconBackground

			width: 34
			height: 34
			radius: Math.round(width / 2)

			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom: parent.verticalCenter
			anchors.bottomMargin: 2

			color: "transparent"

			Image {
				id: iconImage

				fillMode: Image.PreserveAspectCrop
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter

				source: "./drawables/Addtile.png"
			}
		}

		Text {
			id: text

			anchors.verticalCenter : parent.verticalCenter
			anchors.horizontalCenter : parent.horizontalCenter

			anchors.bottom: parent.verticalCenter
			anchors.bottomMargin: -20

			color: "#565656"
			font.family: qfont.regular.name
			font.pixelSize: qfont.bodyText

			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignBottom

			text: qsTr("Voeg tegel toe")
		}
	}
}
