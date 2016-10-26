class Parser
  attr_reader   :host,    :verb,
                :path,    :protocol,
                :accept 

  def initialize(request_lines)
    @host          = request_lines[1].split(" ")[1]
    @verb          = request_lines[0].split(" ")[0]
    @path          = request_lines[0].split(" ")[1]
    @protocol      = request_lines[0].split(" ")[2]
    @accept        = request_lines[3..5]
  end
end