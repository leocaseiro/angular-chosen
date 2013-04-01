angular.module('chosenExampleApp', ['localytics.directives'])

.controller 'IndexCtrl', ['$scope', '$q', '$timeout', ($scope, $q, $timeout) ->

  $scope.optionsFromQuery = do ->
    deferred = $q.defer()
    result = ['grooo', 'wowowowow', 'lakakalakakl', 'yadayada', 'insight', 'delve', 'synergy']
    fn = -> deferred.resolve(result)
    $timeout fn, 3000
    deferred.promise

  $scope.directiveOptions =
    no_results_text: "SO SORRY"

]