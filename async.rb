#!/usr/bin/env ruby

require 'async'
require 'async/io/tcp_socket'

Async do |task|
	server = Async::IO::TCPServer.new('localhost', 9090)
	
	loop do
		client, address = server.accept
		
		task.async do
      client.recv(1024)
      client.send("HTTP/1.1 204 No Content\r\nConnection: close\r\n\r\n")
      client.close
		end
	end
end
