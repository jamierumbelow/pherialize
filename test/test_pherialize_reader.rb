lib = File.expand_path("../../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'minitest/autorun'
require 'pherialize'

class PherializeTest < MiniTest::Unit::TestCase
  TESTS = {
    'a:0:{}' => [ ], # test an empty array
    'i:5' => 5, # test an integer
  }
  
  i = 1
  
  TESTS.each do |php, obj|
    define_method "test_#{i}" do
      assert_equal obj, Pherialize.parse(php)
    end

    i += 1
  end
end