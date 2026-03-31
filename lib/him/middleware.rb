require "him/middleware/parse_json"
require "him/middleware/first_level_parse_json"
require "him/middleware/second_level_parse_json"
require "him/middleware/accept_json"

module Him
  module Middleware
    DefaultParseJSON = FirstLevelParseJSON

    autoload :JsonApiParser, "him/middleware/json_api_parser"
  end
end
