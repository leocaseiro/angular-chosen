describe('Chosen options: max-shown-results', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      maxShownResults: 1
    });

    chosenSelectHelper.selectTag.trigger('chosen:open.chosen');
    chosenSelectHelper.chosenResults().last().trigger('mouseup.chosen');
  });

  it('displays only the maximum number of results specified', function () {
    expect(chosenSelectHelper.chosenResults().length).toBe(1);
  });
});

