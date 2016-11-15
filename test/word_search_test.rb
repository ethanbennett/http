require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class WordSearchTest < Minitest::Test

  def setup
    false_path = "/wordsearch?word=tir"
    true_path = "/wordsearch?word=tired"
    @true_search = WordSearch.new(true_path)
    @false_search = WordSearch.new(false_path)
  end

  def test_it_extracts_true_word
    assert_equal "tired", @true_search.word
  end

  def test_it_extracts_false_word
    assert_equal "tir", @false_search.word
  end

  def test_it_loads_dictionary
    assert_equal 235886, @true_search.dictionary.size
  end

  def test_true_output
    assert_equal "TIRED is a known word.", @true_search.go
  end

  def test_false_output
    assert_equal "TIR is not a known word.", @false_search.go
  end

end