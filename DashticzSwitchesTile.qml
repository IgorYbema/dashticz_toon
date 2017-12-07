import QtQuick 1.1
import qb.base 1.0
import qb.components 1.0
import BasicUIControls 1.0;


Tile {
	id: dashticzSwitchesTile

	function init() {
		app.runningFromTile=true
		app.loadDevices=true
		app.loadSettings()
	}

	Row {
		id: tileTitleRow
		anchors {
			baseline: parent.top
			baselineOffset: 8
			horizontalCenter: parent.horizontalCenter
			topMargin: 10
		}
			
		Image {
			id: tileImage
			width: 24
			height: 24
			source: app.thumbnailIcon
		}

		Text {
			id: tileTitle
			anchors {
				leftMargin: 10
			}
			font {
				family: qfont.regular.name
				pixelSize: qfont.tileTitle
			}
			color: colors.tileTitleColor
			text: "Dashticz"
		}
	}
	
	Text {
		id:loadingSettingsText
		text: "Bezig met laden..."
		font.pointSize: 12
		visible: (!app.settingsLoaded && app.tileIDXList[0]!=="" && app.settings.domoticzHost!=="") ? true : false
		color: colors.clockTileColor
		anchors {
			top: tileTitleRow.bottom
			topMargin: 28
			horizontalCenter: parent.horizontalCenter
		}
	}
	
	Text {
		id:loadingIDXText
		text: "Vul IDX nummers in!"
		font.pointSize: 12
		visible: (app.tileIDXList[0]=="" && app.settings.domoticzHost!=="") ? true : false
		color: colors.clockTileColor
		anchors {
			top: tileTitleRow.bottom
			topMargin: 28
			horizontalCenter: parent.horizontalCenter
		}
	}
	
	Text {
		id:loadingHostText
		text: "Vul Domoticz-host in!"
		font.pointSize: 12
		visible: (app.settings.domoticzHost=="") ? true : false
		color: colors.clockTileColor
		anchors {
			top: tileTitleRow.bottom
			topMargin: 28
			horizontalCenter: parent.horizontalCenter
		}
	}
	
	Grid {
		id: tempGrid
		anchors {
			top: tileTitleRow.bottom
			topMargin: 8
			leftMargin:1
		}
		width: parent.width
		rows: 3
		visible: (app.devicesPerIDX.length>0 && app.tileIDXList[0]!=="") ? true : false
		columns: 2
		spacing: 4
		
		Repeater {
			id: tileButtonRepeater
			model: app.tileIDXList
		   	TileRectangle {
				idx: app.tileIDXList[index]
				name: app.devicesPerIDX[app.tileIDXList[index]]["Name"]
				switchdata: app.devicesPerIDX[app.tileIDXList[index]]["Data"]
				type:app.devicesPerIDX[app.tileIDXList[index]]["Type"]
			}
		}
	}

}
