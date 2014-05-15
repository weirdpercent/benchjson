require 'benchmark'
require 'crack/json'
require 'json'
require 'json/pure'
require 'multi_json'

def encode(msg, parser)
  case parser
    when :pure
      MultiJson.use(:json_pure)
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
    when :crack
      str = Crack::JSON.parse(str)
    when :pure
      MultiJson.use(:json_pure)
      str = MultiJson.load(str)
    when :ok
      MultiJson.use(:ok_json)
      str = MultiJson.load(str)
  end
  msg
end

SAMPLES = 10_000
obj = "{\"a\":\"Alpha\",\"b\":true,\"c\":12345,\"d\":[true,[false,[-123456789,null],3.9676,[\"Something else.\",false],null]],\"e\":{\"zero\":null,\"one\":1,\"two\":2,\"three\":[3],\"four\":[0,1,2,3,4]},\"f\":null,\"h\":{\"a\":{\"b\":{\"c\":{\"d\":{\"e\":{\"f\":{\"g\":null}}}}}}},\"i\":[[[[[[[null]]]]]]]}"
Benchmark.bm do |r|
  r.report('crack') do
    SAMPLES.times do
      decode(obj, :crack)
    end
  end
  r.report('pure') do
    SAMPLES.times do
      decode(encode(obj, :pure), :pure)
    end
  end
  r.report('okjson') do
    SAMPLES.times do
      decode(encode(obj, :ok), :ok)
    end
  end
end
