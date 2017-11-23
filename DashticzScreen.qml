import QtQuick 1.1

import qb.components 1.0

Screen {
	id: dashticzScreen
	screenTitleIconUrl: "drawables/dashticzIcon.png"
	screenTitle: "Dashticz"
	
	property DashticzApp app;
	
	property int tilesCount: 0
	property int pagecount: 0
	property int currentPage: 0

	property url emptyTileUrl: "EmptyTile.qml"
	property url tilePageUrl: "TilePage.qml"

	function createPage() {
		var newPage = util.loadComponent(tilePageUrl, tileContainer, {});

		if (newPage === null) {
			return;
		}

		for (var i = 0; i < newPage.children.length; i++) {
			newPage.children[i].homeApp = app;
			newPage.children[i].page = pagecount;
			newPage.children[i].position = i;
		}

		pagecount = pagecount + 1;
	}
	
	function navigatePage(page) {
		var lastCurrentPage = currentPage;
		currentPage = page;
		var endPage = pagecount;
		endPage -= 1;
		var removePage = false;

		var lastPageContainer = tileContainer.children[lastCurrentPage];

		// if previous page is not a last page and is empty - remove it
		if (lastCurrentPage !== endPage && lastPageContainer.empty) {
			lastPageContainer.visible = false;
			lastPageContainer.parent = null;
			lastPageContainer.destroy();
			pagecount--;
			removePage = true;
			for (var i = lastCurrentPage; i < endPage; ++i) {
				for (var j = 0; j < 4; ++j) {
					tileContainer.children[i].children[j].page -= 1;
				}
			}
		}

		if (currentPage === endPage && removePage) {
			currentPage = pagecount - 1;
			widgetNavBar.navigateBtn(currentPage);
		} else if (lastCurrentPage < currentPage && removePage) {
			currentPage -= 1;
			widgetNavBar.navigateBtn(currentPage);
		} else {
			// 2 pixel offset because of tile-shadow (page display must be 2 pixels wider than the actual page is)
			tileContainerParent.contentX = currentPage * (leftPanel.width - 2 + tileContainer.spacing);
			var currentPageContainer = tileContainer.children[currentPage];

			for (i = 0; i < currentPageContainer.children.length; i++) {
				currentPageContainer.children[i].pageChange(currentPage);
			}
		}
	}
	
	function init(app) {
		this.app=app;
		createPage();
	}
	
	onShown: {
		widgetNavBar.navigateBtn(0);
	}
	
	StandardButton {
		id: btnConfigScreen
		width: 100
		height: 45
		text: "Instellingen"
		anchors {
			bottom: widgetNavBar.bottom
			left: parent.left
			leftMargin: 32
		}
		onClicked: {
			if (app.dashticzSettings) {
				app.dashticzSettings.show();
			}
		}
	}

	UnFlickable {
		id: tileContainerParent
		width: parent.width
		height: 330
		anchors {
			left: parent.left
			top: parent.top
			topMargin: 22
		}
		boundsBehavior: Flickable.StopAtBounds
		flickableDirection: Flickable.HorizontalFlick
		clip: true

		Row {
			id: tileContainer
			anchors {
				fill: parent
				leftMargin: 32
				rightMargin: anchors.leftMargin
			}
			spacing: 10
		}
	}

	DottedSelector {
		id: widgetNavBar
		anchors {
			horizontalCenter: tileContainerParent.horizontalCenter
			verticalCenter: parent.bottom
			verticalCenterOffset: -33
		}
		opacity: colors.opaqueOnActive
		maxPageCount: 14
		pageCount: pagecount
		shadowBarButtons: true
		onNavigate: navigatePage(page)
	}
}
