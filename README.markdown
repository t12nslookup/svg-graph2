SVG::Graph
============

Description
-----------
This is an effort to revive the [SVG::Graph library](http://www.germane-software.com/software/SVG/SVG::Graph/) by Sean Russell. I'd also like to thank Claudio Bustos for giving me permissions to continue publishing the gem under it's original name.

[Changelog](../master/History.txt)

I'm maintaing in my free time, so I can't promise on any deadlines. Please notify me (via github messages or on the Issues section) if you find any bug.

Contribute
-----
Pull requests are very welcome :-)

Usage
-----

For a complete list of configuration options please have a look at the source - most important [Graph.rb](../master/lib/SVG/Graph/Graph.rb), also checkout the subclasses (Pie, Bar, etc.) as they might provide additional options.

In the following some examples to get you up to speed.

### Bar
```ruby
require 'svggraph'


```


### BarHorizontal

### ErrBar

### Line

### Pie

### Plot

### Schedule

### TimeSeries


Also have a look at the original [SVG::Graph web page](http://www.germane-software.com/software/SVG/SVG::Graph/), but note that this repository has already added some additional functionality, not available with the original.

Build
-----

* Build gem:
 *  gem build svg-graph.gemspec
* Install:
 *  gem install svg-graph-\<version>.gem
