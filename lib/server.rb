require 'socket'
require_relative 'parser'
require_relative 'output'

class Server
  attr_accessor   :request_lines,
                  :counter

  def initialize
    @request_lines = []
    @counter = 0
  end

  def run
    tcp_server = TCPServer.new(9292)
    loop do
      client = tcp_server.accept
      @counter += 1
      while line = client.gets and !line.chomp.empty?
        @request_lines << line.chomp
      end
      parser = Parser.new(@request_lines, @counter)
      output = Output.new(client, parser, @request_lines)
      output.response_strings
      client.close
    end
  end
end


if __FILE__ == $0
  Server.new.run
end