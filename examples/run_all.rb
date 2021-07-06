# executes all examples
#require 'svggraph'
require_relative '../lib/svggraph.rb'
require 'byebug'

puts SVG::Graph::VERSION

list = Dir.glob(File.expand_path("*.rb", __dir__))
list.delete File.expand_path(__FILE__)

list.each {|file|
  eval(File.read(file), binding, file)
}

