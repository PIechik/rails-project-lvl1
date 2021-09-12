# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :fields, :attributes

    def initialize(hash)
      @attributes = { method: 'post' }
      hash[:action] = hash[:url] || '#'
      hash.reject! { |key| key == :url }
      @attributes.merge!(hash)
      @fields = []
    end
  end
end
