const hljs = require('highlight.js');
const fs = require('fs');
const path = require('path');
const moonbit = require('../src/index.js'); // Use src directly for testing

// Register the language
if (moonbit.moonbitLanguageSupport) {
    hljs.registerLanguage('moonbit', moonbit.moonbitLanguageSupport);
} else {
    hljs.registerLanguage('moonbit', moonbit);
}

// Path to the test file
const testFile = path.join(__dirname, 'detect/moonbit/avl.mbt');
const code = fs.readFileSync(testFile, 'utf-8');

// Run auto-detection
const result = hljs.highlightAuto(code);

console.log('Detected language:', result.language);
console.log('Relevance:', result.relevance);

if (result.language === 'moonbit') {
    console.log('✅ Test Passed: MoonBit language detected correctly.');
    process.exit(0);
} else {
    console.error(`❌ Test Failed: Expected 'moonbit', but got '${result.language}'`);
    if (result.secondBest) {
        console.log(`Second best: ${result.secondBest.language} (relevance: ${result.secondBest.relevance})`);
    }
    process.exit(1);
}

