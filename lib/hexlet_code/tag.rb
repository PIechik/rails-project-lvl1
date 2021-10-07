# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(name, options = {})
      single_tags = %w[input br img]
      return "<#{name}>" if options.empty?

      rendered_options = render_tag_options(options)
      return "<#{name} #{rendered_options}>" if single_tags.include? name

      "<#{name} #{rendered_options}>#{yield}</#{name}>"
    end

    def self.render_tag_options(options)
      options.map do |key, value|
        "#{key}=\"#{value}\""
      end.join(' ')
    end
  end
end
