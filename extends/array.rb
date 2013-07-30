class Array
  def qsort_by(field)
    dup.qsort_by!(field)
  end

  def qsort_by!(field, l = 0, r = self.size - 1)
    i, j = l, r
    base_point = self[((l + r) / 2).to_i].send(field)
    loop do
      i += 1 while self[i].send(field) < base_point
      j -= 1 while self[j].send(field) > base_point

      if i <= j
        self[i], self[j] = self[j], self[i]
        i += 1
        j -= 1
      else
        break
      end
    end

    qsort_by!(field, l, j) if j > l
    qsort_by!(field, i, r) if i < r
    self
  end
end