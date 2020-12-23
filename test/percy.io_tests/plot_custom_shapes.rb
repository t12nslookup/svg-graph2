# require 'SVG/Graph/Plot'

title = "Plot"
#data1 = []
#(rand(10)+5).times{
#  data1 << rand(20)
#  data1 << rand(20)
#}
data1 = [-6.1, 11.2, 0.3, 5.4, 18.5, 7.6, 1.7, 11.8, 13.9, 9.11, 11.22, 2.33, 19.44, 0.555, 3.6666, 13.77777, 7.888888, 9.9999999]
#data2 = []
#(rand(10)+5).times{
#  data2 << rand(20)
#  data2 << rand(20)
#}
data2 = [0,18, -2,4, 8,-2, -4,4, 9,4, 18,14, 10,2, 11,6, 14,12, 15,6, 4,17, 2,12]
data2_desc = %w{jan feb mar apr may jun jul aug sep oct nov dez}

data3 = [-2,1, -1,2, 0,3, 1,4, 2,5, 3,6, 4,7, 5,8, 6,9, 10,10, 11,11, 12,12]
data3_desc = %w{strike square square apr may jun jul aug sep oct nov dec}
data3_shapes = ["square", nil, "strike"] * 4
data3_urls = ["https://github.com"] * 12

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

g = SVG::Graph::Plot.new( {
  :width => 640,
  :height => 480,
  :graph_title => title,
  :show_graph_title => true,
  :no_css => false,
  :area_fill => true,
  :key => true,
  :scale_x_integers => true,
  :stagger_x_labels => false,
  :scale_y_integers => true,
  :min_x_value => 0,
  :min_y_value => 0,
  :show_data_labels => true,
  :show_x_guidelines => true,
  :show_x_title => true,
  :x_title => "Temperature in °C",
  :show_y_title => true,
  :y_title => "Ice Cream Cones",
  :y_title_text_direction => :bt,
  :show_lines => true,
  :add_popups => true,
  :round_popups => false,
  :stacked => false,
  :x_axis_position   => 0,
  :y_axis_position   => 0,
})

g.add_data(
  :data => data1,
  :title => "Dataset 1"
  )

g.add_data(
  :data => data2,
  :title => "Dataset 2",
  :description => data2_desc
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
