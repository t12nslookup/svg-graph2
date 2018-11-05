require_relative '../lib/svggraph'
require 'minitest/autorun'
require 'minitest/reporters'

reporter_options = { :color => true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


class TestC3js < Minitest::Test

  def setup
    @bindto_id = "this_is_my_awesom_graph"
    @dataset1 = ['data1', 30, 200, 100, 400, 150, 250]
    @dataset2 = ['data2', 300, 20, 10, 40, 15, 25]

    #hash style
    @graph_data = {
      bindto: "##{@bindto_id}",
      data: {
        columns: [
          @dataset1,
          @dataset2
        ],
        axes: {
          data1: 'y',
          data2: 'y2',
        }
      },
      axis: {
        x: {
          label: 'X Label'
        },
        y: {
          label: {
            text: 'Y Axis Label',
            position: 'outer-middle'
          }
        },
        y2: {
          show: true,
          label: {
            text: 'Y2 Axis Label',
            position: 'outer-middle'
          }
        }
      },
      tooltip: {
    #   enabled: false
      },
      zoom: {
        enabled: true
      },
      subchart: {
        show: true
      }
    }
    #puts JSON.pretty_generate(@graph_data)
    @heredoc_chart =<<-HEREDOC
    {
      // bindto is mandatory
      "bindto": "##{@bindto_id}",
      "data": {
        "columns": [
            #{@dataset1},
            #{@dataset2}
        ],
        "axes": {
          "data1": "y",
          "data2": "y2"
        }
      },
      "axis": {
        "x": {
          "label": "X Label"
        },
        "y": {
          "label": {
            "text": "Y Axis Label",
            "position": "outer-middle"
          }
        },
        "y2": {
          "show": true,
          "label": {
            "text": "Y2 Axis Label",
            "position": "outer-middle"
          }
        }
      },
      "tooltip": {
      },
      "zoom": {
        "enabled": true
      },
      "subchart": {
        "show": true
      }
    }
    HEREDOC


  end # def setup

  # @param method_name [String]
  # @param output [String]
  # @return [void]
  def write_file(method_name, output)
    File.open(File.expand_path("c3js_#{method_name}.html", __dir__), "w+") do |f|
      f.write(output)
    end # File.open
  end

  def test_burn
    g = SVG::Graph::C3js.new("mychart1", @graph_data)
    write_file("hash_#{__method__}", g.burn)

    g = SVG::Graph::C3js.new("mychart1", @heredoc_chart)
    write_file("heredoc_#{__method__}", g.burn)
  end # def test_burn


  def test_burn_svg_only
    g = SVG::Graph::C3js.new("mychart1", @graph_data)
    write_file(__method__, g.burn_svg_only)
  end # def test_burn_svg_only

end # class TestC3js