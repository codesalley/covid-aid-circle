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
		const sendBtn = document.querySelector(".send-btn");
		this.msgInput = document.querySelector(".chat-text");

		form.addEventListener("submit", (e) => {
			if (msgInput.value == "") {
				e.preventDefault();
				return false;
			}
			sendBtn.disabled = true;

			setTimeout(() => {
				this.msgInput.value = "";
				// sendBtn.disabled = false;
				this.scroll();
			}, 400);
		});
	}

	disconnect() {
		consumer.subscriptions.remove(this.subscription);
	}

	scroll() {
		const msgDiv = document.querySelector(".m-in-chat");
		msgDiv.scrollTop = msgDiv.scrollHeight;
	}

	_connect() {
		this.scroll();
	}
	_disconnect() {}
	_received(data) {
		console.log(data);
		if (data.message) {
			this.messagesTarget.insertAdjacentHTML("beforeend", data.message);
		}
	}
}
