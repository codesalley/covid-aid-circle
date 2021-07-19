import { Controller } from "stimulus";
import geolocation from "geolocation";
import loadGoogleMapsApi from "load-google-maps-api";
import receiver from "../../../assets/covidAid/receiver.png";
import donor from "../../../assets/covidAid/donor.png";

export default class extends Controller {
	static values = { long: Number, lang: String };
	connect() {
		console.log(this.longValue);
		console.log(this.langValue);

		geolocation.getCurrentPosition((err, location) => {
			if (err) {
				console.log(err);
			} else {
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
	initMap(lat, log) {
		const textV = document.getElementById("map");
		console.log(textV);

		loadGoogleMapsApi({ key: process.env["google_api"] })
			.then((googlemap) => {
				const map = new googlemap.Map(document.getElementById("map"), {
					center: {
						lat: lat,
						lng: log,
					},
					zoom: 12,
				});
				new googlemap.Marker({
					position: {
						lat: lat,
						lng: log,
					},
					map: map,
					title: "Receiver",
					icon: receiver,
				});
			})
			.catch((e) => {
				console.log(e);
			});
	}
}
