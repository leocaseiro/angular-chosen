beforeEach(function() {
  angular.module('testApp', ['localytics.directives']);
  angular.mock.module('testApp');
});

var $scope;
var $timeout;
var $compile;

/**
 * Assigns $scope, $timeout and $compile, these will be used in every test.
 */
beforeEach(inject(function(_$rootScope_, _$timeout_, _$compile_) {
  $scope = _$rootScope_.$new();
  $timeout = _$timeout_;
  $compile = _$compile_;
}));
