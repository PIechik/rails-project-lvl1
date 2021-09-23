# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag, options = {})
      single_tags = ['input']
      rendered_options = render_tag_options(options) unless options.empty?
      rendered_tag = "<#{tag}#{rendered_options}>"
      rendered_tag += "#{yield}</#{tag}>" unless single_tags.include? tag
      rendered_tag
    end

    def self.render_tag_options(options)
      rendered_options = options.map do |key, value|
        " #{key}=\"#{value}\"" if key != :selected
      end
      rendered_options << ' selected' if options[:selected]
      rendered_options.join
    end
  end
end
