```
I copy pasted some ruby TCP echo servers from the internet and turned them to a minimal HTTP server.
Also I included a very simple c server too just for reference.

All servers were run on ruby 3.0.0p0
(installed with https://github.com/postmodern/ruby-install)
And then I benchmarked with $ wrk -t1 -c1 -d3s http://localhost:9090

We all know that this kind of benchmarks should be not taken very seriously!!

However there were a couple of surprises for me:

1. polyphony.rb was very slow, and libev-scheduler did not even work.
Clearly I am missing something here, if you know what please share!

2. async-scheduler is also very slow, i am not sure what is happening there

The rest seems ok to me.


Request/second:

async-scheduler.rb:   176.07
async.rb:           10148.64
fork.rb:              950.23
select-fiber.rb:    16267.28
thread.rb:          13401.36
polyphony.rb:           1.00
libev-scheduler.rb:      n/a
eventmachine.rb:    12611.89
simple.c:           21054.41


links:

https://rubyreferences.github.io/rubychanges/3.0.html#non-blocking-fiber-and-scheduler
https://www.codeotaku.com/journal/2018-11/fibers-are-the-right-solution/index
https://gist.github.com/bboe/6a7b03fcd110c4c6bbe5ec412f523428
https://github.com/socketry/async/blob/96f3d0ad9b64ad3658aed0108ef94308ed96c252/lib/async/scheduler.rb
https://github.com/dpc/benchmark-echo
https://github.com/wg/wrk
http://www.wjwh.eu/posts/2020-12-28-ruby-fiber-scheduler-c-extension.html

```

