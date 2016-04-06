angular.module('chosenSelectHelper', [])
.service('chosenSelectHelper', ['$filter', function ($filter) {
  return {
    compileWithAttributes: function (attributes) {
      var attributes = attributes || {};

      if (!attributes['ngModel']) {
        $scope.currentLanguage = 'german';
        attributes['ngModel'] = 'currentLanguage';
      }

      if (!attributes['ngOptions']) {
        $scope.languages = ['german', 'english'];
        attributes['ngOptions'] = 'lang for lang in languages';
      }

      for (attrName in attributes) {
        this.selectTag.attr($filter('caseConvert')(attrName, '-'), attributes[attrName]);
      }

      $compile(this.selectTag)($scope);
      $scope.$digest();
      $timeout.flush();
    },

    selectTag: angular.element('<select chosen><option value=""></option></select>'),

    chosenContainer: function () {
      return this.selectTag.next();
    },

    chosenResults: function () {
      return this.chosenContainer().find('.chosen-results li');
    },

    searchInput: function () {
      return this.chosenContainer().find('.chosen-search input');
    }
  };
}]);
