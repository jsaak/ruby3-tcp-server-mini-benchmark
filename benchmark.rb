#!/usr/bin/env ruby

require 'pp'

implementations = %w(
  async.rb
  async-scheduler.rb
  eventmachine.rb
  fork.rb
  iodine.rb
  select-fiber.rb
  simple.c
  thread.rb
)

#libev-scheduler.rb discontinued?
#polyphony.rb

#implementations = ['simple.c']

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

@result = []
implementations.each do |x|
  if x == 'simple.c'
    unless File.exist?('simple')
      command = 'gcc simple.c -o simple'
      puts command
      `#{command}`
    end
    torun = Dir.pwd + "/simple 9090"
  else
    torun = "/usr/bin/env ruby " + x
  end

  puts "spawn " + x
  pid = Process.spawn(torun, :out => STDOUT, :err => STDOUT)
  sleep 0.5
  next unless Process.waitpid(pid, Process::WNOHANG).nil?
  req = measure('-t1 -c1 -d3s','Requests/sec').split(/:/)[1].strip
  latency = measure('-t3 -c6 -d3s','    Latency')[14..-1]
  @result.push [x,req,latency]
  #if ['iodine.rb','async-scheduler.rb','polyphony.rb'].include? x
  if ['iodine.rb'].include? x
    Process.kill("TERM", pid)
  else
    Process.kill("HUP", pid)
  end
  puts "waiting for process to die"
  Process.waitpid(pid)
  #puts "sleeping for 70 sec, waiting for TIME_WAIT"
  #sleep 70
  tcp_conn_time_wait = `netstat -anl | grep 9090 | wc -l`.strip
  puts "done (#{tcp_conn_time_wait})"
end

puts
puts `ruby -v`
puts `uname -v -m -o`
puts
puts "Implementation       Req/sec  Latency:  Avg      Stdev     Max   +/- Stdev"
@result.each do |x,req,latency|
  print x.ljust(20,' ')
  print req.rjust(9,' ')
  print '        '
  print latency
end

#puts 'async ' + Gem.loaded_specs["async"].version.to_s
#puts 'eventmachine ' + Gem.loaded_specs["eventmachine"].version.to_s
