require "him/version"

require "json"
require "faraday"
require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"

require "him/model"
require "him/api"
require "him/middleware"
require "him/errors"
require "him/collection"

module Him
  module JsonApi
    autoload :Model, "him/json_api/model"
  end
end

# Backward compatibility alias for migration from Her
Her = Him
