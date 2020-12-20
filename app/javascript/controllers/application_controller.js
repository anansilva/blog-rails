import { Controller } from "stimulus"
import hljs from 'highlight.js'
import 'highlight.js/styles/railscasts.css'

hljs.configure({ language: ['ruby', 'erb', 'bash', 'javascript', 'css', 'sql'] })

export default class extends Controller {
  static targets = []

  connect() {
    document.querySelectorAll('pre').forEach((block) => {
      hljs.highlightBlock(block)
    })
  }
}
