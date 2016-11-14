require 'socket'
require_relative 'game_setup'

class Game
  include GameSetup
  attr_reader :response,
              :full_request,
              :parser
  attr_accessor :game_started,
                :input,
                :verb,
                :parameter,
                :guess,
                :number,
                :guess_counter

  def initialize(parser, full_request)
    @parser = parser
    @full_request = full_request
    @input = input
    @verb = parser.verb
    @parameter = parameter
    @number = parser.server.number
    @guess_counter = parser.server.game_counter
  end

  def guess
    if full_request.include? "="
      # @guess_counter += 1
      full_request.split("?")[1].split("=")[1].to_i
    else
      0
    end
  end

  def sort_verb
    if verb.eql?('GET')
      get_response
    elsif verb.eql?('POST')
      go
    end
  end

  def get_response
    if !@response.nil?
      @response
    else
      current_number_of_guesses
    end
  end

  def go
    # binding.pry
    increase_count
    if guess < number
      @response = "<pre>
      <br/>Your guess is too low!
      <br/>Current number of guesses: #{@guess_counter}
      </pre>"
    elsif guess > number
      @response = "<pre>
      <br/>Your guess is too high!
      <br/>Current number of guesses: #{@guess_counter}
      </pre>"
    elsif guess.eql?(number)
      @response = "<pre>
      <br/>You guessed correctly!
      <br/>It took you this many tries: #{@guess_counter}
      </pre>"
      reset_variables
      @response
    else
      current_number_of_guesses
    end
  end

  def reset_variables
    parser.server.number = Random.rand(100)
    parser.server.game_counter = 1
  end

end