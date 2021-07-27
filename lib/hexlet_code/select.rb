# frozen_string_literal: true

require_relative 'option'
require_relative 'field'
require_relative 'tag'

class Select < Field
  attr_reader :collection, :value

  def initialize(name, value = nil, hash = {})
    @options = []
    @collection = hash[:collection]
    @value = value
    hash.reject! { |key| key == :collection }
    super(name, hash)
  end

  def build
    @options = collection.map do |elem|
      if elem == value
        Option.new(elem, selected: true)
      else
        Option.new(elem)
      end
    end
    text_array = @options.map(&:build)
    Tag.build('select', attributes) { text_array.join }
  end
end
