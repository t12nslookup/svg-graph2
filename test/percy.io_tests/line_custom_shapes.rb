# require 'SVG/Graph/Line'

title = "Line"
#data1 = []
#(rand(10)+5).times{
#  data1 << rand(20)
#  data1 << rand(20)
#}
data1 = [3, 11.2, 2.2, -5.4, 18.5, 7.6, 1.7, 11.8, 13.9, 9.11, 11.22, 2.33, 19.44, 0.555, 3.6666, 13.77777, 7.888888, 9.9999999]
#data2 = []
#(rand(10)+5).times{
#  data2 << rand(20)
#  data2 << rand(20)
#}
data2 = [4, 18, 3, 7, 8, 15, 13, 2, 9, -4, 18, 14, 10, 2, 11, 6, 14, 12, 15, 6, 4, 17, 2, 12]

data3 = [1,2,3,4,5,6,7,8,9,10,11,12]
data3_desc = %w{jan feb my_square apr may jun jul strike_test sept oct nov dec}
data3_shapes = ["square", "", "strike"] * 4
data3_urls = ["https://github.com"] * 12

field = %w{jan feb mar apr may jun jul aug}

DataPoint.configure_shape_criteria(
  [/square/, lambda{|x,y,line| ['polygon', {
      "points" => "#{x-4},#{y+4} #{x+4},#{y+4} #{x+4},#{y-4} #{x-4},#{y-4}",
      "class" => "dataPoint#{line}"
    }]
  }],
  [/strike/, lambda{|x,y,line| ['line', {
      "x1" => "#{x-4}",
      "y1" => y.to_s,
      "x2" => "#{x+4}",
      "y2" => y.to_s,
      "class" => "axis"
    }]
  },"OVERLAY"]
)

g = SVG::Graph::Line.new( {
  :width => 640,
  :height => 480,
  :graph_title => title,
  :show_graph_title => true,
  :key => true,
  :stacked => true,
  :fields => field,
  :area_fill => true,
  :scale_integers => false,
  #:min_scale_value => 1.5,
  :show_data_labels => true,
  :show_actual_values => false,
  :show_x_guidelines => true,
  :stagger_x_labels => true,
  :show_x_title => true,
  :x_title => "Time",
  :show_y_title => true,
  :y_title => "Ice Cream Cones",
  :y_title_text_direction => :bt,
  :rotate_y_labels   => true,
  :show_lines => false,
  :add_popups => true,
  :round_popups => false,
  :x_axis_position   => 5,
  :y_axis_position   => 'apr',
})

# test dataset with no title
g.add_data(
  :data => data1,
  :title => "Dataset 1"
  )

g.add_data(
  :data => data2,
  :title => "Dataset 2"
  )

g.add_data(
  :data => data3,
  :title => "Dataset 3",
  :description => data3_desc,
  :shape => data3_shapes,
  :url => data3_urls
  )
#puts graph.burn
output_filename = File.basename(__FILE__, ".rb")
if defined?(USE_FOR_TESTING)
  File.open(File.join(OUTPUT_FOLDER, "#{output_filename}.html"), "w") {|f| f.write(g.burn)}
else
  File.open(File.expand_path("#{output_filename}.svg",__dir__), 'w') {|f| f.write(g.burn_svg_only)} # for inclusion into readme.md
end
