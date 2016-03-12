---
title: Angular Chosen

toc_footers:
  - <a href="https://twitter.com/leocaseiro" class="twitter-follow-button" data-show-count="true">@leocaseiro</a>
  - <a target="_blank" href='https://github.com/leocaseiro/angular-chosen/releases'>Angular Chosen v1.3.0</a>

includes:
  - examples

search: true

---

Angular Chosen Localytics [![bower](https://img.shields.io/badge/bower-v1.3.0-brightgreen.svg)](https://github.com/leocaseiro/angular-chosen) [![npm](https://img.shields.io/badge/npm-v1.3.0-brightgreen.svg)](https://www.npmjs.com/package/angular-chosen-localytics)
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

> bower install angular-chosen-localytics --save

<aside class="notice">If you use <strong>Yeoman</strong> or <strong>bower install</strong>, you need to rename the <strong>chosen.jquery.js</strong> or the <strong>chosen.proto.js</strong> to <strong>chosen.js</strong>. Otherwise <strong>chosen.js</strong> won't be included in your <strong>index.html</strong>.</aside>


### install via npm

> npm install angular-chosen-localytics --save


### Download files
* <svg aria-hidden="true" class="octicon octicon-file-zip text-muted" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path d="M8.5 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h10c0.55 0 1-0.45 1-1V4.5L8.5 1z m2.5 13H1V2h3v1h1v-1h3l3 3v9zM5 4v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 1.28c-0.59 0.34-1 0.98-1 1.72v1h4v-1c0-1.11-0.89-2-2-2v-1h-1v1.28z m2 0.72v1H4v-1h2z"></path></svg> [angular-chosen-1.3.0.zip](https://github.com/leocaseiro/angular-chosen/archive/1.3.0.zip)
* <svg aria-hidden="true" class="octicon octicon-file-zip text-muted" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path d="M8.5 1H1C0.45 1 0 1.45 0 2v12c0 0.55 0.45 1 1 1h10c0.55 0 1-0.45 1-1V4.5L8.5 1z m2.5 13H1V2h3v1h1v-1h3l3 3v9zM5 4v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 0h1v1h-1v-1z m1 2v-1h1v1h-1z m-1 1.28c-0.59 0.34-1 0.98-1 1.72v1h4v-1c0-1.11-0.89-2-2-2v-1h-1v1.28z m2 0.72v1H4v-1h2z"></path></svg> [angular-chosen-1.3.0.tar.gz](https://github.com/leocaseiro/angular-chosen/archive/1.3.0.tar.gz)

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

Pass any [chosen options](https://harvesthq.github.io/chosen/options.html) as attributes

<aside class="notice">Note: Switch from <code>_</code> to <code>-</code> </aside>

<table>
  <tr><th width="240">Option</th><th>Default</th><th>Description</th></tr>
  <tr><td><code>allow-single-deselect</code></td><td>false</td><td>When set to true on a single select, Chosen adds a UI element which selects the first element (if it is blank).</td></tr>
  <tr><td><code>disable-search</code></td><td>false</td><td>When set to true, Chosen will not display the search field (single selects only).</td></tr>
  <tr><td><code>disable-search-threshold</code></td><td>0</td><td>Hide the search input on single selects if there are n or fewer options.</td></tr>
  <tr><td><code>enable-split-word-search</code></td><td>true</td><td>By default, searching will match on any word within an option tag. Set this option to false if you want to only match on the entire text of an option tag.</td></tr>
  <tr><td><code>inherit-select-classes</code></td><td>false</td><td>When set to true, Chosen will grab any classes on the original select field and add them to Chosen’s container div.</td></tr>
  <tr><td><code>max-selected-options</code></td><td>Infinity</td><td>Limits how many options the user can select. When the limit is reached, the chosen:maxselected event is triggered.</td></tr>
  <tr><td><code>search-contains</code></td><td>false</td><td>By default, Chosen’s search matches starting at the beginning of a word. Setting this option to true allows matches starting from anywhere within a word. This is especially useful for options that include a lot of special characters or phrases in ()s and []s.</td></tr>
  <tr><td><code>single-backstroke-delete</code></td><td>true</td><td>By default, pressing delete/backspace on multiple selects will remove a selected choice. When false, pressing delete/backspace will highlight the last choice, and a second press deselects it.</td></tr>
  <tr><td><code>width</code></td><td>Original select width.</td><td>The width of the Chosen select box. By default, Chosen attempts to match the width of the select box you are replacing. If your select is hidden when Chosen is instantiated, you must specify a width or the select will show up with a width of 0.</td></tr>
  <tr><td><code>display-disabled-options</code></td><td>true</td><td>By default, Chosen includes disabled options in search results with a special styling. Setting this option to false will hide disabled results and exclude them from searches.</td></tr>
  <tr><td><code>display-selected-options</code></td><td>true</td><td>By default, Chosen includes selected options in search results with a special styling. Setting this option to false will hide selected results and exclude them from searches. <aside style="padding:10px;" class="notice">Note: this is for multiple selects only. In single selects, the selected result will always be displayed.</aside></td></tr>
  <tr><td><code>include-group-label-in-selected</code></td><td>false</td><td>By default, Chosen only shows the text of a selected option. Setting this option to true will show the text and group (if any) of the selected option.</td></tr>
  <tr><td><code>max-shown-results</code></td><td>Infinity</td><td>Only show the first (n) matching options in the results. This can be used to increase performance for selects with very many options.</td></tr>
</table>


<table>
  <tr><th width="200">Option</th><th width="140">Default (English)</th><th>Description</th></tr>
  <tr><td><code>no-results-text</code></td><td>"No results match"</td><td>The text to be displayed when no matching results are found. The current search is shown at the end of the text (e.g., No results match "Bad Search").</td></tr>
  <tr><td><code>placeholder-text-multiple</code></td><td>"Select Some Options"</td><td>The text to be displayed as a placeholder when no options are selected for a multiple select.</td></tr>
  <tr><td><code>placeholder-text-single</code></td><td>"Select an Option"</td><td>The text to be displayed as a placeholder when no options are selected for a single select.</td></tr>
</table>

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
<select chosen
        ng-model="state"
        ng-options="s for s in states">
</select>
```

<aside class="notice">Note: don't try to use <strong>ngModel</strong> with <strong>ngRepeat</strong>.  It won't work.  Use <strong>ngOptions</strong>.  It's better that way.</aside>

<aside class="warning">
  Also important: if your <strong>ngModel</strong> is <i>null</i> or <i>undefined</i>, you must manually include an empty <strong>&lt;option value=""&gt;&lt;/option&gt;</strong> inside your <strong>&lt;select&gt;</strong>, otherwise you'll encounter strange off-by-one errors:
</aside>

This annoying behavior is alluded to in the examples in the [documentation for ngOptions](http://docs.angularjs.org/api/ng.directive:select).


## Multiple Select [(Example)](#multiple-works-better-with-object-child-dot)

Integration with `ngModel` and `ngOptions` with [multiple select](#multiple-works-better-with-object-child-dot)

```html
<select chosen
        ng-model="state.selected"
        ng-options="s for s in states">
    <option value=""></option>
</select>
```

<aside class="warning">WARNING: Prefer use <strong>object.child</strong> while <strong>&lt;select multiple&gt;</strong>, <a href="#multiple-works-better-with-object-child-dot">angular works better with .(dot)</a></aside>


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

## ng-if instead of ng-show/ng-hide [(Example)](#multiple-works-better-with-object-child-dot)

Angular Chosen, don't work well with `ng-show` or `ng-hide`.
However, `ng-if` will do the job for you

##### index.html
```html
<div ng-controller="PostCtrl">
  <input type="checkbox" ng-model="showChosen" value="1" />
  <select chosen
          ng-if="showChosen"
          ng-model="post"
          ng-options="p for p in posts">
  </select>
</div>
```

## Create new Item

Angular Chosen, didn't accept one if [they most wanted feature](https://github.com/harvesthq/chosen/pull/166) which is add new item if no results match.
However, there's a [fork](https://github.com/koenpunt/chosen) that adds this feature and Angular Chosen is compatible with.

<aside class="warning">Warning: You must use the <a href="https://github.com/koenpunt/chosen/releases" target="_blank">forked version of Chosen</a> to work</aside>

First step is switch from oficial `chosen.js` and `chosen.css` to koenpunt/chosen versions.
You can download it here: [https://github.com/koenpunt/chosen/releases](https://github.com/koenpunt/chosen/releases)

Then, you'll have 4 new attributes: `create-option-text`, `persistent-create-option`, `skip-no-results` and `create-option`


<table>
  <tr><th width="200">Option</th><th width="140">Default (English)</th><th>Description</th></tr>
  <tr><td><code>create-option-text</code></td><td>"Add item:"</td><td>The text to be displayed on new buttom to Add item</td></tr>
  <tr><td><code>persistent-create-option</code></td><td>false</td><td>Decides if you can add any term, even if part of the term is also found, or only unique, not overlapping terms</td></tr>
  <tr><td><code>skip-no-results</code></td><td>false</td><td>with the skip_no_results option you can disable the 'No results match..' message, which is somewhat redundant when option adding is enabled</td></tr>
  <tr><td><code>create-option</code></td><td>false</td><td>(true)Enable Create option or <code>function(term)</code> which works better with Angular Chosen <a target="_blank" href="http://plnkr.co/edit/xZ5XbO?p=preview">(check example)</a></td></tr>
</table>

[More details](https://github.com/harvesthq/chosen/pull/166#issue-1361212)

To Create new option, follow:

#### .js
```javascript
$scope.name = 'Multiple Angular Chosen Example add new option';
  $scope.state = ['California', 'Arizona'];
  $scope.states = [
    'Alaska',
    'Arizona',
    'Arkansas',
    'California'
  ];

  $scope.createOption = function(term) {
    $scope.$apply(function() {
      $scope.states.push(term);
      $scope.state.push(term);
    });
  }
```

#### .html
```html
<select multiple
        chosen
        create-option-text="'Create item'"
        persistent-create-option="true"
        skip-no-results="true"
        create-option="createOption"
        ng-model="state"
        ng-options="s for s in states">
  <option value=""></option>
</select>
```


## Translate

There are 3 attributes to translate messages.
As an attribute directive, you should pass a variable or a Value between quotes.

<table>
  <tr><th width="200">Option</th><th width="140">Default (English)</th><th>Description</th></tr>
  <tr><td><code>no-results-text</code></td><td>"No results match"</td><td>The text to be displayed when no matching results are found. The current search is shown at the end of the text (e.g., No results match "Bad Search").</td></tr>
  <tr><td><code>placeholder-text-multiple</code></td><td>"Select Some Options"</td><td>The text to be displayed as a placeholder when no options are selected for a multiple select.</td></tr>
  <tr><td><code>placeholder-text-single</code></td><td>"Select an Option"</td><td>The text to be displayed as a placeholder when no options are selected for a single select.</td></tr>
</table>

### Example in Brazilian Portuguese

```html
<select multiple chosen
    no-results-text="'Nenhum resultado encontrado para sua busca'"
    placeholder-text-multiple="'Selecione as opções'"
    ng-model="state.selected" ng-options="s for s in states">
  <option value=""></option>
</select>
```
[Translate Example](http://plnkr.co/edit/P3bWW2?p=preview)


# Features

  * Works with `ngModel` and `ngOptions`
  * Supports usage of promises in `ngOptions`
  * Provides a 'loading' animation when 'ngOptions' collection is a promise backed by a remote source
  * Pass options to `Chosen` via attributes or by passing an object to the Chosen directive

