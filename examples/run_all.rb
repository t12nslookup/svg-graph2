# executes all examples
require 'svggraph'
puts SVG::Graph::VERSION

list = Dir.glob(File.expand_path("*.rb", __dir__))
list.delete File.expand_path(__FILE__)

list.each {|file|
  cmd = "ruby #{File.expand_path(file, __dir__)}"
  puts cmd
  puts `#{cmd}`
}
