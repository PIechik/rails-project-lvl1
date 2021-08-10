# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_form_for
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    form = HexletCode.form_for user do |f|
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal form, '<form method="post" action="#"><label for="job">Job</label>' \
                       '<textarea name="job" cols="20" rows="40">hexlet</textarea><label for="gender">Gender</label>' \
                       '<select name="gender"><option value="m" selected>m</option><option value="f">f</option>' \
                       '</select></form>'
  end

  def test_submit
    user = User.new job: 'hexlet'
    form = HexletCode.form_for user do |f|
      f.input :name
      f.submit
    end
    should_return = '<form method="post" action="#"><label for="name">Name</label>' \
                    '<input value="" type="text" name="name"><input value="Save" type="submit" name="commit"></form>'
    assert_equal should_return, form
  end
end
