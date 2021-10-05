# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest/autorun'

def read_fixtures_from_file(file_name)
  File.open("./test/fixtures/#{file_name}.html").read
end
