require 'erb'

module Rails
  module AngularXSS

  def self.redef_without_warning(const, value, expected: nil)
    old_value = ERB::Util.const_get(const)
    if expected &&  old_value != expected
      raise "Trying to patch constant #{const}, but expected values have changed." \
            "#{old_value} != #{expected}"
    end

    ERB::Util.send(:remove_const, const)
    ERB::Util.send(:const_set, const, value)
  end

  redef_without_warning 'HTML_ESCAPE',
                        ERB::Util::HTML_ESCAPE.merge('{{' => '{{ DOUBLE_LEFT_CURLY_BRACE }}')

  redef_without_warning 'HTML_ESCAPE_REGEXP',
                        /[&"'><]|\{\{/,
                        expected: /[&"'><]/

  redef_without_warning 'HTML_ESCAPE_ONCE_REGEXP',
                        /["><']|&(?!([a-zA-Z]+|(#\d+)|(#[xX][\dA-Fa-f]+));)|\{\{/,
                        expected: /["><']|&(?!([a-zA-Z]+|(#\d+)|(#[xX][\dA-Fa-f]+));)/
  end
end