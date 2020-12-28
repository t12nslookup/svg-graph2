# require 'SVG/Graph/BarHorizontal'

x_axis = ['1-10 very long label', '10-30 even longer', '30-50', '50-70', 'older']

options = {
  :width             => 640,
  :height            => 500,
  :stack             => :side,  # the stack option is valid for Bar graphs only
  :fields            => x_axis,
  :graph_title       => "kg per head and year chocolate consumption",
  :show_graph_title  => true,
  :show_x_title      => true,
  :x_title           => 'kg/year',
  :rotate_x_labels   => false,
  #:scale_divisions => 1,
  :scale_integers => true,
  :x_title_location  => :end,
  :show_y_title      => true,
  :rotate_y_labels   => 45,
  :stagger_y_labels  => true,
  :y_title           => 'Age in years',
  :y_title_location  => :middle,
  :add_popups        => true,
  :no_css            => true,
  :bar_gap           => true
}

data1   = [2, 4, 6.777, 4, 2.8]
data2 = [1, 5, 4, 5, 2.7]

g = SVG::Graph::BarHorizontal.new(options)

g.add_data( {
    :data => data1,
    :title => "Dataset1"
  })
g.add_data( {
    :data => data2,
    :title => "Dataset2"
  })

# graph.burn            # this returns a full valid xml document containing the graph
# graph.burn_svg_only   # this only returns the <svg>...</svg> node
output_filename = File.basename(__FILE__, ".rb")
if defined?(USE_FOR_TESTING)
  File.open(File.join(OUTPUT_FOLDER, "#{output_filename}.html"), "w") {|f| f.write(g.burn)}
else
  File.open(File.expand_path("#{output_filename}.svg",__dir__), 'w') {|f| f.write(g.burn_svg_only)} # for inclusion into readme.md
end

