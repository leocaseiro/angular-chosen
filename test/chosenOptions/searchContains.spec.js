describe('Chosen options: search-contains', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      searchContains: true
    });

    chosenSelectHelper.searchInput().val('erma');
    chosenSelectHelper.searchInput().trigger('keyup.chosen');
  });

  it('finds a match in the search result that is not at the beginning of the option text', function () {
    expect(chosenSelectHelper.chosenResults().length).toBeTruthy();
  });
});
