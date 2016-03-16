// http://karma-runner.github.io/0.13/config/configuration-file.html
module.exports = function(config) {
  config.set({
    preprocessors: {
      '**/*.coffee': ['coffee']
    },

    coffeePreprocessor: {
      // options passed to the coffee compiler
      options: {
        bare: true,
        sourceMap: false
      },
      // transforming the filenames
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js')
      }
    },

    // make sure to include the .coffee files not the compiled .js files
    files: [
      'node_modules/jquery/dist/jquery.js',
      'node_modules/angular/angular.js',
      'node_modules/angular-mocks/angular-mocks.js',
      'node_modules/chosen-npm/public/chosen.jquery.js',

      'src/*.coffee',

      'test/helper.js',
      'test/*Spec.js'
    ],

    basePath: '../',
    frameworks: ['jasmine'],

    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: [
      // 'PhantomJS', 'Chrome', 'Firefox', 'Safari'
      'PhantomJS'
    ],

    // Which plugins to enable
    plugins: [
      'karma-phantomjs-launcher',
      // 'karma-chrome-launcher',
      // 'karma-firefox-launcher',
      // 'karma-safari-launcher',
      'karma-jasmine',
      'karma-coffee-preprocessor'
    ],
  })
}
