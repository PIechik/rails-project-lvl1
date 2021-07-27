# frozen_string_literal: true

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
