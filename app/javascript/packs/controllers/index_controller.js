import { Controller } from "stimulus";
import geolocation from "geolocation";

export default class extends Controller {
	connect() {
		console.log("Hello, Stimulus!", this.element);
		console.log(geolocation);
		geolocation.getCurrentPosition((err, location) => {
			if (err) {
				console.log(err);
			} else {
				this.initMap(location.coords.latitude, location.coords.longitude);
			}
		});
		this.textV = document.getElementById("map");
		this.textV.innerText = "hello from javascript";
	}
	initMap(lat, log) {
		console.log(lat);
		this.map = new google.maps.Map(document.getElementById("map"), {
			center: { lat: lat, log: log },
			zoom: 8,
		});
	}
}
