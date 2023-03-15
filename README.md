```
I copy pasted some ruby TCP echo servers from the internet and turned them to a minimal HTTP server.
Also I included a very simple c server too just for reference.

gem install async async-io eventmachine iodine libev_scheduler polyphony

You can run these benchamrk by installing the gems:
  - gem install async async-io eventmachine iodine polyphony
  - install wrk
  - then running benchmark.rb

We all know that this kind of benchmarks should not be taken very seriously!!


ruby 3.2.1 (2023-02-08 revision 31819e82c8) [x86_64-linux]
#1 SMP Debian 5.10.149-2 (2022-10-21) x86_64 GNU/Linux

Implementation       Req/sec  Latency:  Avg      Stdev     Max   +/- Stdev
async.rb              8110.25        487.21us  386.71us  10.09ms   93.30%
async-scheduler.rb   10411.65        364.85us  483.31us   9.72ms   95.09%
eventmachine.rb      10252.45        334.32us  272.18us   8.78ms   97.52%
fork.rb                434.42         13.23ms    4.15ms  35.90ms   72.72%
iodine.rb            10942.76        287.92us  158.09us   3.82ms   94.80%
select-fiber.rb      12640.04        428.13us  844.83us  12.11ms   93.22%
simple.c             14483.77        255.02us  620.55us  11.60ms   96.85%
thread.rb            10749.19        267.34us  275.75us   6.34ms   94.84%



links:

https://rubyreferences.github.io/rubychanges/3.0.html#non-blocking-fiber-and-scheduler
https://www.codeotaku.com/journal/2018-11/fibers-are-the-right-solution/index
https://gist.github.com/bboe/6a7b03fcd110c4c6bbe5ec412f523428
https://github.com/socketry/async/blob/96f3d0ad9b64ad3658aed0108ef94308ed96c252/lib/async/scheduler.rb
https://github.com/dpc/benchmark-echo
https://github.com/wg/wrk
http://www.wjwh.eu/posts/2020-12-28-ruby-fiber-scheduler-c-extension.html

```

