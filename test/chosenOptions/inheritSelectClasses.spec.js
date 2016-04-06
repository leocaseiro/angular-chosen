describe('Chosen options: inherit-select-classes', function () {

  it('passes classes from the select tag to the chosen container', function () {
    chosenSelectHelper.compileWithAttributes({
      inheritSelectClasses: true,
      'class': 'inherited-class'
    });

    expect(chosenSelectHelper.chosenContainer().hasClass('inherited-class')).toBeTruthy();
  });

  it('dont pass classes from the select tag to the chosen container', function () {
    chosenSelectHelper.compileWithAttributes({
      inheritSelectClasses: false,
      'class': 'inherited-class'
    });

    expect(chosenSelectHelper.chosenContainer().hasClass('inherited-class')).toBeFalsy();
  });
});

