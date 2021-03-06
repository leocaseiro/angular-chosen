angular.module('localytics.directives', [])

chosenModule = angular.module('localytics.directives')

chosenModule.provider 'chosen', ->
  options = {}
  {
    setOption: (newOpts) ->
      angular.extend options, newOpts
      return
    $get: ->
      options
  }

chosenModule.directive 'chosen', ['chosen', '$timeout', '$parse', (config, $timeout, $parse) ->
  # coffeelint: disable=max_line_length
  # This is stolen from Angular...
  NG_OPTIONS_REGEXP =  /^\s*([\s\S]+?)(?:\s+as\s+([\s\S]+?))?(?:\s+group\s+by\s+([\s\S]+?))?\s+for\s+(?:([\$\w][\$\w]*)|(?:\(\s*([\$\w][\$\w]*)\s*,\s*([\$\w][\$\w]*)\s*\)))\s+in\s+([\s\S]+?)(?:\s+track\s+by\s+([\s\S]+?))?$/
  # coffeelint: enable=max_line_length

  # Whitelist of options that will be parsed from the element's attributes and passed into Chosen
  #
  # Can be updated by running the following script on the options page
  # https://harvesthq.github.io/chosen/options.html
  #
  # Array.from(
  #   document.querySelectorAll('table:first-of-type tr td:first-of-type')
  # )
  # .map(node => node.textContent)
  # .map(option => option.replace(/_(\w)/g, (_, letter) => letter.toUpperCase()))
  #
  CHOSEN_OPTION_WHITELIST = [
    'allowSingleDeselect'
    'disableSearch'
    'disableSearchThreshold'
    'enableSplitWordSearch'
    'inheritSelectClasses'
    'maxSelectedOptions'
    'noResultsText'
    'placeholderTextMultiple'
    'placeholderTextSingle'
    'searchContains'
    'groupSearch'
    'singleBackstrokeDelete'
    'width'
    'displayDisabledOptions'
    'displaySelectedOptions'
    'includeGroupLabelInSelected'
    'maxShownResults'
    'caseSensitiveSearch'
    'hideResultsOnSelect'
    'rtl'
  ]

  snakeCase = (input) -> input.replace /[A-Z]/g, ($1) -> "_#{$1.toLowerCase()}"
  isEmpty = (value) ->
    if angular.isArray(value)
      return value.length is 0
    else if angular.isObject(value)
      return false for key of value when value.hasOwnProperty(key)
    true

  restrict: 'A'
  require: ['select', '?ngModel']
  priority: 1
  link: (scope, element, attr, ctrls) ->
    scope.disabledValuesHistory = if scope.disabledValuesHistory then scope.disabledValuesHistory else []
    element = $ element # Use real JQuery if it wasn't loaded before Angular.
    element.addClass('localytics-chosen')

    ngSelect = ctrls[0]
    ngModel = ctrls[1]

    match = attr.ngOptions && attr.ngOptions.match(NG_OPTIONS_REGEXP)
    valuesExpr = match && $parse(match[7])
    trackBy = match && match[8]

    # Take a hash of options from the chosen directive
    directiveOptions = scope.$eval(attr.chosen) or {}

    # Clone options from configProvider
    options = angular.copy(config)

    # Merge options from directive with options from configProvider
    angular.extend(options, directiveOptions)

    # Options defined as attributes take precedence
    angular.forEach attr, (value, key) ->
      if key in CHOSEN_OPTION_WHITELIST

        # Observe attributes
        # Update the value in options. Set the default texts again. Update message.
        attr.$observe key, (value) ->
          prefix = String(element.attr(attr.$attr[key])).slice(0, 2)
          options[snakeCase(key)] = if prefix is '{{' then value else scope.$eval(value)
          disableIfEmpty()

    startLoading = -> element.addClass('loading').attr('disabled', true).trigger('chosen:updated')

    stopLoading = ->
      element.removeClass('loading')
      if angular.isDefined attr.disabled
        element.attr 'disabled', attr.disabled
      else
        element.attr 'disabled', false
      element.trigger('chosen:updated')

    chosen = null
    empty = false

    # async initialize chosen if it's not initialized yet
    initIfNotInitialized = ->
      if !chosen
        scope.$evalAsync ->
          if !chosen then chosen = element.chosen(options).data('chosen')

    # Use Chosen's placeholder or no results found text depending on whether there are options available
    disableIfEmpty = ->
      if chosen && empty
        element.attr('disabled', true)
      element.trigger('chosen:updated')

    # Watch the underlying ngModel for updates and trigger an update when they occur.
    if ngModel
      $render = ngModel.$render
      ngModel.$render = ->
        initIfNotInitialized()

        # We need to try and detect if the select value was changed from outside of chosen
        try previousValue = ngSelect.readValue()
        $render()
        try nextValue = ngSelect.readValue()

        isPrimitive = !trackBy && !attr.multiple
        valueChanged = if isPrimitive
        then previousValue != nextValue
        else !angular.equals(previousValue, nextValue)

        # If it was changed, then we trigger a chosen re-render
        if (valueChanged)
          element.trigger('chosen:updated')

      element.on 'chosen:hiding_dropdown', ->
        scope.$applyAsync -> ngModel.$setTouched()

      # This is basically taken from angular ngOptions source.  ngModel watches reference, not value,
      # so when values are added or removed from array ngModels, $render won't be fired.
      if attr.multiple
        viewWatch = -> ngModel.$viewValue
        scope.$watch viewWatch, ngModel.$render, true
    else
      initIfNotInitialized()

    # Watch the disabled attribute (could be set by ngDisabled)
    attr.$observe 'disabled', -> element.trigger('chosen:updated')

    # Watch the collection in ngOptions and update chosen when it changes.  This works with promises!
    # ngOptions doesn't do anything unless there is an ngModel, so neither do we.
    if attr.ngOptions and ngModel
      timer = null
      scope.$watchCollection valuesExpr, (newVal, oldVal) ->
        # Defer execution until DOM is loaded
        timer = $timeout(->
          if angular.isUndefined(newVal)
            startLoading()
          else
            empty = isEmpty(newVal)
            stopLoading()
            disableIfEmpty()
        )

      scope.$on '$destroy', (event) ->
        $timeout.cancel timer if timer?
]
