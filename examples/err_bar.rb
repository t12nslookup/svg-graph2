require 'SVG/Graph/ErrBar'

fields = %w(Jan Feb);
myarr1_mean = 10
myarr1_confidence = 1

myarr2_mean = 20
myarr2_confidence = 2

data= [myarr1_mean, myarr2_mean]

err_mesure = [myarr1_confidence, myarr2_confidence]

graph = SVG::Graph::ErrBar.new(
  :height => 500,
  :width => 600,
  :fields => fields,
  :stacked => :side,
  :errorBars => err_mesure,
  :scale_integers => false,
)

graph.add_data(
  :data => data,
  :title => 'Sales 2002'
)

File.open("err_bar.svg", "w") {|fout| 
  fout.print( graph.burn )
}