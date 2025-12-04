const path = require('path');

module.exports = {
  mode: 'production',
  entry: './src/index.js',
  output: {
    filename: 'moonbit.min.js',
    path: path.resolve(__dirname, 'dist'),
    library: {
      name: 'hljsDefineMoonBit',
      type: 'umd',
      export: 'default' // Export the default export (the function) directly
    },
    globalObject: 'this'
  },
};
