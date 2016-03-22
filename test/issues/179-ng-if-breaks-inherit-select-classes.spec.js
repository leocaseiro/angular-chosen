describe('#179 inherit-select-classes inside ng-if', function () {
  
  it('passes classes from the select tag to the chosen container inside ng-if', function () {
    var element;
    var customClass = 'customclass';
    var chosenContainer;

    $scope.test = true;

    var select = function(inheritSelectClasses, customClass) {
      return '<main><div ng-if="test">{{test}}<select chosen inherit-select-classes="' + inheritSelectClasses + '" class="' + customClass + '" ng-model="currentLanguage"><option></option></select></div></main>';
    };

    //inherit-select-classes = true
    element = $compile(select(true, customClass))($scope);
    $scope.$digest();
    chosenContainer = element.find('.localytics-directive').next();
    console.log('chosenContainer', element);
    expect(chosenContainer.hasClass(customClass)).toBe(true);
  });

});