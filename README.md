angular-chosen
==============

AngularJS Chosen directive

This directive brings the [Chosen](http://harvesthq.github.com/chosen/) jQuery plugin
into AngularJS with ngModel and ngOptions integration.

To use, include "localytics.directives" as a dependency in your Angular module.  You can now
use the "chosen" directive as an attribute on any select element.

This directive also works when the collection passed to ngOptions is a promise, so you can load your
data from a remote source.  Include chosen-spinner.css to show an Ajax spinner icon while your data is
loading.  If the collection comes back empty, the directive will disable the element and show a default
"No values available" message.  You can customize this message by passing in noResultsText in your options.

Pass options into Chosen by passing an options hash into the directive, or define your options
as attributes on the element.

Examples:

    <select 
      chosen
      multiple
      allow-single-deselect="true"
      data-placeholder="Choose Your Own Adventure"
      no-results-text="'Tough luck'"
      ng-model="foo" 
      ng-options="value for value in optionsFromQuery" 
      style="width:200px;">
      <option value=""></option>
    </select>

    <select chosen disable-search="true" ng-model="bar">
      <option>Hi</option>
      <option>This is fun</option>
      <option>I like Chosen so much</option>
      <option>I also like bunny rabbits</option>
    </select>

See the example directory for more detailed usage.