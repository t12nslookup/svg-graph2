# require 'SVG/Graph/Pie'

title = "Pie"
#data1 = []
#(rand(10)+5).times{
#  data1 << rand(20)
#  data1 << rand(20)
#}
data1 = [37, 0, 0, 0]
#data2 = []
#(rand(10)+5).times{
#  data2 << rand(20)
#  data2 << rand(20)
#}
data2 = [4, 0, 0, 0]

#data1 = [3]
#data2 = [2]

field = %w{jan feb mar apr may jun jul aug}

g = SVG::Graph::Pie.new( {
  :width => 640,
  :height => 300,
  :graph_title => title,
  :show_graph_title => true,
  :key => true,
  :key_position => :right, #:bottom, # or :right
  :fields => field,
  :show_data_labels => true,
  :show_actual_values => true,
  :show_shadow => true,
  :expanded => false,
  :expand_greatest => true
})
g.add_data(
  :data => data1,
  :title => "Dataset 1"
  )
g.add_data(
  :data => data2,
  :title => "Dataset 2"
  )
#puts graph.burn
output_filename = File.basename(__FILE__, ".rb")
if defined?(USE_FOR_TESTING)
  File.open(File.join(OUTPUT_FOLDER, "#{output_filename}.html"), "w") {|f| f.write(g.burn)}
else
  File.open(File.expand_path("#{output_filename}.svg",__dir__), 'w') {|f| f.write(g.burn_svg_only)} # for inclusion into readme.md
end
