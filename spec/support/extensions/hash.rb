class Hash

  def to_json
    JSON.generate(self)
  end
end
