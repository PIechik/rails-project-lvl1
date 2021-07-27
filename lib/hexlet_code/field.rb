# frozen_string_literal: true

class Field
  attr_reader :attributes

  def initialize(name, hash)
    hash.reject! { |key| key == :as }
    @attributes = hash
    @attributes[:name] = name
  end

  def build; end
end
