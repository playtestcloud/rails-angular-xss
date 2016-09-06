module Rails::AngularXSS
  module SafeBufferPatch
    def html_escape_interpolated_argument(arg)
      if (!html_safe? || arg.html_safe?)
        return arg
      end

      result = CGI.escapeHTML(arg.to_s)
      ::Rails::AngularXSS.escape!(result)

      result
    end
  end
end

ActiveSupport::SafeBuffer.prepend ::Rails::AngularXSS::SafeBufferPatch