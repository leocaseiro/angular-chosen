angular.module('localytics.directives', [])

angular.module('localytics.directives').directive 'chosen', ['$timeout', ($timeout) ->
  
  # This is stolen from Angular...
  NG_OPTIONS_REGEXP = /^\s*(.*?)(?:\s+as\s+(.*?))?(?:\s+group\s+by\s+(.*))?\s+for\s+(?:([\$\w][\$\w\d]*)|(?:\(\s*([\$\w][\$\w\d]*)\s*,\s*([\$\w][\$\w\d]*)\s*\)))\s+in\s+(.*)$/

  # Whitelist of options that will be parsed from the element's attributes and passed into Chosen
  CHOSEN_OPTION_WHITELIST = ['noResultsText', 'allowSingleDeselect', 'disableSearchThreshold', 'disableSearch']

  snakeCase = (input) -> input.replace /[A-Z]/g, ($1) -> "_#{$1.toLowerCase()}"

  chosen =
    restrict: 'A'
    require: '?ngModel'
    link: (scope, element, attr, ngModel) ->

      # Take a hash of options from the chosen directive
      options = scope.$eval 'chosen' or {}

      # Options defined as attributes take precedence
      angular.forEach attr, (value, key) ->
        options[snakeCase(key)] = scope.$eval(value) if key in CHOSEN_OPTION_WHITELIST

      # Init chosen on the next loop so ng-options can populate the select
      $timeout -> element.chosen options

      # Watch the collection in ngOptions and update chosen when it changes.  This works with promises!
      if attr.ngOptions
        match = attr.ngOptions.match(NG_OPTIONS_REGEXP)
        valuesExpr = match[7]
        scope.$watch valuesExpr, -> element.trigger('liszt:updated')
]
