require 'SVG/Graph/Bar'

x_axis = ['1-10', '10-30', '30-50', '50-70', 'older']

options = {  
  :width             => 640,
  :height            => 500,
  :stack             => :side,  # the stack option is valid for Bar graphs only
  :fields            => x_axis,
  :graph_title       => "kg per head and year chocolate consumption",
  :show_graph_title  => true,
  :show_x_title      => true,
  :x_title           => 'Age in years',
  :rotate_x_labels   => false,
  :x_title_location  => :end,
  :show_y_title      => true,
  :y_title           => 'kg/year',
  :y_title_location  => :end,
  :add_popups        => true,
  :no_css            => true
}

male_data   = [2, 4, 6, 4, 2]
female_data = [1, 5, 4, 5, 2.7]

g = SVG::Graph::Bar.new(options)

g.add_data( {
    :data => female_data,
    :title => "Female very very long legend which should be line shortened"
  })
g.add_data( {
    :data => male_data,
    :title => "Male"
  })

# graph.burn            # this returns a full valid xml document containing the graph  
# graph.burn_svg_only   # this only returns the <svg>...</svg> node
File.open('bar.svg', 'w') {|f| f.write(g.burn_svg_only)} # for inclusion into readme.md