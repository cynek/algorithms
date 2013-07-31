#!/usr/bin/env ruby
# encoding : utf-8
require File.join File.dirname(__FILE__), 'extends/fixnum'

K = 39
N = 100

def search(a, e)
  li, ri = 0, (a.size - 1)
  real_i = nil
  iterations_count = 0

  loop do
    iterations_count += 1

    i = ((li + ri) / 2).to_i
    real_i = (i - K) % N

    if e < a[real_i]
      ri = i - 1
    elsif e > a[real_i]
      li = i + 1
    else
      break
    end

    if li > ri
      real_i = nil
      break
    end
  end

  puts "Количество сравнений: #{Fixnum.comparsions_count}"
  puts "Количество итераций: #{iterations_count}"
  real_i
end

a = Array.new(N) {|i| i * 2 }.rotate(K)

puts "Исходный массив: #{a}"
puts "Введите искомый элемент"
e = STDIN.gets.to_i

index = search(a, e)
puts index ? "Индекс элемента: #{index}" : "Элемент не найден"