# executes all examples
require 'svggraph'
puts SVG::Graph::VERSION

list = Dir.glob("*.rb")
list.delete __FILE__

list.each {|file|
  `ruby #{File.expand_path(file, __dir__)}`
}