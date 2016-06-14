module Rails
  module AngularXss
  class Escaper

      XSS_DISABLED_KEY = :_angular_xss_disabled

      def self.escape(string)
        return unless string
        if disabled?
          string
        else
          string.gsub('{{'.freeze, ' { { '.freeze)
        end
      end

      def self.disabled?
        !!Thread.current[XSS_DISABLED_KEY]
      end

      def self.disable
        old_disabled = Thread.current[XSS_DISABLED_KEY]
        Thread.current[XSS_DISABLED_KEY] = true
        yield
      ensure
        Thread.current[XSS_DISABLED_KEY] = old_disabled
      end
    end
  end
end

