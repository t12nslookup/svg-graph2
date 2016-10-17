require 'SVG/Graph/Pie'

title = "Line"
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

field = %w{jan feb mar apr may jun julasdfasdfasdfasdfasdf_asdfasdf aug}

graph = SVG::Graph::Pie.new( {
  :width => 640,
  :height => 480,
  :graph_title => title,
  :show_graph_title => true,
  :key => true,
  :fields => field,
  :show_data_labels => true,
  :show_actual_values => true,
  :show_x_title => true,
  :x_title => "Time",
  :show_y_title => true,
  :y_title => "Ice Cream Cones",
  :y_title_text_direction => :bt,
  :show_lines => false,
  :add_popups => true,
  :round_popups => false
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
