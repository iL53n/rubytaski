module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader',
    // options: {
    //   loaders: {
    //     scss: 'vue-style-loader!css-loader!sass-loader', // <style lang="scss">
    //   },
    // },
  }]
}

// const { VueLoaderPlugin } = require('vue-loader')

// module.exports = {
//   module: {
//     rules: [
//       {
//         test: /\.vue$/,
//         loader: 'vue-loader'
//       },
//       {
//         resourceQuery: /blockType=i18n/,
//         type: 'javascript/auto',
//         loader: '@kazupon/vue-i18n-loader'
//       }
//     ]
//   },
//   plugins: [
//     new VueLoaderPlugin()
//   ]
// }