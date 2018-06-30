# Обход графа в ширину
# bread-first traversal
module BFS
  def bfs(g)
    g = g.dup
    s = g.edges.delete(1)
    states = Hash.new { 'undiscovered' }
    parents = Hash.new
    states[s] = 'discovered'
    queue = [s]
    while !queue.empty?
      u = queue.pop
      # process_edge_node(u)
    end
  end
end
