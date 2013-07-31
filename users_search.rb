#!/usr/bin/env ruby
# encoding : utf-8
require File.join File.dirname(__FILE__), 'extends/array'
require File.join File.dirname(__FILE__), 'user'
require File.join File.dirname(__FILE__), 'kdtree'

users = []
name = 0
(1..10).each do |age|
  (1..10).each do |weight|
    name += age * weight
    u = User.new(name, age, weight)
    puts "[#{u.name}, #{u.age}, #{u.weight}]"
    users << u
  end
end

users << User.new('еще один 67', 2, 3)
children = KDTree.new(users, [:age, :weight]).query age: 1..2,
                                                    weight: 2..3

puts "Найденны пользователи с именами #{children.map(&:name).join(', ')}"