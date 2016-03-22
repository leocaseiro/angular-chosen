describe('base functionality', function() {

  var element;

  beforeEach(function() {
    $scope.currentLanguage = 'german';
    $scope.languages = ['german', 'english'];

    // Compile a piece of HTML containing the directive
    element = $compile('<select chosen ng-options="lang for lang in languages" ng-model="currentLanguage"><option></option></select>')($scope);
    $scope.$digest();
    $timeout.flush();
    element.trigger('chosen:open.chosen'); // fills dropdown (triggers chosen:showing_dropdown when finished)
  });

  it('should add chosen dropdown', function() {
    var chosenContainer = element.next();
    var chosenSelected = chosenContainer.find('.chosen-single span');
    var chosenList = chosenContainer.find('.chosen-drop ul li');

    expect(chosenSelected.text()).toBe($scope.currentLanguage);

    expect(chosenList.length).toBe(2);
    expect(chosenList.first().text()).toBe($scope.languages[0]);
    expect(chosenList.last().text()).toBe($scope.languages[1]);
  });

  it('should work when current model updates', function() {
    var chosenContainer = element.next();
    var chosenSelected = chosenContainer.find('.chosen-single span');

    expect(chosenSelected.text()).toBe('german');

    $scope.currentLanguage = 'english';
    $scope.$digest();

    expect(chosenSelected.text()).toBe('english');
  });

  it('should trigger ngChange function when selecting a chosen result', function() {
    $scope.changed = false;

    // Compile a piece of HTML containing the directive
    element = $compile('<select chosen ng-options="lang for lang in languages" ng-model="currentLanguage" ng-change="changed=true"><option></option></select>')($scope);
    $scope.$digest();
    $timeout.flush();

    element.trigger('chosen:open.chosen');

    var chosenContainer = element.next();
    var chosenSelected = chosenContainer.find('.chosen-single span');
    var chosenList = chosenContainer.find('.chosen-drop ul li');

    expect(chosenSelected.text()).toBe('german');

    chosenList.last().trigger('mouseup'); // select english = last item

    expect(chosenSelected.text()).toBe('english');
    expect($scope.changed).toBe(true);
  });

  it('should disable chosen with ngDisabled', function() {
    $scope.disabled = true;

    // Compile a piece of HTML containing the directive
    element = $compile('<select chosen ng-options="lang for lang in languages" ng-model="currentLanguage" ng-disabled="disabled"><option></option></select>')($scope);
    $scope.$digest();
    $timeout.flush();

    var chosenContainer = element.next();

    expect(chosenContainer.hasClass('chosen-disabled')).toBe(true);

    $scope.disabled = false;
    $scope.$digest();

    expect(chosenContainer.hasClass('chosen-disabled')).toBe(false);
  });


});



