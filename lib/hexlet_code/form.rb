# frozen_string_literal: true

require_relative 'label'
require_relative 'inputs'

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
