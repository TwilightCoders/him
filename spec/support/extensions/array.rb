class Array

  def to_json
    JSON.generate(self)
  end
end
