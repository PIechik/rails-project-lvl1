# frozen_string_literal: true

module HexletCode
  autoload :Form, 'hexlet_code/form.rb'
  autoload :FormBuilder, 'hexlet_code/form_builder.rb'
  autoload :Inputs, 'hexlet_code/inputs.rb'
  autoload :Label, 'hexlet_code/label.rb'
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :VERSION, 'hexlet_code/version.rb'

  def self.form_for(entity, hash = {})
    form = Form.new(hash)
    form_builder = FormBuilder.new(form, entity)
    yield(form_builder)
    form_builder.build
  end
end
