# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag, options = {})
      single_tags = %w[input br img]
      rendered_options = render_tag_options(options) unless options.empty?
      return "<#{tag} #{rendered_options}>" if single_tags.include? tag

      "<#{tag} #{rendered_options}>#{yield}</#{tag}>"
    end

    def self.render_tag_options(options)
      options.map do |key, value|
        "#{key}=\"#{value}\""
      end.join(' ')
    end
  end
end
