# frozen_string_literal: true

module HexletCode
  module Inputs
    class Text < Base
      def build
        attributes[:cols] ||= 20
        attributes[:rows] ||= 40
        Tag.build('textarea', attributes) { value }
      end
    end
  end
end
