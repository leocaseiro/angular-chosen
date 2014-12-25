angular.module('localytics.directives', [])

angular.module('localytics.directives').directive 'chosen', ['$timeout', ($timeout) ->

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

  restrict: 'A'
  require: '?ngModel'
  terminal: true
  link: (scope, element, attr, ngModel) ->

    element.addClass('localytics-chosen')

    # Take a hash of options from the chosen directive
    options = scope.$eval(attr.chosen) or {}

    # Options defined as attributes take precedence
    angular.forEach attr, (value, key) ->
      options[snakeCase(key)] = scope.$eval(value) if key in CHOSEN_OPTION_WHITELIST

    startLoading = -> element.addClass('loading').attr('disabled', true).trigger('chosen:updated')
    stopLoading = -> element.removeClass('loading').attr('disabled', false).trigger('chosen:updated')

    chosen = null
    defaultText = null
    empty = false

    initOrUpdate = ->
      if chosen
        element.trigger('chosen:updated')
      else
        chosen = element.chosen(options).data('chosen')
        defaultText = chosen.default_text

    # Use Chosen's placeholder or no results found text depending on whether there are options available
    removeEmptyMessage = ->
      empty = false
      element.attr('data-placeholder', defaultText)

    disableWithMessage = ->
      empty = true
      element.attr('data-placeholder', chosen.results_none_found).attr('disabled', true).trigger('chosen:updated')

    # Watch the underlying ngModel for updates and trigger an update when they occur.
    if ngModel
      origRender = ngModel.$render
      ngModel.$render = ->
        origRender()
        initOrUpdate()

      # This is basically taken from angular ngOptions source.  ngModel watches reference, not value,
      # so when values are added or removed from array ngModels, $render won't be fired.
      if attr.multiple
        viewWatch = -> ngModel.$viewValue
        scope.$watch viewWatch, ngModel.$render, true
    # If we're not using ngModel (and therefore also not using ngOptions, which requires ngModel),
    # just initialize chosen immediately since there's no need to wait for ngOptions to render first
    else initOrUpdate()

    # Watch the disabled attribute (could be set by ngDisabled)
    attr.$observe 'disabled', -> element.trigger('chosen:updated')

    # Watch the collection in ngOptions and update chosen when it changes.  This works with promises!
    # ngOptions doesn't do anything unless there is an ngModel, so neither do we.
    if attr.ngOptions and ngModel
      match = attr.ngOptions.match(NG_OPTIONS_REGEXP)
      valuesExpr = match[7]

      scope.$watchCollection valuesExpr, (newVal, oldVal) ->
        # Defer execution until DOM is loaded
        timer = $timeout(->
          if angular.isUndefined(newVal)
            startLoading()
          else
            removeEmptyMessage() if empty
            stopLoading()
            disableWithMessage() if isEmpty(newVal)
        )

      scope.$on '$destroy', (event) ->
        $timeout.cancel timer if timer?
]