angular.module('chosenExampleApp', ['localytics.directives'])

.config(['$parseProvider', ($parseProvider) ->
  $parseProvider.unwrapPromises(true)
])

.controller('IndexCtrl', ['$scope', '$q', '$timeout', ($scope, $q, $timeout) ->

  simulateAjax = (result) ->
    deferred = $q.defer()
    fn = -> deferred.resolve(result)
    $timeout fn, 3000
    deferred.promise

  simulateAjax(['grooo', 'wowowowow', 'lakakalakakl', 'yadayada', 'insight', 'delve', 'synergy']).then (result) ->
    $scope.optionsFromQuery = result

  $scope.optionsFromQueryAsHash = do ->
    result =
      win: "Brilliant Escape"
      fail: "Untimely Demise"
    simulateAjax(result)

  $scope.emptyOptions = do ->
    simulateAjax([])

  $scope.directiveOptions =
    no_results_text: "SO SORRY"

  $scope.myPets = ['cat']
  $scope.pets =
    cat: 'Cat'
    dog: 'Dog'
    hamster: 'Hamster'

  $timeout ->
    $scope.$apply -> $scope.myPets.push('hamster')
  , 1000

  $scope.disabled = true

])
