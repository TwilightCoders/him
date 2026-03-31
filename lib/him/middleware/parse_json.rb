module Him
  module Middleware
    class ParseJSON < Faraday::Middleware

      # @private
      def parse_json(body = nil)
        body = '{}' if body.blank?
        message = "Response from the API must behave like a Hash or an Array (last JSON response was #{body.inspect})"

        json = begin
          JSON.parse(body, symbolize_names: true)
        rescue JSON::ParserError
          raise Him::Errors::ParseError, message
        end

        raise Him::Errors::ParseError, message unless json.is_a?(Hash) || json.is_a?(Array)

        json
      end
    end
  end
end
