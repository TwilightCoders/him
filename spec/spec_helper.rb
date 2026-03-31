$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")

if ENV["COVERAGE"]
  require "simplecov"
  require "simplecov-json"
  SimpleCov.start do
    add_filter "spec"
    SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::JSONFormatter
    ])
  end
end

require "rspec"
require "him"

# Require everything in `spec/support`
Dir[File.expand_path("../../spec/support/**/*.rb", __FILE__)].map(&method(:require))

# Remove ActiveModel deprecation message
I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.include Him::Testing::Macros::ModelMacros
  config.include Him::Testing::Macros::RequestMacros

  config.before :each do
    @spawned_models = []
  end

  config.after :each do
    @spawned_models.each do |model|
      Object.instance_eval { remove_const model } if Object.const_defined?(model)
    end
  end
end
