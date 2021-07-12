# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

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
end
