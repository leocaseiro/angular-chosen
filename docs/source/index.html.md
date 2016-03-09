---
title: Angular Chosen

toc_footers:
  - <a href="https://twitter.com/leocaseiro" class="twitter-follow-button" data-show-count="true">@leocaseiro</a>
  - <a target="_blank" href='https://github.com/leocaseiro/angular-chosen/releases'>Angular Chosen v1.2.0</a>

includes:
  - examples

search: true

---

Angular Chosen Localytics [![bower](https://img.shields.io/badge/bower-v1.2.0-brightgreen.svg)](https://github.com/leocaseiro/angular-chosen) [![npm](https://img.shields.io/badge/npm-v1.2.0-brightgreen.svg)](https://www.npmjs.com/package/angular-chosen-localytics)
==============

 <iframe src="https://ghbtns.com/github-btn.html?user=leocaseiro&repo=angular-chosen&type=star&count=true"frameborder="0" scrolling="0" width="100px" height="20px"></iframe> <iframe src="https://ghbtns.com/github-btn.html?user=leocaseiro&repo=angular-chosen&type=watch&count=true&v=2"frameborder="0" scrolling="0" width="100px" height="20px"></iframe> <iframe src="https://ghbtns.com/github-btn.html?user=leocaseiro&repo=angular-chosen&type=fork&count=true"frameborder="0" scrolling="0" width="100px" height="20px"></iframe> <iframe src="https://ghbtns.com/github-btn.html?user=leocaseiro&type=follow&count=true"frameborder="0" scrolling="0" width="170px" height="20px"></iframe>

AngularJS Chosen directive

This directive brings the [Chosen](http://harvesthq.github.com/chosen/) jQuery plugin
into AngularJS with ngModel and ngOptions integration.

Angular version 1.2+ is required.
<aside class="warning">WARNING: Since the version <strong>1.2.0</strong> the file <strong>./chosen.js</strong> is deprecated and you must include <strong>./dist/angular-chosen.js</strong> or <strong>./dist/angular-chosen.min.js</strong> instead</aside>

# Get Started

## Installation

### install via bower

>   bower install angular-chosen-localytics --save

<aside class="notice">If you use <strong>Yeoman</strong> or <strong>bower install</strong>, you need to rename the <strong>chosen.jquery.js</strong> or the <strong>chosen.proto.js</strong> to <strong>chosen.js</strong>. Otherwise <strong>chosen.js</strong> won't be included in your <strong>index.html</strong>.</aside>


### install via npm

>   npm install angular-chosen-localytics --save


### Download files
* <svg aria-hidden="true" class="octicon octicon-file-zip text-muted" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path d="M8.5 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h10c0.55 0 1-0.45 1-1V4.5L8.5 1z m2.5 13H1V2h3v1h1v-1h3l3 3v9zM5 4v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 1.28c-0.59 0.34-1 0.98-1 1.72v1h4v-1c0-1.11-0.89-2-2-2v-1h-1v1.28z m2 0.72v1H4v-1h2z"></path></svg> [angular-chosen-1.2.0.zip](https://github.com/leocaseiro/angular-chosen/archive/1.2.0.zip)
* <svg aria-hidden="true" class="octicon octicon-file-zip text-muted" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path d="M8.5 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h10c0.55 0 1-0.45 1-1V4.5L8.5 1z m2.5 13H1V2h3v1h1v-1h3l3 3v9zM5 4v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 1.28c-0.59 0.34-1 0.98-1 1.72v1h4v-1c0-1.11-0.89-2-2-2v-1h-1v1.28z m2 0.72v1H4v-1h2z"></path></svg> [angular-chosen-1.2.0.tar.gz](https://github.com/leocaseiro/angular-chosen/archive/1.2.0.tar.gz)

## Include libraries

```html
<link rel="stylesheet" type="text/css" href="./bower_components/chosen/chosen.css" />

<script src="./bower_components/jquery/dist/jquery.min.js"></script>
<script src="./bower_components/angular/angular.min.js"></script>
<script src="./bower_components/chosen/chosen.jquery.js"></script>
<script src="./bower_components/angular-chosen-localytics/dist/angular-chosen.min.js"></script>
```
<aside class="notice">Make sure you <a target="_blank" href="https://docs.angularjs.org/api/ng/function/angular.element">include jQuery before Angular</a>!</aside>

## Dependency Injection

Include `'localytics.directives' as dependency in your Angular Module

```javascript
angular.module('App', ['localytics.directives'])
```

## Directive chosen on &lt;select&gt;

Use the **chosen** directive as an attribute on any **&lt;select&gt;** element.

```html
<select chosen>...</select>
```



# Usage

## Simple example
Similar to `$("#states").chosen()`

```html
<select chosen multiple id="states">
  <option value="AK">Alaska</option>
  <option value="AZ">Arizona</option>
  <option value="AR">Arkansas</option>
  <option value="CA">California</option>
</select>
```

## chosen options

Pass any chosen options as attributes

```html
<select chosen
        data-placeholder="Pick one of these"
        disable-search="true"
        allow-single-deselect="true">
  <option value=""></option>
  <option>This is fun</option>
  <option>I like Chosen so much</option>
  <option>I also like bunny rabbits</option>
</select>
```
<aside class="warning">Note: the empty <strong>&lt;option value=&quot;&quot;&gt;&lt;/option&gt;</strong> element is mandatory when using <strong>allow-single-deselect</strong></aside>

## ngOptions and ngModel

Integration with `ngModel` and `ngOptions`

```html
<select multiple
        chosen
        ng-model="state"
        ng-options="s for s in states">
</select>
```

<aside class="notice">Note: don't try to use <strong>ngModel</strong> with <strong>ngRepeat</strong>.  It won't work.  Use <strong>ngOptions</strong>.  It's better that way.</aside>

<aside class="warning">
  Also important: if your <strong>ngModel</strong> is <i>null</i> or <i>undefined</i>, you must manually include an empty <strong>&lt;option value=""&gt;&lt;/option&gt;</strong> inside your <strong>&lt;select&gt;</strong>, otherwise you'll encounter strange off-by-one errors:

</aside>


```html
<select multiple
        chosen
        ng-model="state"
        ng-options="s for s in states">
  <option value=""></option>
</select>
```
This annoying behavior is alluded to in the examples in the [documentation for ngOptions](http://docs.angularjs.org/api/ng.directive:select).


## AngularJS &lt;select&gt; directives

Works well with other AngularJS directives

```html
<select chosen
        ng-model="state"
        ng-options="s for s in states"
        ng-disabled="editable">
</select>
```

## Remote source $resource

### Loading from a remote data source

Include chosen-spinner.css and spinner.gif to show an Ajax spinner icon while your data is loading.  If the collection comes back empty, the directive will disable the element and show a default
"No values available" message.  You can customize this message by passing in noResultsText in your options.

##### app.js
```javascript
angular.module('App', ['ngResource', 'localytics.directives'])
  .controller('BeerCtrl', function($scope, $resource) {
    $scope.beers = $resource('api/beers').query()
  });
```

##### index.html
```html
<div ng-controller="BeerCtrl">
  <select chosen
          data-placeholder="Choose a beer"
          no-results-text="'Could not find any beers :('"
          ng-model="beer"
          ng-options="b for b in beers">
  </select>
</div>
```

Image of select defined above in loading state:  <img src="https://raw.github.com/localytics/angular-chosen/master/example/choose-a-beer.png">

<aside class="notice">Note: Assigning promises directly to scope is now deprecated in Angular 1.2+.  Assign the results of the promise to scope
once the promise returns.  The loader animation will still work as long as the collection expression
evaluates to `undefined` while your data is loading!</aside>


## AJAX $http

##### app.js
```javascript
angular.module('App', ['localytics.directives'])
  .controller('PostCtrl', function($scope, $http) {
    $http('api/posts').success(function(data) {
      $scope.posts = data;
    });
  });
```

##### index.html
```html
<div ng-controller="PostCtrl">
  <select chosen
          data-placeholder="Choose a post"
          no-results-text="'Could not find any post :('"
          ng-model="post"
          ng-options="p for p in posts">
  </select>
</div>
```



## Translate

There are 3 attributes to translate messages.
As an attribute directive, you should pass a variable or a Value between quotes.

Attribute | Default (English)
-------------- | --------------
`placeholder-text-single` | **'Select an Option'**
`placeholder-text-multiple` | **'Select Some Options'**
`no-results-text` | **'No results match'**

### Example in Brazilian Portuguese

```html
<select multiple chosen
    no-results-text="'Nenhum resultado encontrado para sua busca'"
    placeholder-text-multiple="'Selecione as opções'"
    ng-model="state" ng-options="s for s in states">
  <option value=""></option>
</select>
```
[Translate Example](http://plnkr.co/edit/P3bWW2?p=preview)


# Features

  * Works with `ngModel` and `ngOptions`
  * Supports usage of promises in `ngOptions`
  * Provides a 'loading' animation when 'ngOptions' collection is a promise backed by a remote source
  * Pass options to `Chosen` via attributes or by passing an object to the Chosen directive

