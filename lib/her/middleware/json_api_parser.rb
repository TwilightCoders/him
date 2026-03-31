module Her
  module Middleware
    # This middleware expects the resource/collection data to be contained in the `data`
    # key of the JSON object
    class JsonApiParser < ParseJSON

      # Parse the response body
      #
      # @param [String] body The response body
      # @return [Mixed] the parsed response
      # @private
      def parse(body)
        json = parse_json(body)

        included = json.fetch(:included, [])
        primary_data = json.fetch(:data, {})
        Array(primary_data).each do |resource|
          next unless resource.is_a?(Hash)
          relationships = resource.delete(:relationships) { {} }
          resource[:attributes].merge!(resolve_relationships(relationships, included))
        end

        {
          data: primary_data || {},
          errors: json[:errors] || [],
          metadata: json[:meta] || {}
        }
      end

      private

      def resolve_relationships(relationships, included)
        return {} if included.empty? || relationships.nil?
        relationships.each_with_object({}) do |(rel_name, linkage), built|
          linkage_data = linkage.fetch(:data, {})
          built[rel_name] = if linkage_data.is_a?(Array)
            linkage_data.map { |l| find_included(l, included) }.compact
          else
            find_included(linkage_data, included)
          end
        end
      end

      def find_included(linkage, included)
        included.detect { |i| i.values_at(:id, :type) == linkage.values_at(:id, :type) }
      end

      public

      # This method is triggered when the response has been received. It modifies
      # the value of `env[:body]`.
      #
      # @param [Hash] env The response environment
      # @private
      def on_complete(env)
        env[:body] = case env[:status]
                     when 204, 304
                       parse('{}')
                     else
                       parse(env[:body])
                     end
      end
    end
  end
end
