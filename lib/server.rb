require 'socket'
require './lib/parser'
require './lib/output'

class Server
  attr_reader     :client
  attr_accessor   :counter,  :game_counter,
                  :looper,   :game_started,
                  :number
                  
  def initialize
    @counter        = 0
    @game_counter   = 1
    @tcp_server     = TCPServer.new(9292)
    @looper         = true
    @number         = Random.rand(100)
    @game_started   = false
  end

  def run
    while @looper == true
      @client = @tcp_server.accept
      requests
      client.close
    end
  end

  def requests
    @counter += 1
    @parser   = Parser.new(self, get_request)
    output    = Output.new(client, @parser, self)
    result(output)
  end

  def get_request
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line
    end
    request_lines
  end

  def result(output)
    output.response
    # @looper = false if @parser.paths.include?("Count: #{counter}")  # Comment this line out before running tests
  end
end

if __FILE__ == $0
  Server.new.run
end