require 'eventmachine'

class EMServer < EM::Connection
  def receive_data(data)
    send_data("HTTP/1.1 204 No Content\r\nConnection: close\r\n\r\n")
    close_connection_after_writing
  end
end

EventMachine.run do
  # hit Control + C to stop
  Signal.trap("INT")  { EventMachine.stop }
  Signal.trap("TERM") { EventMachine.stop }

  EventMachine.start_server("127.0.0.1", 9090, EMServer)
end
