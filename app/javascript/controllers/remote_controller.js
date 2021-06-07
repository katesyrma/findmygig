import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [ 'wrapper', 'container', 'content', 'background']

  initialize() {
    this.url = this.data.get('url')
  }

  view(e) {
    e.preventDefault()
    document.body.style.position = 'fixed';
    document.body.style.top = `-${window.scrollY}px`;
    if (e.target !== this.wrapperTarget &&
      !this.wrapperTarget.contains(e.target)) return

    this.getContent(this.url)
    this.wrapperTarget.insertAdjacentHTML('afterbegin', this.template())
  }

  close(e) {
    e.preventDefault()
    document.body.style.position = '';
    document.body.style.top = '';
    if (this.hasContainerTarget) { this.containerTarget.remove() }
  }

closeBackground(e) {
  if (e.target === this.backgroundTarget) { this.close(e) }
}

closeWithKeyboard(e) {
  if (e.keyCode === 27) {
    this.close(e)
  }
}

getContent(url) {
  fetch(url).
  then(response => {
    if (response.ok) {
      return response.text()
    }
  })
  .then(html => {
    this.contentTarget.innerHTML = html
  })
}



template() {
  return `
  <div data-target='remote.container'>
    <div class='modal-wrapper' data-target='remote.background' data-action='click->remote#closeBackground'>
      <div class='modal-content'>
      <button data-action='click->remote#close' class='close-button'>Close</button>
      <div data-target='remote.content' >
      </div>
      </div>
    </div>
  </div>
  `
}
}
