angular-chosen
==============

AngularJS Chosen directive

This directive brings the [Chosen](http://harvesthq.github.com/chosen/) jQuery plugin
into AngularJS with ngModel and ngOptions integration.

To use, include "localytics.directives" as a dependency in your Angular module.  You can now
use the "chosen" directive as an attribute on any select element.

# Features
  * Works with 'ngModel' and 'ngOptions'
  * Supports usage of promises in 'ngOptions'
  * Provides a 'loading' animation when 'ngOptions' collection is a promise backed by a remote source
  * Pass any Chosen option as an attribute or via an object to the chosen attribute

# Usage

### Simple example
Similar to `$("#states").chosen()`

    <select chosen multiple id="states">
      <option value="AK">Alaska</option>
      <option value="AZ">Arizona</option>
      <option value="AR">Arkansas</option>    
      <option value="CA">California</option>    
    </select>

### Use any chosen attributes
    <select
      chosen
      data-placeholder="Pick one of these"
      disable-search="true"
      allow-single-deselect="true">
      <option>This is fun</option>
      <option>I like Chosen so much</option>
      <option>I also like bunny rabbits</option>
    </select>

### Integration with `ngModel` and `ngOptions`
    <select
      multiple
      chosen
      ng-model="state" 
      ng-options="s for s in states">
    </select>

### Loading from remote data
#### app.js
    angular.module('App', ['localytics.directives'])
      .controller('BeerCtrl', function($scope) {
        $scope.beers = $resource('api/beers').query()
      })
    );

#### index.html
    <div ng-controller="BeerCtrl">
      <select
        chosen
        data-placeholder="Choose a beer"
        no-results-text="'Could not find any beers :('"
        ng-model="beer" 
        ng-options="b for b in beers">
      </select>
    </div>

<img src="https://raw.github.com/localytics/angular-chosen/master/example/choose-a-beer.png">


See the example directory for more detailed usage.
