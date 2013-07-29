#!/usr/bin/env ruby
require File.join File.dirname(__FILE__), 'extends/fixnum'

K = 39
N = 100

def search(a, e)
  li, ri = 0, (a.size - 1)
  real_im = nil
  iterations_count = 0

  loop do
    iterations_count += 1
    im = ((li + ri) / 2).to_i
    real_im = (im - K) % N

    if e < a[real_im]
      ri = im
    elsif e > a[real_im]
      li = im
    else
      break
    end

    break if li == ri
  end

  puts "Индекс элемента: #{real_im}"
  puts "Количество сравнений: #{Fixnum.comparsions_count}"
  puts "Количество итераций: #{iterations_count}"
end

a = Array.new(N) {|i| i }.rotate(K)

puts "Исходный массив: #{a}"
puts "Введите искомый элемент"
e = STDIN.gets.to_i

search a, e