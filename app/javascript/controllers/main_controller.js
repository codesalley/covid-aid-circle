import geolocation from "geolocation";
import loadGoogleMapsApi from "load-google-maps-api";
import receiver from "../../assets/covidAid/receiver.png";
import donor from "../../assets/covidAid/donor.png";
import person from "../../assets/images/person.png";
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
		console.log(google);
		const map = new google.Map(document.getElementById("map"), {
			center: {
				lat: lat,
				lng: log,
			},
			zoom: 12,
		});
		new google.Marker({
			position: {
				lat: lat,
				lng: log,
			},
			map: map,
		});

		if (this.wrapValue.length > 0) {
			for (let i = 0; i < this.wrapValue.length; i++) {
				const user = JSON.parse(this.wrapValue[i]);
				const { lat, lng, donor } = user;
				console.log(user);

				const marker = new google.Marker({
					position: new google.LatLng(parseFloat(lat), parseFloat(lng)),
					map: map,
					title: donor ? "Donor" : "Receiver",
					icon: donor ? donor : receiver,
					collisionBehavior: google.CollisionBehavior.REQUIRED,
				});
				const userData = `
								<div class='map-info-card'>
									<img src="${person}" class="donation-map-logo rounded-circle" />
									<div class='map-in-details'>
									<p>  Donate to ${user.user} </p>
									<a id='donate' href="/donate/${user.id}" class=" donate-btn "> Donate </a>
									<a id='donate' href="/chat/${user.id}" class=" donate-chat-btn "> chat </a>
							  		</div>
				            	<div>`;

				const infowindow = new google.InfoWindow({
					content: userData,
				});
				marker.addListener("click", () => {
					infowindow.open({
						anchor: marker,
						map,
						shouldFocus: false,
					});
				});
			}
		}
	}
}
