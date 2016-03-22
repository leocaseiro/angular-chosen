angular.module('localytics.directives', [])

angular.module('localytics.directives').directive 'chosen', ['$timeout', ($timeout) ->

  # This is stolen from Angular...
  NG_OPTIONS_REGEXP =  /^\s*([\s\S]+?)(?:\s+as\s+([\s\S]+?))?(?:\s+group\s+by\s+([\s\S]+?))?\s+for\s+(?:([\$\w][\$\w]*)|(?:\(\s*([\$\w][\$\w]*)\s*,\s*([\$\w][\$\w]*)\s*\)))\s+in\s+([\s\S]+?)(?:\s+track\s+by\s+([\s\S]+?))?$/


  # Whitelist of options that will be parsed from the element's attributes and passed into Chosen
  CHOSEN_OPTION_WHITELIST = [
    'persistentCreateOption'
    'createOptionText'
    'createOption'
    'skipNoResults'
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
    'includeGroupLabelInSelected'
    'maxShownResults'
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
  priority: 1
  link: (scope, element, attr, ngModel) ->
    scope.disabledValuesHistory = if scope.disabledValuesHistory then scope.disabledValuesHistory else []
    element = $ element # Use real JQuery if it wasn't loaded before Angular.
    element.addClass('localytics-chosen')

    # Take a hash of options from the chosen directive
    options = scope.$eval(attr.chosen) or {}

    # Options defined as attributes take precedence
    angular.forEach attr, (value, key) ->
      if key in CHOSEN_OPTION_WHITELIST

        # Observe attributes
        # Update the value in options. Set the default texts again. Update message.
        attr.$observe key, (value) ->
          options[snakeCase(key)] = if String(element.attr(attr.$attr[key])).slice(0, 2) is '{{' then value else scope.$eval(value)
          updateMessage();

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

    initOrUpdate = ->
      if chosen
        element.trigger('chosen:updated')
      else
        $timeout ->
         chosen = element.chosen(options).data('chosen')
         return
        if angular.isObject(chosen)
          defaultText = chosen.default_text

    # Use Chosen's placeholder or no results found text depending on whether there are options available
    updateMessage = ->
      if empty
        element.attr('data-placeholder', chosen.results_none_found).attr('disabled', true)
      else
        element.removeAttr('data-placeholder')
      element.trigger('chosen:updated')

    # Watch the underlying ngModel for updates and trigger an update when they occur.
    if ngModel
      origRender = ngModel.$render
      ngModel.$render = ->
        origRender()
        initOrUpdate()

      element.on 'chosen:hiding_dropdown', ->
        scope.$apply -> ngModel.$setTouched()

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
            empty = isEmpty(newVal)
            stopLoading()
            updateMessage()
        )

      scope.$on '$destroy', (event) ->
        $timeout.cancel timer if timer?
]
