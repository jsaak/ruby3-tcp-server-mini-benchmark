```
I copy pasted some ruby TCP echo servers from the internet and turned them into a minimal HTTP server.
Also I included a very simple c server too just for reference.

You can run these benchamrk by installing the gems:
  - gem install async async-io eventmachine iodine polyphony
  - install wrk
  - then running benchmark.rb

We all know that these kind of benchmarks should not be taken very seriously!!


ruby 3.2.1 (2023-02-08 revision 31819e82c8) [x86_64-linux]
#1 SMP Debian 5.10.140-1 (2022-09-02) x86_64 GNU/Linux

Implementation       Req/sec  Latency:  Avg       Stdev     Max   +/- Stdev
async.rb             14058.97        277.54us   101.84us   1.24ms   88.93%
async-scheduler.rb   16676.26        205.68us   143.95us   2.45ms   91.08%
eventmachine.rb      14552.04        269.86us   276.41us   2.19ms   94.30%
fork.rb                942.20       5540.00us  2340.00us  19.47ms   72.41%
iodine.rb            16582.48        149.31us    71.66us   1.17ms   82.39%
polyphony.rb         14595.99       1230.00us  1278.00us 208.09ms   98.94%
select-fiber.rb      18808.93        155.08us    61.72us   1.00ms   83.35%
simple.c             22191.61         52.60us    44.99us   1.53ms   92.63%
thread.rb            17286.50        292.52us    93.22us   1.20ms   86.24%



links:

https://rubyreferences.github.io/rubychanges/3.0.html#non-blocking-fiber-and-scheduler
https://www.codeotaku.com/journal/2018-11/fibers-are-the-right-solution/index
https://gist.github.com/bboe/6a7b03fcd110c4c6bbe5ec412f523428
https://github.com/socketry/async/blob/96f3d0ad9b64ad3658aed0108ef94308ed96c252/lib/async/scheduler.rb
https://github.com/dpc/benchmark-echo
https://github.com/wg/wrk
http://www.wjwh.eu/posts/2020-12-28-ruby-fiber-scheduler-c-extension.html

```

