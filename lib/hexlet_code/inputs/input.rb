# frozen_string_literal: true

module HexletCode
  module Inputs
    class Input < Base
      def build
        options = { value: value, type: 'text' }
        Tag.build('input', options.merge(attributes))
      end
    end
  end
end
