import geolocation from "geolocation";
import loadGoogleMapsApi from "load-google-maps-api";
import receiver from "../../assets/covidAid/receiver.png";
import donor from "../../assets/covidAid/donor.png";
import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["output"];
	static values = { wrap: Array };

	connect() {
		this.allowLocation = false;
		geolocation.getCurrentPosition((err, location) => {
			if (err) {
				console.log(err);
			} else {
				this.allowLocation;
				this._initMap(location.coords.latitude, location.coords.longitude);
			}
		});
		geolocation.Watcher;
		geolocation.addListener("change", () => {
			geolocation.getCurrentPosition((err, location) => {
				if (err) {
					console.log(err);
				} else {
					this._initMap(location.coords.latitude, location.coords.longitude);
				}
			});
		});
	}
	donate() {
		console.log("donate");
	}
	async _initMap(lat, log) {
		const google = await loadGoogleMapsApi({
			key: process.env["google_api"],
			client: process.env["google_api"],
		});
		const map = new googlemap.Map(document.getElementById("map"), {
			center: {
				lat: lat,
				lng: log,
			},
			zoom: 12,
		});
		console.log(map);
		console.log(google);

		// loadGoogleMapsApi({
		// 	key: process.env["google_api"],
		// 	client: process.env["google_api"],
		// })
		// 	.then((googlemap) => {
		// 		console.log(googlemap);
		// 		const map = new googlemap.Map(document.getElementById("map"), {
		// 			center: {
		// 				lat: lat,
		// 				lng: log,
		// 			},
		// 			zoom: 12,
		// 		});

		// 		new googlemap.Marker({
		// 			position: {
		// 				lat: lat,
		// 				lng: log,
		// 			},
		// 			map:  map,
		// 		});
		// 		const user = JSON.parse(this.wrapValue[1]);
		// 		new googlemap.Marker({
		// 			position: {
		// 				lat: lat,
		// 				lng: log,
		// 			},
		// 			map: map,
		// 		});
		// 		new googlemap.Marker({
		// 			position: {
		// 				lat: parseFloat(user.lat),
		// 				lng: parseFloat(user.lng),
		// 			},
		// 			map: map,
		// 			zIndex: 2,
		// 			title: user.donor ? "Donor" : "Receiver",
		// 			icon: user.donor ? donor : receiver,
		// 			collisionBehavior: google.maps.CollisionBehavior.REQUIRED,
		// 		});
		// if (this.wrapValue.length > 0) {
		// 	console.log(this.wrapValue.length);
		// 	this.wrapValue.map((loc, i) => {
		// 		const user = JSON.parse(loc);
		// 		console.table("lat", user.lat);
		// 		const userData = `<div>
		//               Donate to ${user.user}
		//               <a id='donate' href="/donate/${user.id}" class="btn donate-btn btn-outline-primary"> Donate </a>
		//               <a id='donate' href="/chat/${user.id}" class="btn donate-btn btn-outline-primary"> chat </a>

		//               <div>`;
		// 		const infowindow = new google.maps.InfoWindow({
		// 			content: userData,
		// 		});
		// 		const marker = new googlemap.Marker({
		// 			position: {
		// 				lat: parseFloat(user.lat),
		// 				lng: parseFloat(user.lng),
		// 			},
		// 			map: map,
		// 			zIndex: i,
		// 			title: user.donor ? "Donor" : "Receiver",
		// 			icon: user.donor ? donor : receiver,
		// 			collisionBehavior: google.maps.CollisionBehavior.REQUIRED,
		// 		});
		// 		marker.addListener("click", () => {
		// 			infowindow.open({
		// 				anchor: marker,
		// 				map,
		// 				shouldFocus: false,
		// 			});
		// 			const donateBtn = document.querySelector(".donate-btn");
		// 			console.log(document.getElementById("donate"));
		// 			donateBtn.addListener("click", () => {
		// 				console.log("map");
		// 			});
		// 		});
		// 	});
		// }
		// })
		// .catch((e) => {
		// 	console.log(e);
		// });
	}
}
