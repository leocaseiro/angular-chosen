describe('Chosen options: disable-search', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      disableSearch: true
    });
  });

  it('hides the search input', function () {
    expect(chosenSelectHelper.searchInput().attr('readOnly')).toBeTruthy();
  });
});

