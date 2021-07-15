# frozen_string_literal: true

require_relative "hexlet_code/version"

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
      line += " selected" if hash[:selected]
      line += if block_given?
                ">#{yield}</#{tag}>"
              else
                ">"
              end
    end
  end

  # This class generates specific fields of form
  class Form
    attr_reader :user

    def initialize(user)
      @user = user
      @fields = ""
    end

    def select_constructor(field_name, collection)
      Tag.build("select", name: field_name) do
        options = collection.each_with_object([]) do |element, object|
          object << if user.gender == element
                      Tag.build("option", value: element, selected: true) { element }
                    else
                      Tag.build("option", value: element) { element }
                    end
        end
        options.join
      end
    end

    def input(field_name, as: nil, collection: [])
      @fields += Tag.build("label", for: field_name) { field_name.to_s.capitalize }
      @fields += case as
                 when :text
                   Tag.build("textarea", cols: 20, rows: 40, name: field_name) { user.send(field_name) }
                 when :select
                   select_constructor(field_name, collection)
                 else
                   Tag.build("input", type: "text", value: user.send(field_name), name: field_name)
                 end
    end

    def submit(button_name = "Save")
      @fields += Tag.build("input", type: "submit", value: button_name, name: "commit")
    end
  end

  def self.form_for(user, url: "#")
    form = Form.new(user)
    Tag.build("form", action: url, method: "post") do
      yield form
    end
  end
end
