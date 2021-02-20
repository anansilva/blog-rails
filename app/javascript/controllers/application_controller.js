import { Controller } from "stimulus"
import hljs from 'highlight.js/lib/core'
import 'highlight.js/styles/atom-one-dark.css'

['javascript', 'ruby', 'erb', 'bash', 'plaintext', 'vim'].forEach((langName) => {
  const langModule = require(`highlight.js/lib/languages/${langName}`);
  hljs.registerLanguage(langName, langModule);
});

hljs.configure({
  languages: ['ruby', 'erb', 'bash', 'javascript', 'plaintext', 'vim']
});

export default class extends Controller {
  static targets = []

  connect() {
    document.querySelectorAll('pre').forEach((block) => {
      hljs.highlightBlock(block)
    })
  }
}
