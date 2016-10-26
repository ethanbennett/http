require 'socket'
require 'pry'
require_relative 'parser'
require_relative 'output'

class Server
  attr_reader     :tcp_server, :client
  attr_accessor   :request_lines,
                  :counter

  def initialize
    @request_lines = []
    @counter = 0
    @tcp_server = TCPServer.new(9292)
  end

  def run
    loop do
      @client = tcp_server.accept
      @counter += 1
      parser = Parser.new(server_something, @counter )
      output = Output.new(client, parser, @request_lines)
      output.response_strings
      client.close
    end
  end
  
  def server_something
    request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
       @request_lines =  request_lines
       end
end


if __FILE__ == $0
  Server.new.run
end