require 'SVG/Graph/Pie'

title = "Pie"
#data1 = []
#(rand(10)+5).times{
#  data1 << rand(20)
#  data1 << rand(20)
#}
data1 = [3, 11.2, 2.2, 5.4, 18.5, 7.6, 3, 2.2,]
#data2 = []
#(rand(10)+5).times{
#  data2 << rand(20)
#  data2 << rand(20)
#}
data2 = [4, 18, 3, 7, 8, 13, 19, 1,]

#data1 = [3]
#data2 = [2]

field = %w{jan feb mar apr may jun long_key_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aug}

graph = SVG::Graph::Pie.new( {
  :width => 640,
  :height => 300,
  :graph_title => title,
  :show_graph_title => true,
  :key => true,
  :key_position => :right, #:bottom, # or :right
  :fields => field,
  :show_data_labels => false,
  :show_actual_values => true,
  :show_shadow => true,
  :expanded => false,
  :expand_greatest => true
})
graph.add_data( 
  :data => data1,
  :title => "Dataset 1"
  )
graph.add_data( 
  :data => data2,
  :title => "Dataset 2"
  )
#puts graph.burn
File.open("pie.svg", "w") {|fout| 
  fout.print( graph.burn )
}
