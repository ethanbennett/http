require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_gets_200_response
    # skip
    response = Faraday.get("http://localhost:9292/")
    assert_equal 200, response.status
  end

  def test_counter_gets_passed_in
    response = Faraday.get("http://localhost:9292/shutdown")
    # skip
    parser = Parser.new(response.body, 1500)
    assert_equal 1500, parser.counter
  end

  def test_hello_path_outputs_proper_message
    # skip
    response = Faraday.get("http://localhost:9292/hello")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Hello, world!")
  end

  def test_datetime_outputs_proper_message
    # skip
    response = Faraday.get("http://localhost:9292/datetime")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Oct") && response.body.include?("2016")
  end

  def test_root_outputs_proper_message
    response = Faraday.get("http://localhost:9292/")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Root")
  end

  def test_shutdown_displays_count
    # skip
    response = Faraday.get("http://localhost:9292/shutdown")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Count:")
  end

  def test_error_message_displays
    response = Faraday.get("http://localhost:9292/checkout-how-thorough-these-tests-are")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("404")
  end

end