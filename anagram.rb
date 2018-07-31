require './extends/array'

class String
  ALPHABET_SIZE = 26
  
  def anagram_hash_diff?(other)
    return false if self.size != other.size
    counter = Hash.new(0)

    self.each_byte do |byte|
      counter[byte] += 1
    end

    other.each_byte do |byte|
      return false if (counter[byte] -= 1) < 0
    end

    counter.values.all?(&:zero?)
  end

  def anagram_hash_comparing?(other)
    return false if self.size != other.size
    self_counter = Hash.new(0)

    self.each_byte do |byte|
      self_counter[byte] += 1
    end

    other_counter = Hash.new(0)

    other.each_byte do |byte|
      other_counter[byte] += 1
    end

    self_counter == other_counter
  end

  def anagram_digest?(other)
    return false if self.size != other.size
    digest(self) == digest(other)
  end

  def anagram_sort?(other)
    return false if self.size != other.size
    self.bytes.qsort_by!(:to_i) == other.bytes.qsort_by!(:to_i)
  end

  private

  def digest(target)
    target = target.downcase
    octet_size = target.size

    result = 0

    target.each_byte do |code|
      code = code - 97
      result += octet_size ** code
    end

    result
  end
end

require 'benchmark'

def benchmark_run
  comparing_strings = []
  
  1000.times.with_index do |i|
    comparing_strings << (0..i + 1).inject('') do |comparing_string, _|
      comparing_string << rand(String::ALPHABET_SIZE) + 97
    end
  end

  Benchmark.bm do |x|
    %i[anagram_hash_diff? anagram_hash_comparing? anagram_digest? anagram_sort?].each do |anagram_method|
      x.report(anagram_method) do
        comparing_strings.each do |comparing_string|
          comparing_string.public_send(anagram_method, comparing_string)
        end
      end
    end
  end
end
