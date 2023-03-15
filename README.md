```
I copy pasted some ruby TCP echo servers from the internet and turned them to a minimal HTTP server.
Also I included a very simple c server too just for reference.

You can run these benchamrk by installing the gems:
  - gem install async async-io eventmachine iodine polyphony
  - install wrk
  - then running benchmark.rb

We all know that this kind of benchmarks should not be taken very seriously!!


ruby 3.2.1 (2023-02-08 revision 31819e82c8) [x86_64-linux]
#1 SMP Debian 5.10.140-1 (2022-09-02) x86_64 GNU/Linux

Implementation       Req/sec  Latency:  Avg      Stdev     Max   +/- Stdev
async.rb             13570.99        280.50us  107.85us   1.38ms   88.28%
async-scheduler.rb   17833.02        187.17us  140.03us   1.25ms   91.48%
eventmachine.rb      14819.15        248.29us  252.58us   1.92ms   93.72%
fork.rb               1027.72          5.11ms    2.56ms  20.26ms   68.91%
iodine.rb            17651.42        134.65us   56.83us   0.88ms   78.14%
select-fiber.rb      20266.69        146.79us   53.83us 796.00us   85.38%
simple.c             22826.59         43.95us   40.71us   1.06ms   97.21%
thread.rb            17547.56        268.80us  158.26us   2.61ms   94.87%



links:

https://rubyreferences.github.io/rubychanges/3.0.html#non-blocking-fiber-and-scheduler
https://www.codeotaku.com/journal/2018-11/fibers-are-the-right-solution/index
https://gist.github.com/bboe/6a7b03fcd110c4c6bbe5ec412f523428
https://github.com/socketry/async/blob/96f3d0ad9b64ad3658aed0108ef94308ed96c252/lib/async/scheduler.rb
https://github.com/dpc/benchmark-echo
https://github.com/wg/wrk
http://www.wjwh.eu/posts/2020-12-28-ruby-fiber-scheduler-c-extension.html

```

