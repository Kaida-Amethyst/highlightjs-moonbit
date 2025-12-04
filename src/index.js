
const moonbit = require('./languages/moonbit');

// Export the function for CommonJS/Node environments
module.exports = moonbit;

// If we are in a browser environment and hljs is available, auto-register the language.
if (typeof window !== 'undefined' && window.hljs) {
  window.hljs.registerLanguage('moonbit', moonbit);
}
