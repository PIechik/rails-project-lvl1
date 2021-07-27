# frozen_string_literal: true

require_relative 'tag'

class Label
  attr_reader :attributes

  def initialize(name)
    @attributes = { for: name }
  end

  def build
    Tag.build('label', attributes) { attributes[:for].to_s.capitalize }
  end
end
