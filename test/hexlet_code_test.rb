# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_builder
    assert_equal '<br>', HexletCode::Tag.build('br')
    assert_equal '<img src="path/to/image">', HexletCode::Tag.build('img', src: 'path/to/image')
    assert_equal '<input type="submit" value="Save">', HexletCode::Tag.build('input', type: 'submit', value: 'Save')
    assert_equal '<label>Email</label>', HexletCode::Tag.build('label') { 'Email' }
    assert_equal '<label for="email">Email</label>', HexletCode::Tag.build('label', for: 'email') { 'Email' }
  end

  def test_selected
    assert_equal '<option value="m" selected>m</option>', HexletCode::Tag
      .build('option', value: 'm', selected: true) { 'm' }
  end

  def test_form_for_with_fields
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal form, '<form action="#" method="post"><label for="name">Name</label>' \
                       '<input name="name" type="text" value="rob"><label for="job">Job</label>' \
                       '<textarea name="job" cols="20" rows="40">hexlet</textarea><label for="gender">Gender</label>' \
                       '<select name="gender"><option value="m" selected>m</option><option value="f">f</option></select></form>'
  end

  def test_submit
    user = User.new job: 'hexlet'
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    should_return = '<form action="#" method="post"><label for="name">Name</label>' \
                    '<input name="name" type="text" value=""><label for="job">Job</label>' \
                    '<input name="job" type="text" value="hexlet"><input type="submit" value="Save" name="commit"></form>'
    assert_equal should_return, form
  end
end
