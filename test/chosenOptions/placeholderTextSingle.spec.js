describe('Chosen options: placeholder-text-single', function () {
  beforeEach(function () {
    chosenSelectHelper.compileWithAttributes({
      placeholderTextSingle: "'testing single placeholder text'",
      ngModel: 'emptyModel'
    });
  });

  it('shows the specified placeholder text for a single-select chosen tag', function () {
    expect(chosenSelectHelper.chosenContainer().find('.chosen-default span').text()).toMatch('testing single placeholder text');
  });
});
