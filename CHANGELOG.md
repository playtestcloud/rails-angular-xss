## 0.3.0 (unreleased)

* Use `.$root` reference to root scope

  In isolated scopes, the variable is not automatically inherited from the root scope.
  However, every scope receives a reference to the root scope through `scope.$root`.

  *Oliver Günther*

## 0.2.0

* Adjust for changes in Rails 5.0

  Ruby 2.3 drastically improves CGI.escapeHTML speed through escaping in C
  Rails in turn uses `CGI.escapeHTML` internally: https://github.com/rails/rails/pull/22722
  
  We can no longer provide a simple patch to extend the `gsub` argument hash to  include Angular braces in the escaping of `ERB::Util` and `Safebuffer`.
 
  This version proposes to patch both modules to check whether we encounter a brace and replace that additionally. It appears to be faster still than doing all replacements with gsub.

  *Oliver Günther*

## 0.1.0 (June 18, 2016)

*   Patch ActiveSupport string/core_ext to extend HTML escaping with Angular double braces

    *Oliver Günther*