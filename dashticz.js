var tileCategories = {
	solar				: {weight: 50,   instance: undefined, name: qsTr("Solar")},
	power				: {weight: 100,  instance: undefined, name: qsTr("Power")},
	gas					: {weight: 200,  instance: undefined, name: qsTr("Gas")},
	heat				: {weight: 200,  instance: undefined, name: qsTr("Heat")},
	heating				: {weight: 240,  instance: undefined, name: qsTr("Heating")},
	heatRecovery		: {weight: 250,  instance: undefined, name: qsTr("Heat\nRecovery")},
	util				: {weight: 300,  instance: undefined, name: qsTr("Utility")},
	payment				: {weight: 400,  instance: undefined, name: qsTr("Payment")},
	message				: {weight: 500,  instance: undefined, name: qsTr("Message")},
	stats				: {weight: 600,  instance: undefined, name: qsTr("Stats")},
	thermostat			: {weight: 700,  instance: undefined, name: qsTr("Thermostat")},
	statusUsage			: {weight: 800,  instance: undefined, name: qsTr("Status Usage")},
	benchmark			: {weight: 900,  instance: undefined, name: qsTr("Benchmark")},
	benchmarkFriends	: {weight: 1000, instance: undefined, name: qsTr("Friends")},
	smartplugs			: {weight: 1100, instance: undefined, name: qsTr("Smart plugs")},
	general				: {weight: 1200, instance: undefined, name: qsTr("General")}
}

function jsTest() {
	return true;
}
