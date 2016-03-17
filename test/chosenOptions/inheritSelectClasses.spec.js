describe('Chosen options: inherit-select-classes', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      inheritSelectClasses: true,
      'class': 'inherited-class'
    });
  });

  it('passes classes from the select tag to the chosen container', function () {
    expect(chosenSelectHelper.chosenContainer().hasClass('inherited-class')).toBeTruthy();
  });
});

