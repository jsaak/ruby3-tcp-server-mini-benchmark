```
I copy pasted some ruby TCP echo servers from the internet and turned them to a minimal HTTP server.
Also I included a very simple c server too just for reference.

All servers were run on ruby 3.0.0p0
(installed with https://github.com/postmodern/ruby-install)
And then I benchmarked with $ wrk -t1 -c1 -d3s http://localhost:9090

We all know that this kind of benchmarks should not be taken very seriously!!

(async-scheduler.rb latency was slow and erratic, something is not right, i am not sure what)


Request/second (wrk -t1 -c1)

async-scheduler.rb: 25305.48
async.rb:           19461.61
fork.rb:              950.23
select-fiber.rb:    28331.37
thread.rb:          24135.52
polyphony.rb:       21679.29
libev-scheduler.rb: 25370.96
eventmachine.rb:    15376.89
simple.c:           31277.58


Latency (wrk -t3 -c6)      Avg     Stdev     Max   +/- Stdev

async-scheduler.rb:     3.03ms   14.63ms 217.58ms   94.82%
async.rb:               0.20ms    0.04ms   0.86ms   81.46%
fork.rb:                4.94ms    1.68ms  21.90ms   82.11%
select-fiber.rb:        0.01ms   30.50us   0.57ms   81.87%
thread.rb:              0.23ms  285.43us   2.47ms   93.08%
polyphony.rb            2.29ms   17.41ms 204.07ms   97.99%
libev-scheduler.rb      0.07ms   39.43us   0.89ms   88.08%
eventmachine.rb         0.20ms  223.19us   2.87ms   92.21%
simple.c:               0.03ms   32.78us   0.73ms   96.12%



links:

https://rubyreferences.github.io/rubychanges/3.0.html#non-blocking-fiber-and-scheduler
https://www.codeotaku.com/journal/2018-11/fibers-are-the-right-solution/index
https://gist.github.com/bboe/6a7b03fcd110c4c6bbe5ec412f523428
https://github.com/socketry/async/blob/96f3d0ad9b64ad3658aed0108ef94308ed96c252/lib/async/scheduler.rb
https://github.com/dpc/benchmark-echo
https://github.com/wg/wrk
http://www.wjwh.eu/posts/2020-12-28-ruby-fiber-scheduler-c-extension.html

```

