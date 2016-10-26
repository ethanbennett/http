require 'socket'
require_relative 'parser'
require_relative 'output'

class Server

  def run
    tcp_server = TCPServer.new(9292)
    client = tcp_server.accept
    counter = 0
    @request_lines = []
    while line = client.gets and !line.chomp.empty?
      @request_lines << line.chomp
      counter += 1
    end
    
    parser = Parser.new(@request_lines)
    output = Output.new(client, parser, @request_lines)
    output.response
    client.close
  end
  a = Server.new
  a.run
end

# if __FILE__ == $0
# server = WebServer.new
# server.server_loop
# end