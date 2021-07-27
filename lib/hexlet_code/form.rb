# frozen_string_literal: true

require_relative 'label'
require_relative 'textarea'
require_relative 'select'
require_relative 'input'
require_relative 'tag'

class Form
  attr_reader :user, :url

  def initialize(user, url)
    @user = user
    @url = url
    @fields = []
  end

  def input(field_name, hash = {})
    @fields << Label.new(field_name)
    @fields << case hash[:as]
               when :text then Textarea.new(field_name, user.send(field_name), hash)
               when :select then Select.new(field_name, user.send(field_name), hash)
               else Input.new(field_name, user.send(field_name), hash)
               end
  end

  def submit(value = 'Save')
    @fields << Input.new('commit', value, type: 'submit', as: :submit)
  end

  def build
    text_array = @fields.map(&:build)
    Tag.build('form', action: url, method: 'post') { text_array.join }
  end
end
