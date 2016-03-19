describe('Chosen options: width', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      width: 250
    });
  });

  it('sets the dropdown width', function () {
    expect(chosenSelectHelper.chosenContainer().attr('style')).toBe('width: 250;');
  });
});
