# require 'SVG/Graph/C3js'
require 'bigdecimal'

# phi is the golden ratio, very precise.  Why? - just because.
PHI = BigDecimal('1.61803398874989484820458683436563811772030917980576286213544862270')

# generalized fibonacci numbers
def fib(n)
  fib = (PHI**n - Math.cos(n*Math::PI)*PHI**(-n)) / BigDecimal('5').sqrt(20)
  fib.truncate(5).to_s('F')
end

# returns array containing the sequence as bigdecimal numbers
def seq(start, stop, step)
  b_start = BigDecimal(start)
  b_end = BigDecimal(stop)
  b_step = BigDecimal(step)
  steps = ((b_end - b_start) / b_step).ceil
  (0..steps).collect {|i| (b_start + i*b_step)}
end

start = '-4'
stop = '8'
x_axis = seq(start, stop, '0.1')
values = x_axis.map {|i| fib(i)}

chart_spec = <<-HEREDOC
var my_chart1 = c3.generate({
  // bindto is mandatory
  "bindto": "#my_funny_divtag",
  "data": {
    "x": "x",
    "columns": [
        #{x_axis.map{|i| i.to_s('F')}.insert(0, "x")},
        #{values.insert(0, "Fibonacci Numbers from #{start} to #{stop}")}
    ]
  },
  "axis": {
    "x": {
      "label": "Fibonacci index"
    },
    "y": {
      "label": {
        "text": "Generalized Fibonacci Number",
        "position": "outer-middle"
      }
    },
  },
  "tooltip": {
  },
  "zoom": {
    "enabled": true
  },
  "subchart": {
    "show": true
  },
  "size": {
    "width": 600,
    "height": 300
  }
});
HEREDOC

g = SVG::Graph::C3js.new()
g.add_chart_spec(chart_spec)
#puts g.burn

output_filename = File.basename(__FILE__, ".rb")
if defined?(USE_FOR_TESTING)
  File.open(File.join(OUTPUT_FOLDER, "#{output_filename}.html"), "w") {|f| f.write(g.burn)}
else
  File.open(File.expand_path("#{output_filename}.html",__dir__), 'w') {|f| f.write(g.burn)} # for inclusion into readme.md
end
