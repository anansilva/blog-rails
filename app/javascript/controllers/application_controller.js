import { Controller } from "stimulus"
import hljs from 'highlight.js/lib/core'
import 'highlight.js/styles/gruvbox-dark.css'

 import ruby from 'highlight.js/lib/languages/ruby'
 hljs.registerLanguage('ruby', ruby);

 import erb from 'highlight.js/lib/languages/erb'
 hljs.registerLanguage('erb', erb);

 import bash from 'highlight.js/lib/languages/bash'
 hljs.registerLanguage('bash', bash);

 import javascript from 'highlight.js/lib/languages/javascript'
 hljs.registerLanguage('javascript', javascript);

export default class extends Controller {
  static targets = []

  connect() {
    document.querySelectorAll('pre').forEach((block) => {
      hljs.highlightBlock(block)
    })
  }
}
