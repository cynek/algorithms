require 'scanf'

class Graph
  FIXNUM_MAX = (2**(0.size * 8 -2) -1)

  attr_accessor :edges, :degree, :nvertices, :nedges, :directed

  def initialize(directed, wheighted)
    @nvertices = 0
    @nedges = 0
    @directed = directed
    @degree = Array.new
    @edges = []
  end

  def read
    @nvertices = scanf("Vertices count: %d")
    nedges = scanf("Edges count: %d")

    nedges.times do
      x, y, weight = scanf("%d %d %d")
      insert(x, y, weight)
    end
  end

  def insert(x, y, weight = FIXNUM_MAX, make_reverse = @directed)
    edge_node = EdgeNode.new(
      y,
      weight,
      edges[x]
    )

    @edges[x] = edge_node
    @degree[x] = (@degree[x] || 0) + 1

    if !make_reverse
      @nedges += 1
    else
      insert(y, x, weight, false)
    end
  end
end
