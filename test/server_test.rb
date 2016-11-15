require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test

  def test_looper_starts_as_true
    server = Server.new
    assert_equal true, server.looper
    server.looper = false
  end

  def test_counter_starts_at_zero
    server = Server.new
    assert_equal 0, server.counter
    server.looper = false
  end

  def test_server_generates_number_for_game
    server = Server.new
    refute server.number.nil?
    server.looper = false
  end

  def test_server_knows_if_a_game_has_started
    server = Server.new
    assert_equal false, server.game_started
    server.looper = false
  end

  def test_server_creates_repo_for_game_responses
    server = Server.new
    assert_equal ([]), server.game_responses
    server.looper = false
  end

  def test_counter_gets_passed_in
    skip
    response = Faraday.get("http://localhost:9292/shutdown")
    parser   = Parser.new(response.body, 1500, nil)
    assert_equal 1500, parser.counter
  end

  def test_hello_path_outputs_proper_message
    skip
    response = Faraday.get("http://localhost:9292/hello")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("Hello, world!")
  end

  def test_datetime_outputs_proper_message
    skip
    response = Faraday.get("http://localhost:9292/datetime")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("Oct") && response.body.include?("2016")
  end

  def test_root_outputs_proper_message
    skip
    response = Faraday.get("http://localhost:9292/")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("Root")
  end

  def test_shutdown_displays_count
    skip
    response = Faraday.get("http://localhost:9292/shutdown")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("Count:")
  end

  def test_error_message_displays
    skip
    response = Faraday.get("http://localhost:9292/checkout-how-thorough-these-tests-are")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("404")
  end

  def test_word_search_outputs_proper_message
    skip
    response   = Faraday.get("http://localhost:9292/wordsearch?word=word")
    response_2 = Faraday.get("http://localhost:9292/wordsearch?word=wor")
    parser     = Parser.new(response.body, nil, nil)
    parser_2   = Parser.new(response_2.body, nil, nil)
    assert_equal true, response.body.include?("WORD is a known word")
    assert_equal true, response_2.body.include?("WOR is not a known word")
  end

  def test_game_returns_output_string
    skip
    response   = Faraday.get("http://localhost:9292/game?num=45")
    parser     = Parser.new(response.body, nil, 83)
    assert_equal true, response.body.include?("guess")
  end
end