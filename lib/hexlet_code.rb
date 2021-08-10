# frozen_string_literal: true

require_relative 'hexlet_code/form'
require_relative 'hexlet_code/form_builder'

module HexletCode
  class Error < StandardError; end

  def self.form_for(user, hash = {})
    form = Form.new(hash)
    form_builder = FormBuilder.new(form, user)
    yield(form_builder)
    form_builder.build
  end
end
