describe('chosen attributes', function() {

  var element;

  it('should inherit class customclass from select', function() {
    var customClass = 'customclass';
    var chosenContainer;
    var select = function(inheritSelectClasses, customClass) {
      return '<select chosen inherit-select-classes="' + inheritSelectClasses + '" class="' + customClass + '" ng-model="currentLanguage"><option></option></select>';
    };

    //inherit-select-classes = true
    element = $compile(select(true, customClass))($scope);
    $scope.$digest();
    chosenContainer = element.next();
    expect(chosenContainer.hasClass(customClass)).toBe(true);

    //inherit-select-classes = false
    element = $compile(select(false, customClass))($scope);
    $scope.$digest();
    chosenContainer = element.next();
    expect(chosenContainer.hasClass(customClass)).toBe(false);
  });

});



