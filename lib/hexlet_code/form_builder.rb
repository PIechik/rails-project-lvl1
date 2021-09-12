# frozen_string_literal: true

module HexletCode
  class FormBuilder
    attr_reader :form, :entity

    def initialize(form, entity)
      @form = form
      @entity = entity
    end

    def build_label(field_name)
      form.fields << Label.new(field_name)
    end

    def input(field_name, hash = {})
      build_label(field_name)
      if hash[:as] == :text
        hash[:as] = :textarea
      elsif !hash[:as]
        hash[:as] = :input
      end
      form.fields << Inputs.const_get(hash[:as].capitalize.to_s).new(field_name, entity.send(field_name), hash)
    end

    def submit(value = 'Save')
      form.fields << Inputs::Input.new('commit', value, type: 'submit')
    end

    def build
      html_representations_of_fields = form.fields.map(&:build)
      Tag.build('form', form.attributes) { html_representations_of_fields.join }
    end
  end
end
