require 'socket'
require 'pry'
require_relative 'parser'
require_relative 'output'

class Server
  attr_reader     :tcp_server, :client
  attr_accessor   :counter

  def initialize
    @counter = 0
    @tcp_server = TCPServer.new(9292)
  end

  def run
    loop do
      @client = tcp_server.accept
      requests
      client.close
    end
  end

  def requests
    @counter += 1
    parser = Parser.new(get_request, @counter)
    output = Output.new(client, parser)
    result(output)
  end
  
  def get_request
    request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
    request_lines
  end

  def result(output)
    output.response_strings
  end

end


if __FILE__ == $0
  Server.new.run
end