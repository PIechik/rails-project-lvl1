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
    assert_equal read_fixtures_from_file('form1'), form
  end

  def test_submit
    user = User.new job: 'hexlet'
    form = HexletCode.form_for user do |f|
      f.input :name
      f.submit
    end
    assert_equal read_fixtures_from_file('form2'), form
  end
end
