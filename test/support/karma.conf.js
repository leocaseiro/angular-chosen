'use strict';

module.exports = function(config) {
  config.set({
    basePath: '../../',

    frameworks: [
      'jasmine',
      'jasmine-matchers'
    ],

    files: [
      'node_modules/jquery/dist/jquery.js',
      'node_modules/chosen-npm/public/chosen.jquery.js',
      'node_modules/angular/angular.js',
      'node_modules/angular-mocks/angular-mocks.js',
      'src/**/*.coffee',
      'test/support/*.js',
      'test/**/*.spec.js'
    ],

    preprocessors: {
      'src/**/*.coffee': ['coffee']
    },

    reporters: ['mocha'],

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
      'karma-mocha-reporter',
      'karma-phantomjs-launcher',
      // 'karma-chrome-launcher',
      // 'karma-firefox-launcher',
      // 'karma-safari-launcher',
      'karma-jasmine',
      'karma-jasmine-matchers',
      'karma-coffee-preprocessor'
    ],

    singleRun: true
  });
};
