# frozen_string_literal: true

module HexletCode
  module Inputs
    class Select < Base
      def build
        rendered_options = render_options(attributes[:collection])
        attributes.reject! { |key| key == :collection }
        Tag.build('select', attributes) { rendered_options.join }
      end

      private

      def render_options(collection)
        options = collection.map do |elem|
          if elem == value
            Option.new(elem, selected: true)
          else
            Option.new(elem)
          end
        end
        options.map(&:build)
      end
    end
  end
end
