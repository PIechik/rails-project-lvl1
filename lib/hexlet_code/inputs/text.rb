# frozen_string_literal: true

module HexletCode
  module Inputs
    class Text < Input
      def initialize(name, value = nill, hash = {})
        super(name, value, hash)
        @attributes[:cols] ||= 20
        @attributes[:rows] ||= 40
      end

      def build
        Tag.build('textarea', attributes) { value }
      end
    end
  end
end
