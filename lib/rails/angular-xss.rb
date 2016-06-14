require 'rails/angular-xss/escaper'
require 'rails/angular-xss/safe_buffer'
require 'rails/angular-xss/erb'
require 'rails/angular-xss/action_view'

module Rails
  module AngularXss
    def self.disable(&block)
      Escaper.disable(&block)
    end
  end
end