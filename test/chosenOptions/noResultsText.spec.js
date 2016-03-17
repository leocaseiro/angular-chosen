describe('Chosen options: no-results-text', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      noResultsText: "'testing no results text'"
    });

    chosenSelectHelper.searchInput().val('foo');
    chosenSelectHelper.searchInput().trigger('keyup.chosen');
  });

  it('displays the specified message when a search returns no results', function () {
    expect(chosenSelectHelper.chosenResults().html()).toMatch('testing no results text');
  });
});
