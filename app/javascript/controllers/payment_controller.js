import { Controller } from "stimulus";
import { countries } from "./data";
export default class extends Controller {
	static targets = ["output"];
	connect() {
		this.mainAmount = 10;
		console.log(this.data.get("amount"));

		this.setupcountries();
		this.amount = document.querySelector("#amount");
		this.d_amount = document.querySelector("#d-amount");
		this.street = document.querySelector("#street");
		this.zipcode = document.querySelector("#zipcode");
		this.cityname = document.querySelector("#cityname");
		this.state = document.querySelector("#state");
		this.cardpin = document.querySelector("#cardpin");
		this.cardDate = document.querySelector("#e-date");
		this.cardNumber = document.querySelector("#cardNumber");
		this.name = document.querySelector("#name");

		this.outputTarget.textContent = `${this.setamount}.00`;
	}
	setValue() {
		this.d_amount.innerHTML = `${this.mainAmount}`;
	}
	setupcountries() {
		const selectTag = document.querySelector("#countrySelect");
		for (let i = 0; i < countries.length; i++) {
			const option = document.createElement("option");
			option.value = countries[i].code;
			option.innerText = countries[i].name;
			selectTag.appendChild(option);
		}
	}

	requestpay() {}

	formError() {}
	minus() {
		this.setamount -= 5;
	}
	plus() {
		this.setamount = parseFloat(parseInt(this.setamount) + 5);
	}

	get setamount() {
		return this.data.get("amount");
	}
	set setamount(value) {
		this.data.set("amount", value);
		this.outputTarget.textContent = this.setamount;
	}
}
