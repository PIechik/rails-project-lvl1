# frozen_string_literal: true

module Inputs
  class Option
    attr_reader :attributes

    def initialize(value, selected: false)
      @attributes = { value: value, selected: selected }
    end

    def build
      Tag.build('option', attributes) { attributes[:value] }
    end
  end
end
