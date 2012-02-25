lib = File.expand_path("../../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'minitest/autorun'
require 'pherialize'

class PherializeTest < MiniTest::Unit::TestCase
  TESTS = {
    'a:0:{}' => [ ]
  }
  
  i = 1
  
  TESTS.each do |php, obj|
    define_method "test_#{i}" do
      assert_equal Pherialize.parse(php), obj
    end
  end
end