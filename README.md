```
I copy pasted some ruby TCP echo servers from the internet and turned them to a minimal HTTP server.
Also I included a very simple c server too just for reference.

All servers were run on ruby 3.0.0p0
(installed with https://github.com/postmodern/ruby-install)
And then I benchmarked with $ wrk -t1 -c1 -d3s http://localhost:9090

We all know that this kind of benchmarks should not be taken very seriously!!

1. async-scheduler.rb latency was slow and erratic, I measured a whopping 1 second latency
2. libev-scheduler.rb is impressing me with sub ms latencies
3. polyphony.rb was very slow, clearly I am missing something here, if you know what please share!


Request/second (wrk -t1 -c1)

async-scheduler.rb: 15529.59
async.rb:           10148.64   
fork.rb:              950.23
select-fiber.rb:    16267.28
thread.rb:          13401.36
polyphony.rb:           1.00
libev-scheduler.rb: 16361.93
eventmachine.rb:    12611.89
simple.c:           21054.41


Latency (wrk -t3 -c6)      Avg     Stdev     Max   +/- Stdev

async-scheduler.rb:    58.64ms  173.49ms   1.02s      90.34%
async.rb:             399.90us   59.37us   1.02ms     73.58%
fork.rb:                7.17ms    2.41ms  21.40ms     75.75%
select-fiber.rb:      199.14us   42.44us 730.00us     78.72%
thread.rb:            329.97us   73.47us   2.20ms     85.81%
polyphony.rb            8.09ms   41.14ms 412.12ms     95.53%
libev-scheduler.rb     64.92us   33.26us 598.00us     94.93%
eventmachine.rb       125.52us   91.61us   2.94ms     95.39%
simple.c:              19.75us   28.40us 664.00us     97.34%



links:

https://rubyreferences.github.io/rubychanges/3.0.html#non-blocking-fiber-and-scheduler
https://www.codeotaku.com/journal/2018-11/fibers-are-the-right-solution/index
https://gist.github.com/bboe/6a7b03fcd110c4c6bbe5ec412f523428
https://github.com/socketry/async/blob/96f3d0ad9b64ad3658aed0108ef94308ed96c252/lib/async/scheduler.rb
https://github.com/dpc/benchmark-echo
https://github.com/wg/wrk
http://www.wjwh.eu/posts/2020-12-28-ruby-fiber-scheduler-c-extension.html

```

