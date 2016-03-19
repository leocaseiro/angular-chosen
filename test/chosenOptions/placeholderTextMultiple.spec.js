describe('Chosen options: placeholder-text-multiple', function () {
  beforeEach(function () {
    $scope.emptyModel = [];

    chosenSelectHelper.compileWithAttributes({
      multiple: true,
      placeholderTextMultiple: "'testing multi placeholder text'",
      ngModel: 'emptyModel'
    });
  });

  it('shows the specified placeholder text for a multi-select chosen tag', function () {
    expect(chosenSelectHelper.chosenContainer().find('.search-field input').attr('value')).toMatch('testing multi placeholder text');
  });
});

