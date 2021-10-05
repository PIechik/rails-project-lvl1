# frozen_string_literal: true

module HexletCode
  module Inputs
    class Base
      attr_reader :attributes, :value

      def initialize(name, value = nil, hash = {})
        hash.reject! { |key| key == :as }
        @attributes = hash
        @attributes[:name] = name
        @value = value
      end

      def build; end
    end
  end
end
