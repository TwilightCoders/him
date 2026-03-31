module Him
  class Collection < ::Array

    attr_reader :metadata, :errors

    # @private
    def initialize(items = [], metadata = {}, errors = {})
      super(items)
      @metadata = metadata
      @errors = errors
    end

    %i[select reject collect map compact flatten uniq reverse
       sort sort_by sample shuffle slice drop take first last].each do |method|
      define_method(method) do |*args, &block|
        result = super(*args, &block)
        result.is_a?(Array) ? self.class.new(result, @metadata, @errors) : result
      end
    end
  end
end
