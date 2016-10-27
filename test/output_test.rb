require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class OutputTest < Minitest::Test

  def test_output_changes_when_path_changes
    response   = Faraday.get("http://localhost:9292/hello")
    response_2 = Faraday.get("http://localhost:9292/")
    parser     = Parser.new(response.body, 1500, nil)
    output     = Output.new(nil, parser)
    assert_equal true , response.body.include?("Hello")
    assert_equal true , response_2.body.include?("Root")
  end

  def test_client_gets_passed_in
    response = Faraday.get("http://localhost:9292/hello")
    parser   = Parser.new(response.body, nil, nil)
    output   = Output.new("I'm a client", parser)
    assert_equal "I'm a client" , output.client
  end

  def test_output_displays_accurate_parsed_response
    response = Faraday.get("http://localhost:9292/hello")
    parser   = Parser.new(response.body, nil, nil)
    output   = Output.new(nil, parser)
    assert_equal true, response.body.include?("Faraday")
  end


end