import { Controller } from "stimulus"


import hljs from 'highlight.js/lib/core'
import 'highlight.js/styles/gruvbox-dark.css'

['javascript', 'ruby', 'erb', 'bash'].forEach((langName) => {
  const langModule = require(`highlight.js/lib/languages/${langName}`);
  hljs.registerLanguage(langName, langModule);
});

hljs.configure({
  languages: ['ruby', 'erb', 'bash', 'javascript']
});

export default class extends Controller {
  static targets = []

  connect() {
    document.querySelectorAll('pre code').forEach((block) => {
      hljs.highlightBlock(block)
    })
  }
}
