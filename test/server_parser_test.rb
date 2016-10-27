require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_gets_200_response
    response = Faraday.get("http://localhost:9292/")
    assert_equal 200, response.status
  end

  def test_counter_gets_passed_in
    response = Faraday.get("http://localhost:9292/shutdown")
    parser = Parser.new(response.body, 1500)
    assert_equal 1500, parser.counter
  end

  def test_hello_path_outputs_proper_message
    response = Faraday.get("http://localhost:9292/hello")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Hello, world!")
  end

  def test_datetime_outputs_proper_message
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
    response = Faraday.get("http://localhost:9292/shutdown")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Count:")
  end

  def test_error_message_displays
    response = Faraday.get("http://localhost:9292/checkout-how-thorough-these-tests-are")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("404")
  end

  def test_word_search_outputs_proper_message
    response = Faraday.get("http://localhost:9292/wordsearch?word=word")
    response_2 = Faraday.get("http://localhost:9292/wordsearch?word=wor")
    parser = Parser.new(response.body, nil)
    parser_2 = Parser.new(response_2.body, nil)
    assert_equal true, response.body.include?("WORD is a known word")
    assert_equal true, response_2.body.include?("WOR is not a known word")
  end


end