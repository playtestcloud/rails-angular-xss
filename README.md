rails-angular-xss [![Build Status](https://travis-ci.org/opf/rails-angular-xss.png?branch=master)](https://travis-ci.org/opf/rails-angular-xss)
===========

When rendering AngularJS templates with a server-side templating engine like ERB it is easy to introduce XSS vulnerabilities.
These vulnerabilities are enabled by AngularJS evaluating user-provided strings containing interpolation symbols (default symbols are `{{` and `}}`).

This gem patches ERB/rails_xss so AngularJS interpolation symbols are auto-escaped in unsafe strings.
And by auto-escaped we mean replacing `{{` with ` {{ DOUBLE_LEFT_CURLY_BRACE }}`. To leave AngularJS interpolation marks unescaped, mark the string as `html_safe`.

**This is an unsatisfactory hack.**
A better solution is very much desired, but is not possible without some changes in AngularJS. See the [related AngularJS issue](https://github.com/angular/angular.js/issues/5601).

Requirements
------------

* Rails 4.2


Installation
------------

0. Read the code so you know what you're getting into.

1. Put this into your Gemfile

        gem 'rails-angular-xss'

2. Run `bundle install`.

4. **Important:** Add `$rootScope.DOUBLE_LEFT_CURLY_BRACE = '{{'` to your Angular app initialization.

5. Run your test suite to find the places that broke.

6. Mark any string that is allowed to contain Angular expressions as `#html_safe`.

How it works
------------

This gem patches ERB.Util HTML_ESCAPE constants to replace *any* occurence of the string `{{` with the replacement ``{{ DOUBLE_LEFT_CURLY_BRACE }}`. This will be interpolated by Angular, **and assuming you've followed step 4. above**, Angular returns the interpolated string `{{`.

This allows users to actually use `{{` without it being transformed by some invisible spaces, unicode characaters that *look like*  a curly bracket and so on.


Development
-----------

- Fork the repository.
- Push your changes with specs. There is a Rails 3 test application in `spec/app_root` if you need to test integration with a live Rails app.
- Send a pull request.


Credits
-------

[Henning Koch](mailto:henning.koch@makandra.de) from [makandra](http://makandra.com/).
