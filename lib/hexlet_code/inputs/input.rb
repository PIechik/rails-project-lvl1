# frozen_string_literal: true

module HexletCode
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
        Tag.build('input', attributes.merge(value: value))
      end
    end
  end
end
