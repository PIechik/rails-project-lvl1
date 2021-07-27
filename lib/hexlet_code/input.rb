# frozen_string_literal: true

require_relative 'field'
require_relative 'tag'

class Input < Field
  def initialize(name, value = nil, hash = {})
    super(name, hash)
    @attributes[:value] = value
    @attributes[:type] ||= 'text'
  end

  def build
    Tag.build('input', attributes)
  end
end
