describe('form validations', function() {

  var element, ngModel;

  beforeEach(function() {
    $scope.currentLanguage = null;
    $scope.languages = ['german', 'english'];

    // Compile a piece of HTML containing the directive
    var form = $compile('<form name="form"><select chosen ng-options="lang for lang in languages" ng-model="currentLanguage" name="language" required><option></option></select></form>')($scope);
    element = form.find('select');
    ngModel = $scope.form.language;

    $scope.$digest();
  });

  it('should work with required form validation', function() {
    expect(ngModel.$valid).toBe(false);
    expect(ngModel.$error.required).toBe(true);

    $scope.currentLanguage = 'german';
    $scope.$digest();

    expect(ngModel.$valid).toBe(true);
  });

  it('should set $touched of ngModel to true (for e.g. form validation)', function() {
    expect(ngModel.$touched).toBe(false);

    element.trigger('chosen:open.chosen');
    $scope.$digest();

    element.trigger('chosen:hiding_dropdown');
    $scope.$digest();

    expect(ngModel.$touched).toBe(true);
  });

});



