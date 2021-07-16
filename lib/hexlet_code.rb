# frozen_string_literal: true

require_relative 'hexlet_code/version'

# This module generates html forms
module HexletCode
  class Error < StandardError; end

  # This class generates html tags
  class Tag
    def self.build(tag, hash = {})
      line = "<#{tag}"
      hash.each do |key, value|
        line += " #{key}=\"#{value}\"" if key != :selected
      end
      line += ' selected' if hash[:selected]
      line += if block_given?
                ">#{yield}</#{tag}>"
              else
                '>'
              end
    end
  end

  # This class generates specific fields of form
  class Form
    attr_reader :user

    def initialize(user)
      @user = user
      @fields = ''
    end

    def select_constructor(field_name, hash)
      Tag.build('select', hash.reject { |k| k == :collection }) do
        options = hash[:collection].each_with_object([]) do |element, object|
          object << if user.send(field_name) == element
                      Tag.build('option', value: element, selected: true) { element }
                    else
                      Tag.build('option', value: element) { element }
                    end
        end
        options.join
      end
    end

    def textarea_constructor(field_name, hash)
      hash[:cols] ||= 20
      hash[:rows] ||= 40
      Tag.build('textarea', hash) { user.send(field_name) }
    end

    def input_constructor(field_name, hash)
      hash[:type] ||= 'text'
      hash[:value] = user.send(field_name)
      Tag.build('input', hash)
    end

    def input(field_name, hash = {})
      @fields += Tag.build('label', for: field_name) { field_name.to_s.capitalize }
      as = hash[:as]
      hash.reject! { |k| k == :as }
      hash[:name] = field_name
      @fields += case as
                 when :text then textarea_constructor(field_name, hash)
                 when :select then select_constructor(field_name, hash)
                 else input_constructor(field_name, hash)
                 end
    end

    def submit(button_name = 'Save')
      @fields += Tag.build('input', type: 'submit', value: button_name, name: 'commit')
    end
  end

  def self.form_for(user, url: '#')
    form = Form.new(user)
    Tag.build('form', action: url, method: 'post') do
      yield form
    end
  end
end
