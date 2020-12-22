# require 'SVG/Graph/ErrBar'

fields = %w(Jan Feb);
myarr1_mean = 10
myarr1_confidence = 1

myarr2_mean = 20
myarr2_confidence = 2

data= [myarr1_mean, myarr2_mean]

err_mesure = [myarr1_confidence, myarr2_confidence]

g = SVG::Graph::ErrBar.new(
  :height => 500,
  :width => 600,
  :fields => fields,
  :stacked => :side,
  :errorBars => err_mesure,
  :scale_integers => false,
)

g.add_data(
  :data => data,
  :title => 'Sales 2002'
)


output_filename = File.basename(__FILE__, ".rb")
if defined?(USE_FOR_TESTING)
  File.open(File.join(OUTPUT_FOLDER, "#{output_filename}.html"), "w") {|f| f.write(g.burn)}
else
  File.open(File.expand_path("#{output_filename}.svg",__dir__), 'w') {|f| f.write(g.burn_svg_only)} # for inclusion into readme.md
end
