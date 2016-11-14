class ERB
  module Util
    ##
    # Patch ERB::Util.html_escape
    # This reverts the patch made in Ruby 2.3 :-(
    # https://github.com/ruby/ruby/pull/1164
    HTML_ESCAPE_TABLE = CGI::Util::TABLE_FOR_ESCAPE_HTML__.merge('{{' => '{{ $root.DOUBLE_LEFT_CURLY_BRACE }}')

    def unwrapped_html_escape(s)
      s = s.to_s
      return s if s.html_safe?

      result = CGI.escapeHTML(ActiveSupport::Multibyte::Unicode.tidy_bytes(s))
      ::Rails::AngularXSS.escape!(result)
      
      result
    end
    module_function :unwrapped_html_escape

  end
end