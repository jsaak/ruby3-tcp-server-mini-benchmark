#!/usr/bin/env ruby

def measure(params,result_start_with)
  command = "/usr/bin/wrk #{params} http://localhost:9090"
  puts command
  io = IO.popen(command, :err => STDOUT)
  r = io.read
  r.lines.each do |l|
    if l.start_with?(result_start_with)
      return l
    end
  end
end

loop do
  torun = "/usr/bin/env ruby #{ARGV[0]}"
  puts "spawn"
  pid = Process.spawn(torun, :out => STDOUT, :err => STDOUT)
  sleep 0.5
  next unless Process.waitpid(pid, Process::WNOHANG).nil?
  req = measure('-t1 -c1 -d1s','Requests/sec').split(/:/)[1].strip
  Process.kill("HUP", pid)
  puts "waiting for process to die"
  Process.waitpid(pid)
end

