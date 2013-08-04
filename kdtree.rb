class KDTree
  attr_accessor :left, :right, :data, :field

  def initialize(points, fields, depth = 0)
    self.field = fields[(depth % fields.size) - 1]

    if points.size == 1
      self.data = points.first
      return
    end

    points.qsort_by!(field)
    median_index = (points.size / 2).to_i - 1

    self.data = points[median_index]

    self.left  = KDTree.new(points[0..median_index-1], fields, depth + 1) unless median_index < 1
    self.right = KDTree.new(points[median_index+1..-1], fields, depth + 1) unless median_index + 1 >= points.size
  end

  # Получение пользователей по диапазонам значений полей
  #
  # range - Hash диапазонов для каждого поля
  #
  # Returns Array
  def query(range = {})
    self.class._query(range, self)
  end

  private

  def self._query(range, node)
    field = node.field
    median = node.data.send(field)

    result = []
    result += _query(range, node.left) if node.left && median >= range[field].first
    result += _query(range, node.right) if node.right && (median <= range[field].last)

    if range.keys.all? {|field| range[field].include? node.data.send(field) }
      result << node.data
    end

    result
  end
end
