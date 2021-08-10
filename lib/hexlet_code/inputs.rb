# frozen_string_literal: true

require_relative 'tag'

module Inputs
  class Input
    attr_reader :attributes, :value

    def initialize(name, value = nil, hash = {})
      hash.reject! { |key| key == :as }
      @attributes = hash
      @attributes[:name] = name
      @value = value
    end

    def build
      options = { value: value, type: 'text' }
      Tag.build('input', options.merge(attributes))
    end
  end

  class Textarea < Input
    def initialize(name, value = nill, hash = {})
      super(name, value, hash)
      @attributes[:cols] ||= 20
      @attributes[:rows] ||= 40
    end

    def build
      Tag.build('textarea', attributes) { value }
    end
  end

  class Select < Input
    attr_reader :collection

    def initialize(name, value = nil, hash = {})
      @options = []
      @collection = hash[:collection]
      hash.reject! { |key| key == :collection }
      super(name, value, hash)
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
