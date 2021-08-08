import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["email"]

  onSuccess(event) {
    this.clearEmailField()
    let message = event.detail[0].message
    let responseMessage = document.createElement('div')
    responseMessage.classList.add('text-green-600')
    responseMessage.innerHTML = message
    this.emailTarget.replaceWith(responseMessage)
  }

  onError(event) {
    this.clearEmailField()
    let message = event.detail[0].message
    let responseMessage = document.createElement('div')
    responseMessage.classList.add('text-red-600', 'mb-0')
    responseMessage.innerHTML = message
    this.emailTarget.appendChild(responseMessage)
  }

  clearEmailField() {
    this.emailTarget.value = ''
  }
}
