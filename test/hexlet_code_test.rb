# frozen_string_literal: true

require "test_helper"

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_builder
    assert_equal "<br>", HexletCode::Tag.build("br")
    assert_equal '<img src="path/to/image">', HexletCode::Tag.build("img", src: "path/to/image")
    assert_equal '<input type="submit" value="Save">', HexletCode::Tag.build("input", type: "submit", value: "Save")
    assert_equal "<label>Email</label>", HexletCode::Tag.build("label") { "Email" }
    assert_equal '<label for="email">Email</label>', HexletCode::Tag.build("label", for: "email") { "Email" }
  end

  def test_selected
    assert_equal "<option value=\"m\" selected>m</option>", HexletCode::Tag
      .build("option", value: "m", selected: true) { "m" }
  end

  def test_empty_form_for
    user = User.new name: "rob"
    form = HexletCode.form_for user do |f|
    end
    assert_equal "<form action=\"#\" method=\"post\"></form>", form
    form = HexletCode.form_for user, url: "/users" do |f|
    end
    assert_equal "<form action=\"/users\" method=\"post\"></form>", form
  end

  def test_form_for_with_fields
    user = User.new name: "rob", job: "hexlet", gender: "m"
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal form, '<form action="#" method="post"><label for="name">Name</label>' \
    '<input type="text" value="rob" name="name"><label for="job">Job</label>' \
    '<textarea cols="20" rows="40" name="job">hexlet</textarea><label for="gender">Gender</label>' \
    '<select name="gender"><option value="m" selected>m</option><option value="f">f</option></select></form>'
  end

  def test_submit
    user = User.new job: "hexlet"
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    should_return = '<form action="#" method="post"><label for="name">Name</label><input type="text" name="name">' \
    '<label for="job">Job</label><input type="text" name="job" value="hexlet">' \
    '<input type="submit" value="Save" name="commit"></form>'
    assert_equal should_return, form
  end
end
