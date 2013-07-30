#!/usr/bin/env ruby
require File.join File.dirname(__FILE__), 'extends/array'

class UsersDTree # 2DTree
  attr_accessor :left, :right, :data, :field

  def initialize(points, depth = 0)
    self.field = depth.even? ? :age : :weight

    if points.size == 1
      self.data = points.first
      return
    end

    points.qsort_by!(field)
    median_index = (points.size / 2).to_i

    self.data = points[median_index]

    self.left  = UsersDTree.new(points[0..median_index-1], depth + 1) unless median_index < 1
    self.right = UsersDTree.new(points[median_index+1..-1], depth + 1) unless median_index+1 >= points.size
  end

  # Получение пользователей по диапазонам значений полей
  #
  # range - Hash диапазоны для каждого из полей
  #         age - Range
  #         weight - Range
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

class User
  attr_reader :name, :age, :weight

  def initialize(name, age, weight)
    @name = name
    @age = age
    @weight = weight
  end
end

users = []
10.times do |age|
  10.times do |weight|
    name = age * weight
    users << User.new(name, age, weight)
  end
end

users_tree = UsersDTree.new(users)
p users_tree.query(age: 0..1, weight: 2..3)