import geolocation from "geolocation";
import loadGoogleMapsApi from "load-google-maps-api";
import receiver from "../../assets/covidAid/receiver.png";
import donor from "../../assets/covidAid/donor.png";
import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["output"];
	static values = { wrap: Array };

	connect() {
		console.log();
		this.allowLocation = false;
		geolocation.getCurrentPosition((err, location) => {
			if (err) {
				console.log(err);
			} else {
				this.allowLocation;
				this.initMap(location.coords.latitude, location.coords.longitude);
			}
		});
		geolocation.Watcher;
		geolocation.addListener("change", () => {
			geolocation.getCurrentPosition((err, location) => {
				if (err) {
					console.log(err);
				} else {
					this.initMap(location.coords.latitude, location.coords.longitude);
				}
			});
		});
	}
	donate() {
		console.log("donate");
	}
	initMap(lat, log) {
		loadGoogleMapsApi({ key: process.env["google_api"] })
			.then((googlemap) => {
				var directionsService = new google.maps.DirectionsService();
				var directionsDisplay = new google.maps.DirectionsRenderer();
				const map = new googlemap.Map(document.getElementById("map"), {
					center: {
						lat: lat,
						lng: log,
					},
					zoom: 12,
				});
				directionsDisplay.setMap(map);
				new googlemap.Marker({
					position: {
						lat: lat,
						lng: log,
					},
					map: map,
					collisionBehavior:
						google.maps.CollisionBehavior.REQUIRED_AND_HIDES_OPTIONAL,
				});
				if (this.wrapValue.length > 0) {
					this.wrapValue.map((loc) => {
						const user = JSON.parse(loc);
						const userData = `<div> 
                              Donate to ${user.user}
                              <button id='donate' onclick="this.donate" class="btn donate-btn btn-outline-primary"> Donate </button>
                              <div>`;
						const infowindow = new google.maps.InfoWindow({
							content: userData,
						});
						const marker = new googlemap.Marker({
							position: {
								lat: user.lat,
								lng: user.lng,
							},
							map: map,
							title: user.donor ? "Donor" : "Receiver",
							icon: user.donor ? donor : receiver,
							collisionBehavior:
								google.maps.CollisionBehavior.REQUIRED_AND_HIDES_OPTIONAL,
						});
						marker.addListener("click", () => {
							infowindow.open({
								anchor: marker,
								map,
								shouldFocus: false,
							});
							const donateBtn = document.querySelector(".donate-btn");
							console.log(document.getElementById("donate"));
							donateBtn.addListener("click", () => {
								console.log("map");
							});
						});
					});
				}
			})
			.catch((e) => {
				console.log(e);
			});
	}
}
