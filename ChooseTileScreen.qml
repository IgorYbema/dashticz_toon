import QtQuick 1.1

import qb.base 1.0;
import qb.components 1.0;

// Imported
import "dashticz.js" as DashticzJS;

// Screen that allows user to select tiles that will be placed on home screen
Screen {
	id: chooseTileScreen
	screenTitle: "Kies tegel"

	property Util util: Util{}

	property int tilePage: 0;
	property int tilePos: 0;
	property url thumbnailCategoryUrl: "ThumbnailCategory.qml"

	function init(app) {
		this.app = app;
	}

	/**
	*	Insert thumbnail into assigned category and create category container if needed
	**/
	function createThumbnail(widgetInfo) {
		var thumbCategory = widgetInfo.args.thumbCategory;
		// Get category type object from JS file
		var category = DashticzJS.tileCategories[thumbCategory];
		var newCategory = false;

		if (category) {
			var categoryObj;

			// If no instance exist create one and place on last page
			if (category.instance) {
				// Get instance of given category
				categoryObj = category.instance;
			} else {
				categoryObj = util.loadComponent(thumbnailCategoryUrl,
												 thumbnailContainer,
												 {type:thumbCategory, weight:category.weight, labelText:category.name, container: thumbnailContainerParent, app:app});
				category.instance = categoryObj;
				util.insertItem(categoryObj, thumbnailContainer, "weight");
			}
		} else {
			console.log("There is no category of that type!");
			return;
		}

		if (!categoryObj.addNewThumbnail(widgetInfo)) {
			console.log("Failed to create thumbnail!");
			return;
		}
	}

	/**
	*	Finds thumbnail in thumbnail category and destroys it when found.
	*	@param widgetInfo The widgetInfo of the thumbnail to be removed. Contains uid and category name
	**/
	function removeThumbnail(widgetInfo) {
		var thumbCategory = widgetInfo.args.thumbCategory;
		// Get category type object from JS file
		var category = DashticzJS.tileCategories[thumbCategory];
		// category can range over several pages
		if (category.instance.containsThumbnail(widgetInfo.uid)) {
			var categoryObj = category.instance;
			categoryObj.removeThumbnail(widgetInfo.uid);

			// remove category if it contains no widgets
			if (categoryObj.thumbnailContainerChildren.length === 0) {
				categoryObj.visible = false;
				categoryObj.parent = null;
				categoryObj.destroy();
				category.instance = undefined;
			}
		}
	}

	onShown: {
		widgetNavBar.navigateBtn(0);
	}

	UnFlickable {
		id: thumbnailContainerParent
		contentHeight: childrenRect.height
		// Height is related to ThumbnailCategory: each screen consist of 3 category rows.
		height: Math.round((64 + 54) ) * 3
		anchors {
			left: parent.left
			leftMargin: 60
			right: parent.right
			rightMargin: 40
			top: parent.top
			topMargin: 12
		}
		clip: true

		Column {
			id: thumbnailContainer
		}

		function navigatePage(page) {
			if (page >= 0)
				contentY = page * height;
		}

	}

	DottedSelector {
		id: widgetNavBar
		width: 488
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 0
		opacity: colors.opaqueOnActive
		pageCount: Math.ceil(thumbnailContainerParent.contentHeight / thumbnailContainerParent.height)
		shadowBarButtons: true
		onNavigate: thumbnailContainerParent.navigatePage(page)
	}
}
