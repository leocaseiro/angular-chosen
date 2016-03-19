describe('Chosen options: allow-single-deselect', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      allowSingleDeselect: true
    });
  });

  it('removes the model value when deselected', function () {
    var removeButton = chosenSelectHelper.chosenContainer().find('abbr.search-choice-close');

    removeButton.trigger('mouseup.chosen');

    expect($scope.currentLanguage).toBeNull();
  });
});
