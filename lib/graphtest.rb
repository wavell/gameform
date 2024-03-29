  require 'graphviz'

  # Create a new graph
  g = GraphViz.new( :G, :type => :digraph )

  # Create two nodes
  hello = g.add_node( "Hello" )
  world = g.add_node( "World" )

  # Create an edge between the two nodes
  g.add_edge( hello, world )

  # Generate output image
  g.output( :png => "hello_world.png" )