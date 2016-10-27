require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class WordSearchTest < Minitest::Test

  def test_it_passes_a_path_in
    response = Faraday.get("http://localhost:9292/wordsearch?word=word")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("?")
  end

  def test_it_accurately_checks_words
    response   = Faraday.get("http://localhost:9292/wordsearch?word=word")
    response_2 = Faraday.get("http://localhost:9292/wordsearch?word=wor")
    parser     = Parser.new(response.body, nil, nil)  
    parser_2   = Parser.new(response_2.body, nil, nil)  
    assert_equal true, response.body.include?("is a known word")
    assert_equal true, response_2.body.include?("not")
  end

  def test_it_formats_parameter
    response = Faraday.get("http://localhost:9292/wordsearch?word=word")
    parser   = Parser.new(response.body, nil, nil)
    assert_equal true, response.body.include?("WORD")
  end

end