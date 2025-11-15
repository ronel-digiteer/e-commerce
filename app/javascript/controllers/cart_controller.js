import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity", "total"]

  updateTotal() {
    let total = 0;
    this.quantityTargets.forEach((el) => {
      const price = parseFloat(el.dataset.price);
      const qty = parseInt(el.value);
      total += price * qty;
    });
    this.totalTarget.textContent = total.toFixed(2);
  }

  connect() {
    this.updateTotal();
  }
}