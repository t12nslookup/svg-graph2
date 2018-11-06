require 'rexml/document'
require 'json'

module SVG
  module Graph

    # This class provides a lightweight generator for c3js based
    # svg graphs
    class C3js

      # @param js_chart_variable_name [String] a unique variable name representing
      #    the chart in javascript scope
      # @param js_chart_specification [String] see http://c3js.org/examples.html
      def initialize(js_chart_variable_name, js_chart_specification)
        @chart = js_chart_variable_name
        start_document()
        add_chart_spec(js_chart_specification)
      end # def initialize

      # @param javascript [String, Hash]
      # @raise
      # @example
      #   # see http://c3js.org/examples.html
      #   # since ruby 2.3 you can use string symbol keys:
      #   chart_spec = {
      #     # bindto is mandatory
      #     "bindto": "#this_is_my_awesom_graph",
      #     "data": {
      #       "columns": [
      #           ['data1', 30, 200, 100, 400, 150, 250],
      #           ['data2', 50, 20, 10, 40, 15, 25]
      #       ]
      #   }
      #   # otherwise simply write plain javascript into a heredoc string:
      #   chart_spec_string =<<-HEREDOC
      #   {
      #     // bindto is mandatory
      #     "bindto": "#this_is_my_awesom_graph",
      #     "data": {
      #       "columns": [
      #           ['data1', 30, 200, 100, 400, 150, 250],
      #           ['data2', 50, 20, 10, 40, 15, 25]
      #       ]
      #   }
      #   HEREDOC
      #   graph.add_chart_spec(chart_spec)
      #   # or
      #   graph.add_chart_spec(chart_spec_string)
      def add_chart_spec(javascript)
        if javascript.kind_of?(Hash)
          chart_spec = JSON(javascript)
        elsif javascript.kind_of?(String)
          chart_spec = javascript
        else
          raise "Unsupported argument type: #{javascript.class}"
        end
        # (.+?)" means non-greedy match up to next double quote
        if m = chart_spec.match(/"bindto":\s*"#(.+?)"/)
          @bindto = m[1]
        else
          raise "Missing chart specification is missing the mandatory \"bindto\" key/value pair."
        end

        inline_script = "var #{@chart} = c3.generate(#{chart_spec});"

        add_svg_element()
        add_javascript() {inline_script}

      end # def add_chart_spec

      # Appends a <script> node to the svg node, this can be used to add additional animations
      # but any script can also directly be part of the js_chart_specification in the #initialize method.
      # @param attrs [Hash] attributes for the <script> element. The following attribute
      #   is added by default:  type="text/javascript"
      # @yieldreturn [String] the actual javascript code to be added to the <script> element
      # @return [REXML::Element] the Element which was just added
      def add_javascript(attrs={}, &block)
        default_attrs = {"type" => "text/javascript"}
        attrs = default_attrs.merge(attrs)
        temp = REXML::Element.new("script")
        temp.add_attributes(attrs)
        @svg.add_element(temp)
        raise "Block argument is mandatory" unless block_given?
        script_content = block.call()
        cdata(script_content, temp)
      end # def add_javascript


      # @return [String] the complete html file
      def burn
        f = REXML::Formatters::Pretty.new(0)
        out = ''
        f.write(@doc, out)
        out
      end # def burn

      # Burns the graph but returns only the <svg> node as String without the
      # Doctype and XML / HTML Declaration. This allows easy integration into
      # existing xml/html documents.
      #
      # @return [String] the Div / SVG node into which the graph will be rendered
      #    by C3.js
      def burn_svg_only
        # initialize all instance variables by burning the graph
        burn
        f = REXML::Formatters::Pretty.new(0)
        f.compact = true
        out = ''
        f.write(@html, out)
        return out
      end # def burn_svg_only

      private
      def start_document
        # Base document
        @doc = REXML::Document.new
        @doc << REXML::XMLDecl.new("1.0", "UTF-8")
        @doc << REXML::DocType.new("html")
        # attribute xmlns is needed, otherwise the browser will only display raw xml
        # instead of rendering the page
        @html = @doc.add_element("html", {"xmlns" => 'http://www.w3.org/1999/xhtml'})
        @html << REXML::Comment.new( " "+"\\"*66 )
        @html << REXML::Comment.new( " Created with SVG::Graph - https://github.com/lumean/svg-graph2" )
        @head = @html.add_element("head")
        @body = @html.add_element("body")

        # insert js files
#        opts[:js].each do |js_path|
#          script = head.add_element("script", {"type" => "text/javascript"})
        @head.add_element("meta", {"charset" => "utf-8"})
        # note: script tags are not allowed in html to be self closed
        # but for xhtml this is ok. Thus add a space textnode to enforce closing tags.
        a = @head.add_element("script", {"type" => "text/javascript",
          "src" => "https://cdnjs.cloudflare.com/ajax/libs/d3/5.7.0/d3.min.js"})
        a.add_text(" ")
        # for inline css use "style"
        #@head.add_element("style", {"type" => "text/css"})
        # for external css use "link"
        @head.add_element("link", {"href" => "https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.8/c3.min.css",
          "rel" => "stylesheet"})

        a = @head.add_element("script", {"type" => "text/javascript",
          "src" => "https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.8/c3.min.js"})
        a.add_text(" ")
#          cdata(File.read(js_path), script)
#        end
      end # def start_svg

      #
      def add_svg_element(attrs={})
        if @bindto.to_s.empty?
          raise "#add_chart_spec needs to be called before the svg can be added"
        end
        @svg = @body.add_element("div", {"id" => @bindto})
      end

      # Surrounds CData tag with c-style comments to remain compatible with normal html.
      # This can be used to inline arbitrary javascript code and is compatible with many browsers.
      # Example /*<![CDATA[*/\n ...content ... \n/*]]>*/
      # @param str [String] the string to be enclosed in cdata
      # @param parent_element [REXML::Element] the element to which cdata should be added
      # @return [REXML::Element] parent_element
      def cdata(str, parent_element)
        # somehow there is a problem with CDATA, any text added after will automatically go into the CDATA
        # so we have do add a dummy node after the CDATA and then add the text.
        parent_element.add_text("/*")
        parent_element.add(REXML::CData.new("*/\n"+str+"\n/*"))
        parent_element.add(REXML::Comment.new("dummy comment to make c-style comments for cdata work"))
        parent_element.add_text("*/")
      end # def cdata

    end # class C3js

  end # module Graph
end # module SVG