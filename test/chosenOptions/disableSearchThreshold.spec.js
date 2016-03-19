describe('Chosen options: disable-search-threshold', function () {
  it('disables the search when the results are lower than the threshold', function () {
    chosenSelectHelper.compileWithAttributes({
      disableSearchThreshold: 3
    });

    expect(chosenSelectHelper.searchInput().attr('readOnly')).toBeTruthy();
  });

  it('does not disable the search when the results are higher than the threshold', function () {
    chosenSelectHelper.compileWithAttributes({
      disableSearchThreshold: 1
    });

    expect(chosenSelectHelper.searchInput().attr('readOnly')).toBeFalsy();
  });
});

