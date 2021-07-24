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

		const form = document.querySelector(".chatform");
		const msgInput = document.querySelector(".chat-text");
		const msgDiv = document.querySelector(".m-in-chat");
		this.msgInput = document.querySelector(".chat-text");

		form.addEventListener("submit", (e) => {
			if (msgInput.value == "") {
				e.preventDefault();
				return false;
			}
			this.msgInput.value = "";
			this.scroll();
		});
	}

	scroll() {
		const msgDiv = document.querySelector(".m-in-chat");
		const style = getComputedStyle(msgDiv);
		msgDiv.scrollTop =
			msgDiv.scrollHeight +
			(parseInt(style.paddingBottom) + parseInt(style.paddingBottom)) * 2;
	}

	_connect() {
		this.scroll();
	}
	_disconnect() {}
	_received(data) {
		if (data.message) {
			this.messagesTarget.insertAdjacentHTML("beforeend", data.message);
		}
	}
}
