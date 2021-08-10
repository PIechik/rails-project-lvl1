# frozen_string_literal: true

class FormBuilder
  attr_reader :form, :user

  def initialize(form, user)
    @form = form
    @user = user
  end

  def build_label(field_name)
    form.fields << Label.new(field_name)
  end

  def input(field_name, hash = {})
    build_label(field_name)
    form.fields << case hash[:as]
                   when :text then Inputs::Textarea.new(field_name, user.send(field_name), hash)
                   when :select then Inputs::Select.new(field_name, user.send(field_name), hash)
                   else Inputs::Input.new(field_name, user.send(field_name), hash)
                   end
  end

  def submit(value = 'Save')
    form.fields << Inputs::Input.new('commit', value, type: 'submit')
  end

  def build
    text_array = form.fields.map(&:build)
    Tag.build('form', form.attributes) { text_array.join }
  end
end
