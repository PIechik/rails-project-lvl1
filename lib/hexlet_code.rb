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
        line += " #{key}=\"#{value}\""
      end
      line += ">"
      if block_given?
        line += "#{yield}</#{tag}>"
      else
        line
      end
    end
  end

  def self.form_for(user, url: '#', &block)
    form = Tag.build("form", action: url, method: "post") do
      "\n"
    end
  end
end
