require 'erb'
require 'cgi'
require 'rails/angular-xss/erb_util_patch'
require 'rails/angular-xss/safebuffer_patch'

module Rails
  module AngularXSS
    class << self

      def escape!(str)
        if str.include? '{{'
          str.gsub!('{{', '{{ DOUBLE_LEFT_CURLY_BRACE }}')
        end
      end

      private

      def redef_without_warning(mod, const, value, expected: nil)
        old_value = mod.const_get(const)
        if expected &&  old_value != expected
          raise "Trying to patch constant #{const}, but expected values have changed." \
                "#{old_value} != #{expected}"
        end

        mod.send(:remove_const, const)
        mod.send(:const_set, const, value)
      end
    end

    ##
    # Patch ERB::Util.html_escape_once
    redef_without_warning ERB::Util,
                          'HTML_ESCAPE',
                          ERB::Util::HTML_ESCAPE.merge('{{' => '{{ DOUBLE_LEFT_CURLY_BRACE }}')

    redef_without_warning ERB::Util,
                          'HTML_ESCAPE_ONCE_REGEXP',
                          /["><']|&(?!([a-zA-Z]+|(#\d+)|(#[xX][\dA-Fa-f]+));)|\{\{/,
                          expected: /["><']|&(?!([a-zA-Z]+|(#\d+)|(#[xX][\dA-Fa-f]+));)/

  end
end