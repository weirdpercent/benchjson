benchjson
=========

**DISCLAIMER:** Benchmarks are not always reliable, the numbers vary, and many factors must be taken into account. I am new to benchmarking. If you are the maintainer of one of these projects and you disagree with my conclusions, please tell me why and I will gladly correct this documentation. I know developers often put a lot into testing and optimizing their code. I put these benchmarks together for my own education. If you are trying to decide which library to use, don't just take these numbers at face value, run your own tests. Each system is different.

           user     system      total        real
    oj  0.590000   0.000000   0.590000 (  0.627229)
    yajl  0.880000   0.000000   0.880000 (  0.949452)
    json/ext  0.880000   0.010000   0.890000 (  0.933510)

           user     system      total        real
    crack  9.870000   0.020000   9.890000 ( 10.563636)
    json/pure  1.990000   0.010000   2.000000 (  2.121778)
    okjson  5.270000   0.010000   5.280000 (  5.627293)

**SUBJECTIVE INTERPRETATION:** All but crack were run with multi_json. [Peter Ohler](http://www.ohler.com/dev/index.html) does indeed provide the fastest JSON parser in his [oj](http://www.ohler.com/oj/index.html) gem. If you can compile gems with C extensions, oj is the way to go. In testing which is the fastest pure ruby parser, json_pure wins.
