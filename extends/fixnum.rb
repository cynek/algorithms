class Fixnum
  @@comparsions_count = 0

  def self.comparsions_count
    @@comparsions_count
  end

  def <(value)
    @@comparsions_count += 1
    super
  end

  def >(value)
    @@comparsions_count += 1
    super
  end

  def ==(value)
    @@comparsions_count += 1
    super
  end
end