import { Controller } from "stimulus";
import consumer from "channels/consumer";

export default class extends Controller {
	connect() {
		this.subscription = consumer.subscriptions.create(
			{
				channel: "ChatChannel",
				id: "Best Room",
			},
			{
				connected: this._connect.bind(this),
				disconnected: this._disconnect.bind(this),
				received: this._received.bind(this),
			}
		);
	}

	_connect() {
		console.log("connected");
	}
	_disconnect() {}
	_received() {}
}
