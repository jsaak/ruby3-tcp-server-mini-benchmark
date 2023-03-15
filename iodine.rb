#!/usr/bin/env ruby

require 'iodine'

class SimpleHTTP
  def self.on_message client, data
    client.write "HTTP/1.1 204 No Content\r\nConnection: close\r\n\r\n"
    client.close
  end
end

APP = Proc.new { SimpleHTTP }

Iodine.verbosity = 0
Iodine.listen service: :raw, handler: APP, port: "9090"
Iodine.threads = 1
Iodine.workers = 0
Iodine.start
