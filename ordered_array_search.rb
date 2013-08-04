#!/usr/bin/env ruby
# encoding : utf-8
require File.join File.dirname(__FILE__), 'extends/fixnum'

K = 39
N = 100

def search(a, e)
  l, r = 0, (a.size - 1)
  is_ordered = false
  iteration_count = 0

  loop do
    iteration_count += 1
    m = ((l + r) / 2).to_i
    return [m, iteration_count] if a[m] == e
    return [l, iteration_count] if a[l] == e

    if is_ordered || a[l] > a[m]  # упорядочена правая часть
      if is_ordered = e > a[m] && (is_ordered || e < a[l])
        l = m + 1                 # ищем справа
      else
        r = m - 1
      end
    else                          # упорядочена левая часть
      if is_ordered = e < a[m] && (is_ordered || e > a[l])
        r = m - 1                 # ищем слева
      else
        l = m + 1
      end
    end

    if l > r
      return [nil, iteration_count]
    end
  end
end

a = Array.new(N) {|i| i * 2 }.rotate(K)

puts "Исходный массив: #{a}"
puts "Введите искомый элемент"
e = STDIN.gets.to_i

index, iteration_count = search(a, e)
puts index ? "Индекс элемента: #{index}" : "Элемент не найден"
puts "Количество итераций #{iteration_count}"
puts "Количество сравнений: #{Fixnum.comparsions_count}"
