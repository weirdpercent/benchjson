require 'benchmark'
require 'json'
require 'json/ext'
require 'multi_json'
require 'oj'
require 'yajl'

def encode(msg, parser)
  case parser
    when :oj
      MultiJson.use(:oj)
      str = MultiJson.dump(msg)
    when :yajl
      MultiJson.use(:yajl)
      str = MultiJson.dump(msg)
    when :json
      MultiJson.use(:json_gem)
      str = MultiJson.dump(msg)
    when :ok
      MultiJson.use(:ok_json)
      str = MultiJson.dump(msg)
  end
  str
end

def decode(str, parser)
  msg = nil
  case parser
    when :oj
      MultiJson.use(:oj)
      str = MultiJson.load(str)
    when :yajl
      MultiJson.use(:yajl)
      str = MultiJson.load(str)
    when :json
      MultiJson.use(:json_gem)
      str = MultiJson.load(str)
    when :ok
      MultiJson.use(:ok_json)
      str = MultiJson.load(str)
  end
  msg
end

SAMPLES = 10_000
obj = {"a"=>"Alpha", "b"=>true, "c"=>12345, "d"=>[true, [false, [-123456789, nil], 3.9676, ["Something else.", false], nil]], "e"=>{"zero"=>nil, "one"=>1, "two"=>2, "three"=>[3], "four"=>[0, 1, 2, 3, 4]}, "f"=>nil, "h"=>{"a"=>{"b"=>{"c"=>{"d"=>{"e"=>{"f"=>{"g"=>nil}}}}}}}, "i"=>[[[[[[[nil]]]]]]]}
Benchmark.bm do |r|
  r.report('oj') do
    SAMPLES.times do
      decode(encode(obj, :oj), :oj)
    end
  end
  r.report('yajl') do
    SAMPLES.times do
      decode(encode(obj, :yajl), :yajl)
    end
  end
  r.report('json/ext') do
    SAMPLES.times do
      decode(encode(obj, :json), :json)
    end
  end
  r.report('okjson') do
    SAMPLES.times do
      decode(encode(obj, :ok), :ok)
    end
  end
end
