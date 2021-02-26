require 'polyphony'

server = TCPServer.open('127.0.0.1', 9090)
#puts "pid #{Process.pid} Polyphony (#{Thread.current.backend.kind}) listening on port 9090"

#spin_loop(interval: 1) do
  #p Thread.current.fiber_scheduling_stats
#end

server.accept_loop do |client|
  spin do
    client.recv(1024)
    client.send("HTTP/1.1 204 No Content\r\nConnection: close\r\n\r\n")
    client.close
  end
end
