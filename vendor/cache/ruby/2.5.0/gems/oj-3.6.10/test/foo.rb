#!/usr/bin/env ruby

$: << '.'
$: << '../lib'
$: << '../ext'

require 'oj'

Oj.default_options = {mode: :strict}
json = Oj.dump({ aggregations: { hashtags: { buckets: Array.new(100) { { key: 'foo', count: 100 } } } } }, mode: :strict)

def expect(a,b)
  puts "*** #{a} != #{b}" unless a == b
end

def dig(obj, *path)
  return obj if path.empty?
  
  if obj.is_a?(Array)
    obj.each { |v|
      r = dig(v, *path)
      return r unless r.nil?
    }
  end
  return nil unless obj.is_a?(Hash)
  
  dig(obj[path[0]], *path[1..-1])
end

1000.times do |i|
  Oj::Doc.open(json) do |doc|
    # this always passes
    doc.each_child('/aggregations/hashtags/buckets') do |bucket|
      expect(bucket.fetch('key'), 'foo')
      expect(bucket.fetch('count'), 100)
    end

    # load any other json using Oj.load
    # this will pass
    other = Oj.load(json)
    dig(other, 'aggregations', 'hashtags', 'buckets').each do |bucket|
      expect(bucket.fetch('key'), 'foo')
      expect(bucket.fetch('count'), 100)
    end
    GC.start
    doc.each_child('/aggregations/hashtags/buckets') do |bucket|
      # This is where it fails!!!! It will be some other object (even an rspec matcher in some cases)
      expect(bucket.fetch('key'), 'foo')
      expect(bucket.fetch('count'), 100)
    end

    # this always passes if it gets this far
    dig(other, 'aggregations', 'hashtags', 'buckets').each do |bucket|
      expect(bucket.fetch('key'), 'foo')
      expect(bucket.fetch('count'), 100)
    end
  end
end
