angular.module('localytics.directives', [])

angular.module('localytics.directives').directive 'chosen', ->

  # This is stolen from Angular...
  NG_OPTIONS_REGEXP = /^\s*(.*?)(?:\s+as\s+(.*?))?(?:\s+group\s+by\s+(.*))?\s+for\s+(?:([\$\w][\$\w]*)|(?:\(\s*([\$\w][\$\w]*)\s*,\s*([\$\w][\$\w]*)\s*\)))\s+in\s+(.*?)(?:\s+track\s+by\s+(.*?))?$/

  # Whitelist of options that will be parsed from the element's attributes and passed into Chosen
  CHOSEN_OPTION_WHITELIST = [
    'noResultsText'
    'allowSingleDeselect'
    'disableSearchThreshold'
    'disableSearch'
    'enableSplitWordSearch'
    'inheritSelectClasses'
    'maxSelectedOptions'
    'placeholderTextMultiple'
    'placeholderTextSingle'
    'searchContains'
    'singleBackstrokeDelete'
    'displayDisabledOptions'
    'displaySelectedOptions'
    'width'
  ]

  snakeCase = (input) -> input.replace /[A-Z]/g, ($1) -> "_#{$1.toLowerCase()}"
  isEmpty = (value) ->
    if angular.isArray(value)
      return value.length is 0
    else if angular.isObject(value)
      return false for key of value when value.hasOwnProperty(key)
    true

  chosen =
    restrict: 'A'
    require: '?ngModel'
    terminal: true
    link: (scope, element, attr, ctrl) ->

      element.addClass('localytics-chosen')

      # Take a hash of options from the chosen directive
      options = scope.$eval(attr.chosen) or {}

      # Options defined as attributes take precedence
      angular.forEach attr, (value, key) ->
        options[snakeCase(key)] = scope.$eval(value) if key in CHOSEN_OPTION_WHITELIST

      startLoading = -> element.addClass('loading').attr('disabled', true).trigger('chosen:updated')
      stopLoading = -> element.removeClass('loading').attr('disabled', false).trigger('chosen:updated')

      initialized = false
      empty = false

      initOrUpdate = ->
        if initialized
          element.trigger('chosen:updated')
        else
          element.chosen options
          initialized = true

      removeEmptyMessage = ->
        empty = false
        element.find('option.empty').remove()

      disableWithMessage = (message) ->
        empty = true
        element.empty().append("""<option selected class="empty">#{message}</option>""").attr('disabled', true).trigger('chosen:updated')

      # Watch the underlying ngModel for updates and trigger an update when they occur.
      if ctrl
        origRender = ctrl.$render
        ctrl.$render = ->
          origRender()
          initOrUpdate()

        # This is basically taken from angular ngOptions source.  ngModel watches reference, not value,
        # so when values are added or removed from array ngModels, $render won't be fired.
        if attr.multiple
          viewWatch = -> ctrl.$viewValue
          scope.$watch viewWatch, ctrl.$render, true
      # If we're not using ngModel (and therefore also not using ngOptions, which requires ngModel),
      # just initialize chosen immediately since there's no need to wait for ngOptions to render first
      else initOrUpdate()

      # Watch the disabled attribute (could be set by ngDisabled)
      attr.$observe 'disabled', (value) -> element.trigger 'chosen:updated'

      # Watch the collection in ngOptions and update chosen when it changes.  This works with promises!
      if attr.ngOptions
        match = attr.ngOptions.match(NG_OPTIONS_REGEXP)
        valuesExpr = match[7]

        # There's no way to tell if the collection is a promise since $parse hides this from us, so just
        # assume it is a promise if undefined, and show the loader
        startLoading() if angular.isUndefined(scope.$eval(valuesExpr))
        scope.$watchCollection valuesExpr, (newVal, oldVal) ->
          unless newVal is oldVal
            removeEmptyMessage() if empty
            stopLoading()
            disableWithMessage(options.no_results_text || 'No values available') if isEmpty(newVal)
