import geolocation from "geolocation";
import { Controller } from "stimulus";

export default class extends Controller {
	connect() {
		geolocation.getCurrentPosition((err, location) => {
			if (err) {
				console.log(err);
			} else {
				this.allowLocation;
				this.initMap(location.coords.latitude, location.coords.longitude);
			}
		});
	}
}
