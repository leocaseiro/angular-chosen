Angular Chosen Localytics [![Bower](https://img.shields.io/bower/v/angular-chosen-localytics.svg)](https://github.com/leocaseiro/angular-chosen) [![npm](https://img.shields.io/npm/v/angular-chosen-localytics.svg)](https://www.npmjs.com/package/angular-chosen-localytics)
==============

AngularJS Chosen directive

This directive brings the [Chosen](http://harvesthq.github.com/chosen/) jQuery plugin
into AngularJS with ngModel and ngOptions integration.

To use, include `localytics.directives` as a dependency in your Angular module.  You can now
use the `chosen` directive as an attribute on any select element.  Angular version 1.3+ is required, but recomended 1.4.9+.

# [Full Documentation with Examples](http://leocaseiro.github.io/angular-chosen/)
* Documentation on [Github Page](http://leocaseiro.github.io/angular-chosen/)
* Examples on [example/index.html](http://htmlpreview.github.io/?https://github.com/leocaseiro/angular-chosen/blob/master/example/index.html)



## Installation (npm or bower)

Via bower

    $ bower install angular-chosen-localytics --save

Via npm

    $ npm install angular-chosen-localytics --save


Via [cdn](https://cdnjs.com/libraries/angular-chosen-localytics)
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-chosen-localytics/1.4.0/angular-chosen.min.js"></script>
```

    

Or download zip file
> [Download v1.4.0](https://github.com/leocaseiro/angular-chosen/archive/1.4.0.zip)




## Yeoman or Bower install
If you use Yeoman or Bower install, you need to rename the `chosen.jquery.js` or the `chosen.proto.js` to `chosen.js`. Otherwise Chosen won't be included in your `index.html`.

# Features
  * Works with `ngModel` and `ngOptions`
  * Supports usage of promises in `ngOptions`
  * Provides a 'loading' animation when 'ngOptions' collection is a promise backed by a remote source
  * Pass options to `Chosen` via attributes or by passing an object to the Chosen directive

# Usage

### Simple example
Similar to `$("#states").chosen()`

```html
<select chosen multiple id="states">
  <option value="AK">Alaska</option>
  <option value="AZ">Arizona</option>
  <option value="AR">Arkansas</option>
  <option value="CA">California</option>
</select>
```

### Pass any chosen options as attributes

```html
<select chosen
        data-placeholder-text-single="'Pick one of these'"
        disable-search="true"
        allow-single-deselect="true">
  <option value=""></option>
  <option>This is fun</option>
  <option>I like Chosen so much</option>
  <option>I also like bunny rabbits</option>
</select>
```
> Note: the empty option element is mandatory when using `allow-single-deselect`

### Integration with `ngModel` and `ngOptions`

```html
<select multiple
        chosen
        ng-model="state"
        ng-options="s for s in states">
</select>
```

> Note: don't try to use `ngModel` with `ngRepeat`.  It won't work.  Use `ngOptions`.  It's better that way.

> Also important: if your `ngModel` is null or undefined, you must manually include an empty option inside your `<select>`, otherwise you'll encounter strange off-by-one errors:

```html
<select multiple
        chosen
        ng-model="state"
        ng-options="s for s in states">
  <option value=""></option>
</select>
```

> This annoying behavior is alluded to in the examples in the [documentation for ngOptions](http://docs.angularjs.org/api/ng.directive:select).

#### Works well with other AngularJS directives

```html
<select chosen
        ng-model="state"
        ng-options="s for s in states"
        ng-disabled="editable">
  <option value=""></option>
</select>
```

### Loading from a remote data source
Include `chosen-spinner.css` and `spinner.gif` to show an Ajax spinner icon while your data is loading.  If the collection comes back empty, the directive will disable the element and show a default
"No values available" message.  You can customize this message by passing in `noResultsText` in your options.

##### app.js
```js
angular.module('App', ['ngResource', 'localytics.directives'])
    .controller('BeerCtrl', function($scope, $resource) {
      $scope.beers = $resource('api/beers').query()
    });
```

##### index.html
```html
<div ng-controller="BeerCtrl">
  <select chosen
          data-placeholder-text-single="'Choose a beer'"
          no-results-text="'Could not find any beers :('"
          ng-model="beer"
          ng-options="b for b in beers">
      <option value=""></option>
  </select>
</div>
```

Image of select defined above in loading state:
`<img src="https://raw.github.com/localytics/angular-chosen/master/example/choose-a-beer.png">`

> Note: Assigning promises directly to scope is now deprecated in Angular 1.2+.  Assign the results of the promise to scope
once the promise returns.  The loader animation will still work as long as the collection expression
evaluates to `undefined` while your data is loading!
