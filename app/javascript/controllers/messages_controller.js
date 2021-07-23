import { Controller } from "stimulus";
import consumer from "channels/consumer";

export default class extends Controller {
	static targets = ["messages"];
	connect() {
		this.subscription = consumer.subscriptions.create(
			{
				channel: "ChatChannel",
				id: this.data.get("id"),
			},
			{
				connected: this._connect.bind(this),
				disconnected: this._disconnect.bind(this),
				received: this._received.bind(this),
			}
		);
		console.log();
	}

	_connect() {
		console.log("connected");
		console.log(this.subscription);
	}
	_disconnect() {
		console.log("diconn");
	}
	_received(data) {
		console.log("recired");
		console.log(data);
		if (data.message) {
			this.messagesTarget.insertAdjacentHTML("beforeend", data.message);
		}
	}
}
