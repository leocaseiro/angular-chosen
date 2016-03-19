angular.module('caseConvertFilter', [])
.filter('caseConvert', function () {
  var SNAKE_CASE_REGEXP = /[A-Z]/g;

  return function (name, separator) {
    var separator = separator || '_';

    return name.replace(SNAKE_CASE_REGEXP, function (letter, pos) {
      return (pos ? separator : '') + letter.toLowerCase();
    });
  };
});
