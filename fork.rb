#!/usr/bin/env ruby

require 'socket'

server = TCPServer.new('localhost', 9090)

loop do
	client = server.accept
	
	fork do
    client.recv(1024)
    client.send("HTTP/1.1 200 Ok\r\nConnection: close\r\n\r\n",0)
		client.close
	end
	
	client.close
end


