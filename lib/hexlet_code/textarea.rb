# frozen_string_literal: true

require_relative 'field'
require_relative 'tag'

class Textarea < Field
  attr_reader :value

  def initialize(name, value = nill, hash = {})
    super(name, hash)
    @attributes[:cols] ||= 20
    @attributes[:rows] ||= 40
    @value = value
  end

  def build
    Tag.build('textarea', attributes) { value }
  end
end
